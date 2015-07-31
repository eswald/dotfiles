# Bash alias definitions
alias webshare='python -c "import SimpleHTTPServer; SimpleHTTPServer.test();"'
alias please='sudo $(history 2 | head -n 1 | sed -e "s/^ *[0-9]\+ \+//")'
alias rsync='rsync --partial --progress'
alias cd..='cd ..'
alias s='cd ..'
alias df='df -Th'

# Find a decent editor
if command -v vim > /dev/null 2>&1
then
  export EDITOR="vim"
fi

# Find a decent pager
if command -v less > /dev/null 2>&1
then
  # -F: Allow less to exit immediately when it can display everything on a single screen.
  # -i: Smart case when searching.
  # -n: Suppress line numbers, to speed up large files and buffers.
  # -R: Pass color escape sequences to the terminal.
  # -S: Chop long lines instead of wrapping; use arrow keys to see more.
  # -X: Don't initialize termcap, so the text doesn't disappear.
  export LESS=-FinRSX
  export PAGER="less $LESS"
elif command -v more > /dev/null 2>&1
then
  export PAGER="more"
else
  PAGER="cat"
fi

# Auto-paging aliases
alias psh="ps -eHOuser,vsize,pmem | $PAGER"
alias psc="ps xawf -eo pid,user,cgroup,args | $PAGER"

# Colorize and page tree output, by default.
if command -v tree > /dev/null 2>&1
then
  function tree {
    command tree -C "$@" | $PAGER
  }
elif command -v ddir > /dev/null 2>&1
then
  function tree {
    ddir -C "$@" | $PAGER
  }
fi

# Use an enhanced python when available,
# but keep it within the virtualenv.
if command -v ipython > /dev/null 2>&1
then
  alias ipy="python `which ipython`"
else
  alias ipy="python"
fi

if command -v gnome-open > /dev/null 2>&1
then
  alias open="gnome-open"
elif command -v xdg-open > /dev/null 2>&1
then
  alias open="xdg-open"
else
  alias open="$PAGER"
fi

# Use the silver search where available.
if command -v ag > /dev/null 2>&1
then
  alias ack='ag'
fi

# Find empty directories
function empties {
  find "$@" -type d -empty
}

# This shouldn't use 'command -v' lest it catch the alias below.
if which colordiff > /dev/null 2>&1
then
  alias cdiff=colordiff
else
  # Avoid breaking the version control aliases below
  alias colordiff='cat'
  alias cdiff='command diff'
fi

# Prefer icdiff over straight diff, when available.
# However, it can't handle directories or options.
# http://www.jefftk.com/icdiff
if command -v icdiff > /dev/null 2>&1
then
  function diff {
    if [ "$#" = 2 ] && [ -f "$1" ] && [ -f "$2" ]
    then
      command icdiff "$@" | $PAGER
    else
      cdiff -uwr "$@" | $PAGER
    fi
  }
else
  # Automatic paging and formatting for diffs
  function diff {
    command $cdiff -uwr "$@" | $PAGER
  }
fi

# `bzr` is a bit too hard to type.
complete -F _bzr -o default bar
function bar {
  case "$1" in
    view) shift; bzr visualize "$@" & ;;
    blame) shift; bzr annotate "$@" | $PAGER ;;
    diff) bzr "$@" | colordiff | $PAGER ;;
    help) bzr "$@" | $PAGER ;;
    log) bzr "$@" | $PAGER ;;
    st) bzr "$@" | $PAGER ;;
    *) bzr "$@" ;;
  esac
}

# Aliases and pagers for darcs.
function da {
  case "$1" in
    ci|commit) shift; darcs record --edit-long-comment "$@" ;;
    diff) shift; darcs diff -u "$@" | colordiff | $PAGER ;;
    log) shift; darcs changes "$@" | $PAGER ;;
    st*) shift; darcs whatsnew -ls "$@" | $PAGER ;;
    *) darcs "$@" ;;
  esac
}

# Automatic pager for certain subversion commands.
function svn {
  case "$1" in
    diff) command svn "$@" --no-diff-deleted | colordiff | $PAGER ;;
    less) shift; command svn cat "$@" | $PAGER ;;
    blame) command svn "$@" | $PAGER ;;
    help) command svn "$@" | $PAGER ;;
    log) command svn "$@" | $PAGER ;;
    st) command svn "$@" | $PAGER ;;
    *) command svn "$@" ;;
  esac
}

function legrep {
  egrep --color=yes "$@" | less -R
}

# Let me know when a long-running command has completed.
# Usage:
# > sleep 10; alert
if command -v notify-send > /dev/null 2>&1
then
  alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi

# "repeat" command, from Brian Fox.
# Usage: repeat 10 echo foo
function repeat {
  local count="$1" i
  shift
  for i in $(seq "$count")
  do
    # Don't use eval here; it destroys a layer of quoting.
    (exec "$@")
  done
}

# Print a sequence of numbers.
# Needed by `repeat()`, but might already exist.
if ! command -v seq > /dev/null 2>&1
then
  function seq {
    local lower upper
    lower=1
    upper="$1"
    
    if ! [ "$lower" -le "$upper" ]
    then
      return
    fi
    
    while [ "$lower" -lt "$upper" ]
    do
      echo $lower
      lower=$(($lower + 1))
    done
    
    echo $lower
  }
fi

# Canonical file name
# Used by the prompt command.
if ! command -v readlink > /dev/null 2>&1
then
  function readlink {
    if [ "$1" = "-f" ]
    then
      shift
    fi
    
    (cd "$1" && pwd)
  }
fi
