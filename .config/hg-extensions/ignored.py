# Mercurial extension to provide the 'hg ignored' command
#
# Copyright 2005-2010 Matt Mackall <mpm@selenic.com>
# and Eric Wald <eswald@brainshell.org>
#
# This software may be used and distributed according to the terms of the
# GNU General Public License version 2, incorporated herein by reference.

"lists ignored files and directories"

import os, stat
from mercurial.i18n import _
from mercurial import cmdutil, context, osutil, util

def ignored(ui, repo, *pats, **opts):
    """Print a list of ignored files"""
    # Distilled from mercurial.commands.status
    # and mercurial.localrepo.localrepository.status
    
    cwd = (pats and repo.getcwd()) or ''
    end = opts.get('print0') and '\0' or '\n'
    
    try:
        match = cmdutil.match
    except AttributeError:
        from mercurial.match import match
    
    files = status(repo.dirstate, match(repo, pats, opts))
    
    format = "%s" + end
    for f in sorted(files):
        ui.write(format % repo.pathto(f, cwd))

def status(dirstate, match):
    # Distilled from mercurial.dirstate.dirstate.status
    
    dmap = dirstate._map
    for fn in walk(dirstate, match):
        if fn not in dmap:
            if dirstate._dirignore(fn):
                yield fn

def walk(dirstate, match):
    '''
    walk recursively through the directory tree, finding all files
    matched by the match function
    '''
    
    # Distilled from mercurial.dirstate.dirstate.walk
    
    def fwarn(f, msg):
        dirstate._ui.warn('%s: %s\n' % (dirstate.pathto(f), msg))
        return False
    
    def badtype(mode):
        kind = _('unknown')
        if stat.S_ISCHR(mode): kind = _('character device')
        elif stat.S_ISBLK(mode): kind = _('block device')
        elif stat.S_ISFIFO(mode): kind = _('fifo')
        elif stat.S_ISSOCK(mode): kind = _('socket')
        elif stat.S_ISDIR(mode): kind = _('directory')
        return _('unsupported file type (type is %s)') % kind
    
    ignore = util.never
    dirignore = util.never
    
    matchfn = match.matchfn
    badfn = match.bad
    dmap = dirstate._map
    normpath = util.normpath
    listdir = osutil.listdir
    lstat = os.lstat
    getkind = stat.S_IFMT
    dirkind = stat.S_IFDIR
    regkind = stat.S_IFREG
    lnkkind = stat.S_IFLNK
    join = dirstate._join
    work = []
    wadd = work.append
    
    if dirstate._checkcase:
        normalize = dirstate._normalize
    else:
        normalize = lambda x, y: x
    
    skipstep3 = False
    if matchfn == match.exact: # match.exact
        dirignore = util.always # skip step 2
    
    files = set(match.files())
    if not files or '.' in files:
        files = ['']
    results = {'.hg': None}
    
    # step 1: find all explicit files
    for ff in sorted(files):
        nf = normalize(normpath(ff), False)
        if nf in results:
            continue
        
        try:
            st = lstat(join(nf))
            kind = getkind(st.st_mode)
            if kind == dirkind:
                skipstep3 = False
                if nf in dmap:
                    #file deleted on disk but still in dirstate
                    results[nf] = None
                match.dir(nf)
                if not dirignore(nf):
                    wadd(nf)
            elif kind == regkind or kind == lnkkind:
                results[nf] = st
            else:
                badfn(ff, badtype(kind))
                if nf in dmap:
                    results[nf] = None
        except OSError, inst:
            if nf in dmap: # does it exactly match a file?
                results[nf] = None
            else: # does it match a directory?
                prefix = nf + "/"
                for fn in dmap:
                    if fn.startswith(prefix):
                        match.dir(nf)
                        skipstep3 = False
                        break
                else:
                    badfn(ff, inst.strerror)
    
    # step 2: visit subdirectories
    while work:
        nd = work.pop()
        skip = None
        if nd == '.':
            nd = ''
        else:
            skip = '.hg'
        try:
            entries = listdir(join(nd), stat=True, skip=skip)
        except OSError, inst:
            if inst.errno == errno.EACCES:
                fwarn(nd, inst.strerror)
                continue
            raise
        for f, kind, st in entries:
            nf = normalize(nd and (nd + "/" + f) or f, True)
            if nf not in results:
                if kind == dirkind:
                    if not ignore(nf):
                        match.dir(nf)
                        if any(f.startswith(nf+"/") for f in dmap):
                            wadd(nf)
                        else:
                            results[nf+"/"] = None
                    if nf in dmap and matchfn(nf):
                        results[nf] = None
                elif kind == regkind or kind == lnkkind:
                    if nf in dmap:
                        if matchfn(nf):
                            results[nf] = st
                    elif matchfn(nf) and not ignore(nf):
                        results[nf] = st
                elif nf in dmap and matchfn(nf):
                    results[nf] = None
    
    del results['.hg']
    return results

cmdtable = {
    "ignored": (ignored, [], _("hg ignored"))
}
