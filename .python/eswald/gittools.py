r'''Personalized tools for working with git repositories.
    Includes support for my git-df and git-ci commands.
'''#"""#'''

from __future__ import with_statement

try:
    import json
except ImportError:
    import simplejson as json

import sys
from hashlib import md5
from plumbum.cmd import git
from plumbum import ProcessExecutionError, local

def findroot():
    # Find the git directory and cache filename.
    gitroot = local.cwd
    while True:
        gitdir = gitroot/".git"
        if gitdir.isdir():
            break
        if gitroot.up() == gitroot:
            print "fatal: Not a git repository (or any of the parent directories): .git"
            sys.exit(1)
        gitroot = gitroot.up()
    return gitroot, gitdir/"info/df-digest"

def digests(gitroot, params):
    try:
        status = git["status", "-z", "-uno"][params]()
    except ProcessExecutionError:
        # Ignore errors at this stage.
        # Just tell git ci not to add anything.
        return {}
    
    with local.cwd(gitroot):
        checksums = {}
        for line in status.split("\0"):
            if not line:
                continue
            
            if line[0] != " ":
                # Something has been deliberately cached.
                # Don't auto-commit anything else.
                checksums.clear()
                break
            
            if line[1] == "D":
                # This file has been deleted.
                # We might be able to auto-commit, but don't count on it.
                checksums.clear()
                break
            
            filename = line[3:]
            checksums[filename] = md5(open(filename).read()).hexdigest()
    return checksums

def readcache(params):
    # Read the cache file
    gitroot, cachefile = findroot()
    result = gitroot, params, []
    if not cachefile.exists():
        # git df hasn't been run yet.
        return result
    
    cache = json.load(open(str(cachefile)))
    if params and params != cache["params"]:
        # git ci was run with a different set of parameters.
        return result
    
    params = cache["params"]
    checksums = digests(gitroot, params)
    if checksums != cache["digests"]:
        # Something has changed; don't add files automatically.
        return result
    
    # Return the cached parameters, so only the selected files/trees get committed.
    return gitroot, params, checksums.keys()
