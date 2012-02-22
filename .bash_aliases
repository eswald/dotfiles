# Bash alias definitions
alias psh='ps -eHOuser,vsize,pmem | less -S'
alias webshare='python -c "import SimpleHTTPServer; SimpleHTTPServer.test();"'
alias grep="grep --color=auto"
alias please='sudo $(history 2 | head -n 1 | sed -e "s/^ *[0-9]\+ \+//")'
alias rsync='rsync --partial --progress'
alias cd..='cd ..'
alias s='cd ..'
alias df='df -Th'

# Use an enhanced python when available,
# but keep it within the virtualenv.
if which ipython > /dev/null 2>&1
then
  alias ipy="python `which ipython`"
else
  alias ipy="python"
fi

if command -v gnome-open > /dev/null
then
  alias open="gnome-open"
elif command -v xdg-open > /dev/null
then
  alias open="xdg-open"
else
  alias open="less"
fi

# Debian uses "ack" for an entirely different command.
if which ack-grep > /dev/null 2>&1
then
  alias ack='ack-grep'
fi

# Find empty directories
function empties {
  find "$@" -type d -empty
}

if which colordiff > /dev/null 2>&1
then
  # Automatic colorization and paging for diffs
  function diff {
    colordiff -uwr "$@" | less -FiRS
  }
else
  # Avoid breaking the version control aliases below
  alias colordiff='cat'
  
  # Automatic paging and formatting for diffs
  function diff {
    /usr/bin/diff -uw "$@" | less -FiRS
  }
fi

# `bzr` is a bit too hard to type.
complete -F _bzr -o default bar
function bar {
  case "$1" in
    view) shift; bzr visualize "$@" & ;;
    blame) shift; bzr annotate "$@" | less -FiSn ;;
    diff) bzr "$@" | colordiff | less -FiRSn ;;
    help) bzr "$@" | less -FiRSn ;;
    log) bzr "$@" | less -FiRSn ;;
    st) bzr "$@" | less -FiRSn ;;
    *) bzr "$@" ;;
  esac
}

# Automatic pager for certain subversion commands.
function svn {
  case "$1" in
    diff) /usr/bin/svn "$@" --no-diff-deleted | colordiff | less -FiRSn ;;
    less) shift; /usr/bin/svn cat "$@" | less -FiRSn ;;
    blame) /usr/bin/svn "$@" | less -FiSn ;;
    help) /usr/bin/svn "$@" | less -FiSn ;;
    log) /usr/bin/svn "$@" | less -Fn ;;
    st) /usr/bin/svn "$@" | less -Fn ;;
    *) /usr/bin/svn "$@" ;;
  esac
}

function legrep {
  egrep --color=yes "$@" | less -R
}

extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) tar xvjf $1 ;;
      *.tar.gz) tar xvzf $1 ;;
      *.bz2) bunzip2 $1 ;;
      *.rar) rar x $1 ;;
      *.gz) gunzip $1 ;;
      *.tar) tar xvf $1 ;;
      *.tbz2) tar xvjf $1 ;;
      *.tgz) tar xvzf $1 ;;
      *.zip) unzip $1 ;;
      *.jar) unzip $1 ;;
      *.Z) uncompress $1 ;;
      *.7z) 7z x $1 ;;
      *) echo "Don't know how to extract '$1'" ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}
