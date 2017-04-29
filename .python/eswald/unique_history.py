#!/usr/bin/python
# Original by Jean-Louis Fuchs:
# http://ganwellresource.blogspot.com/2012/09/bash-history-of-unique-commands.html

import os
import fcntl
import shutil
import sys

def run(args):
    if args:
        bash_file = args.pop(0)
    else:
        # Todo: Check the environment for HISTFILE
        bash_file = os.path.expanduser('~/.bash_history')
    
    if args:
        eternal = args.pop(0)
    else:
        eternal = os.path.expanduser('~/.cache/bash_history')
    
    try:
        return mergelines(eternal, bash_file)
    except Exception:
        errtype, err, traceback = sys.exc_info()
        print err
        return 1

def mergelines(eternal, bash_file):
    # Read the collected unique history lines.
    try:
        f = open(eternal, 'r')
        lines = list(f.readlines())
        f.close()
    except IOError:
        # No such file
        lines = []
    
    myset = set(lines)
    
    # Append the current bash history file.
    f = open(bash_file, 'r')
    lines.extend(f.readlines())
    f.close()
    
    # Check for new lines.
    lineset = set(lines)
    diff = lineset - myset
    if len(diff) == 0:
        # No new lines to worry about.
        # We could re-arrange the history file, but it's not worthwhile.
        return 42
    
    # Collect the unique lines in historical order.
    # Append and reverse appears to be faster than prepending.
    newlist = []
    lines.reverse()
    for line in lines:
        if line in lineset:
            if '\x00' in line or '\x03' in line or '\x1A' in line:
                # A sudden power outage corrupted the history file.
                # This doesn't weed out everything, but it takes care of the bulk.
                continue
            newlist.append(line)
            lineset.remove(line)
    newlist.reverse()
    
    # Write the history lines back out.
    # Use a file lock to avoid corruption on script contention.
    tmpname = eternal + '~'
    f = open(tmpname, 'w')
    fcntl.flock(f.fileno(), fcntl.LOCK_EX)
    f.writelines(newlist)
    fcntl.flock(f.fileno(), fcntl.LOCK_UN)
    f.close()
    os.rename(tmpname, eternal)
    
    # Replace the bash history file
    shutil.copyfile(eternal, bash_file)
    
    if not myset:
        # The history file was created from scratch.
        # This shell probably hasn't run any commands yet,
        # so don't indicate a new history line.
        return 65
    
    # Return success to indicate a new history line.
    return 0

if __name__ == "__main__":
    sys.exit(run(sys.argv[1:]))
