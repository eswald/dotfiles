#!/usr/bin/python

# =============================================================================
#
#    hg-autosync - Mercurial autosync extension
#    Copyright (C) 2009 Oben Sonne <obensonne@googlemail.com>
#
#    This file is part of hg-autosync.
#
#    hg-autosync is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    hg-autosync is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with hg-autosync. If not, see <http://www.gnu.org/licenses/>.
#
# =============================================================================

"""automated duplex synchronization with another repository

The idea of this extension is to use Mercurial as a synchronization engine to
keep files in sync across work stations.

This extension provides the `autosync` command which automatically and
continuously commits working copy changes, fetches (pull, merge, commit)
changes from another repository and pushes local changes back to the other
repository.

Website: http://bitbucket.org/obensonne/hg-autosync

Requires Mercurial >= 1.3.1 

The test script `tests/test-autosync` can either be executed directly or used
within the Mercurial testing suite.

"""

from datetime import datetime
import os.path
import subprocess
import time

from mercurial import hg
from mercurial import commands
from mercurial import cmdutil
from mercurial import error
from mercurial import util
from hgext.fetch import fetch
from hgext.fetch import cmdtable as fetch_ct

# =============================================================================
# constants
# =============================================================================

ALERTER = ".hgalert" # alert tool to run on errors (rel. to repo root)
LOGFILE = os.path.join(".hg", "autosync.log") # daemon log (rel. to repo root)

# =============================================================================
# utility functions
# =============================================================================

def _cmdopts(cte, ouropts):
    """Build options dictionary for a command.
    
    Option names are read from the given command table entry. Option values are
    those set in `ouropts` or the defaults set in the command table entry.
    
    """
    cmdopts = {}
    for optdesc in cte[1]:
        key = optdesc[1].replace("-", "_")
        cmdopts[key] = ouropts.get(key, optdesc[2])
    return cmdopts

def _alert(ui, repo, error):
    """Run the alert program, if defined."""
    
    alert = repo.ui.config("autosync", "alert")
    if alert:
        alert = util.expandpath(alert)
        try:
            subprocess.call([alert, repo.root, str(error)])
        except OSError, e:
            ui.warn("sync: failed to run alert tool %s (%s)" % (alert, e))

def _cycle(ui, root, commitopts, fetchopts, pushopts):
    """Run a single 'commit, fetch, push' cycle"""

    repo = hg.repository(ui, path=root)
    ui.status("sync: commit working copy changes\n")
    commands.commit(ui, repo, **commitopts)
    ui.status("sync: fetch changes from other repository\n")
    fetch(ui, repo, **fetchopts)
    ui.status("sync: push local changes to other repository\n")
    commands.push(ui, repo, **pushopts)

def _sync(ui, repo, other, opts):
    """Synchronize once or continuously, depending on `opts`."""
    
    # check options
    
    if opts["interval"] < 1:
        raise util.Abort("interval must be a positive number")
    
    if not repo.changelog:
        raise util.Abort("initial repository, first change should get pulled "
                         "or committed manually")
        
    # set up options for sub-commands
    
    commitopts = _cmdopts(commands.table["^commit|ci"], opts)
    commitopts["message"] = "Automated commit"
    fetchopts = _cmdopts(fetch_ct["fetch"], opts)
    fetchopts["message"] = "Automated merge"
    fetchopts["switch_parent"] = True
    fetchopts["source"] = other
    pushopts = _cmdopts(commands.table["^push"], opts)
    pushopts["dest"] = other
    
    # force non-interactive merge (unless defined otherwise in autosync->merge)

    automerge = repo.ui.config("autosync", "merge")
    os.environ["HGMERGE"] = automerge or "internal:merge"
    
    # run one synchronization cycle only ?
    
    if opts["once"]:
        _cycle(ui, repo.root, commitopts, fetchopts, pushopts)
        return
    
    # loop synchronization cycles !
    
    while True:
        ts = datetime.strftime(datetime.now(), "%x %X")
        ui.write("%s\n" % (" %s " % ts).center(79, "-"))
        try:
            _cycle(ui, repo.root, commitopts, fetchopts, pushopts)
        except (util.Abort, error.RepoError), e:
            ui.warn("%s\n" % e)
            ui.warn("sync: an error occurred, will retry at next interval\n")
            _alert(ui, repo, e)
        finally:
            ui.flush()
        time.sleep(opts["interval"])

# =============================================================================
# extension interface
# =============================================================================

def autosync(ui, repo, other="default", **opts):
    """commit, fetch and push at regular intervals 
    
    Commit changes in the working copy, fetch (pull, merge and commit) changes
    from another repository and push local changes back to the other repository
    - either continuously (default) or once only.
    
    The idea of this command is to use Mercurial as a synchronization engine
    to keep files in sync across work stations. Think of configuration files or
    to-do lists as examples for things to synchronize. On a higher level this
    command not only synchronizes repositories but working copies. A central
    repository (usually without a working copy) must be used as synchronization
    hub:
    
    repo1 <--sync--> hub <--sync--> repo2
    
    Running this command in repo1 and repo2 ensures the working copies (!) of
    both repositories stay in sync (as long as they are no conflicting
    changes).

    HGRC configruation:
    
    [autosync]
    merge = <merger>
    alert = <alert-tool>
    
    By default Mercurial's internal non-interactive merge is used when fetching
    from another repository. This can be changed with the `merge` option.
    Errors and merge conflicts which cannot be resolved automatically are
    highlighted in the output. Additionally, if option `alert` is defined, the
    corresponding tool is called. This tool is supposed to notify problems to a
    human. The repository path and an error message are passed as arguments to
    the alert tool. Independent of these options, autosync keeps running when
    there are problems and retries after the next interval, hoping things get
    fixed externally.
    
    When running in daemon mode, any output gets logged into the file
    `autosync.log` within the repository's `.hg` directory (use --daemon-log
    to set a different file).
    
    This command denies to run in a virgin repository as this may unrelate
    repositories which were supposed to get synchronized. Before running
    autosync, pull or commit something first manually.
    
    """
    runfn = lambda: _sync(ui, repo, other, opts)
    if not opts["daemon"]:
        logfile = None
    elif opts["daemon_log"] == LOGFILE:
        logfile = os.path.join(repo.root, LOGFILE)
    else:
        logfile = opts["daemon_log"]
    cmdutil.service(opts, runfn=runfn, logfile=logfile)
    
# =============================================================================
# command table
# =============================================================================

cmdtable = {
    "autosync": (autosync,
        [("A", "addremove", False,
          "automatically synchronize new/missing files"),
         ("i", "interval", 600, "synchronization interval in seconds"),
         ("o", "once", False, "synchronize once only, don't loop"),
         # daemon options
         ("D", "daemon", False, "run in background"),
         ("", "daemon-log", LOGFILE, "log file for daemon mode"),
         ("", "daemon-pipefds", "", "used internally by daemon mode"),
         ("", "pid-file", "", "name of file to write process ID to"),
        ]  + commands.commitopts2 + commands.remoteopts,
        "[-A] [-i] [-D] ... [OTHER]   (sync continuously)\n"
        "hg autosync [-A] -o ... [OTHER]          (sync once)")
}

