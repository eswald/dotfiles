# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -f /etc/bashrc ]
then
  . /etc/bashrc
fi

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore entries that start with spaces.
export HISTCONTROL=ignoreboth
# ... or simply erase previous identical lines.
export HISTCONTROL=ignorespace:erasedups
# Ignore some controlling instructions, too.
export HISTIGNORE="[ 	]*:&:bg:fg:exit:ls:cd:rm*"

# Truly massive history file
export HISTFILESIZE=65536
# Not quite so massive history memory
export HISTSIZE=4096
# Preserve previous entries in the history file
shopt -s histappend

# Until I'm better at history substitution, edit first
shopt -s histverify

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"
[ -x /usr/bin/lessfilter ] && export LESSOPEN='|lessfilter %s'
#export LESSCHARSET=iso8859

# Install Ruby gems locally
if [ -d "$HOME/.cache/rubygems" ]
then
  export GEM_HOME=~/.cache/rubygems
  PATH="$PATH:$HOME/.cache/rubygems/bin"
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lh'
alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix
then
  if [ -f /etc/bash_completion ]
  then
    . /etc/bash_completion
  elif [ -f /usr/share/bash-completion/bash_completion ]
  then
    . /usr/share/bash-completion/bash_completion
  elif [ -d /etc/bash_completion.d ]
  then
    # Missing the main bash completion file,
    # but we can at least use any available.
    for file in /etc/bash_completion.d/*
    do
      . "$file"
    done
  fi
fi

# Source any custom completion files.
if [ -d ~/.config/bash ]
then
  # The GLOBIGNORE set below can interfere with this glob.
  unset GLOBIGNORE
  for file in ~/.config/bash/*.sh
  do
    . $file
  done
fi

#export NNTPSERVER=news.readfreenews.net:120
#export NNTPSERVER=aioe.cjb.net

# Allow directory changes directly to another tree
# Do NOT export this variable.
#CDPATH=.:~

# Allow these shell options to work in all interactive shells
shopt -s cdspell    # correct minor spelling errors in 'cd' arguments
shopt -s cmdhist    # save multi-line commands as a single history entry
# shopt -s dotglob  # include hidden '.' files in filename expansion
shopt -s extglob    # allows ?(), *(), +(), @(), !() in path expansion

# Safer shell globbing.
# http://www.dwheeler.com/essays/fixing-unix-linux-filenames.html
# Ignores hidden files, paths with control characters, and paths beginning with hyphens.
# If you want a glob to return files beginning with hyphens, use ./* instead of *
# Doesn't check for proper UTF-8 sequences, though.
#GLOBIGNORE=$(printf '.[!/.]*:..[!/]*:*/.[!/.]*:*/..[!/]*:*[\001-\037\177]*:-*')
