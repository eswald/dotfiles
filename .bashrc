# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore entries that start with spaces.
export HISTCONTROL=ignoreboth
# ... or simply erase previous identical lines.
export HISTCONTROL=ignorespace:erasedups
# Ignore some controlling instructions, too.
export HISTIGNORE="[ 	]*:&:bg:fg:exit:ls:cd"

# Eternal history
# PROMPT_COMMAND='echo $$ $USER "$(history 1)" >> ~/.bash_eternal'

# Write history constantly
# PROMPT_COMMAND='history -a'

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
export LESS=-FiRS

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    red="\[\e[1;31m\]"
    blue="\[\e[0;34m\]"
    cyan="\[\e[0;36m\]"
    green="\[\e[0;32m\]"
    yellow="\[\e[0;33m\]"
    normal="\[\e[0m\]"
    
    function eswald_prompt_exitcolor {
      if [ "$1" = "0" ]
      then
	# No error: Dark blue
	echo "[0;34m"
      else
	# Error: Bright red
	echo "[1;31m"
      fi
    }
    
    function eswald_prompt_jobcolor {
      if jobs | grep -q Stopped
      then
	# Stopped jobs: Green
	echo "[0;32m"
      else
	# No stopped jobs: Dark blue
	echo "[0;34m"
      fi
    }
    
    function eswald_prompt_pathcolor {
      if [ -w "$PWD" ]
      then
	# Writable path: Cyan
	echo "[0;36m"
      else
	# Unwritable path: Yellow/Brown
	echo "[0;33m"
      fi
    }
    
    exitcode="\[\e\$(eswald_prompt_exitcolor $?)\](exit $?)"
    exitcode="\$(if [ \$? = 0 ]; then echo '$blue(exit '\$?')'; else echo '$red(exit '\$?')'; fi; )"
    timecode="$blue(\t)"
    jobcode="\[\e\$(eswald_prompt_jobcolor)\](\j jobs)"
    usercode="$cyan\u"
    pathcode="\[\e\$(eswald_prompt_pathcolor)\]\w"
    PS1="$exitcode $timecode $jobcode$normal\n$usercode:$pathcode$cyan>$normal "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

#USER_PROMPT_COMMAND="PS1='$PS1'"

# Unbuffered python, in a custom environment
export PYTHONUNBUFFERED=1
if [ -f "$HOME/.python/bin/activate" ]; then
    saved_ps1="$PS1"
    . "$HOME/.python/bin/activate"
    PS1="$saved_ps1"
    unset saved_ps1
elif [ -d "$HOME/.python" ] ; then
  export PYTHONPATH=~/.python
fi

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

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lh'
alias la='ls -A'
#alias l='ls -CF'

# Let graphical programs know where to show up.
# This used to be based on $GDM_XSERVER_LOCATION,
# but that doesn't seem to be available on Koala.
if [ -z "$DISPLAY" ]; then
  myname=eswald
  xline="\/\(bin\|X11\)\/X :"
  display=$(ps -AH -ouser,cmd | \
    sed "/$xline/{x;d};/^root /d;/^$myname /{x;/$xline/p;d};x;d" | \
    head -n 1 | cut -d: -f2 | cut -d' ' -f1)
  if [ -n "$display" ]; then
    export DISPLAY=:$display
  fi
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Source any custom completion files.
if [ -d ~/.config/bash ]
then
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

# Collect SSH agent credentials if available.
if [ -z "$SSH_AGENT_PID" ]
then
  sshagent=$(ps -u eswald -o pid,comm | grep ssh-agent | head -n 1)
  sshsock=$(ls -ld /tmp/keyring-*/ssh /tmp/ssh-*/agent.* 2>/dev/null | grep eswald | head -n 1)
  if [ -n "$sshagent" -a -n "$sshsock" ]
  then
    export SSH_AGENT_PID="$(echo "$sshagent" | sed 's/^ *\([0-9]\+\) .*/\1/')"
    export SSH_AUTH_SOCK="$(echo "$sshsock" | sed 's%^.* /tmp/%/tmp/%')"
  fi
fi

# Allow these shell options to work in all interactive shells
shopt -s cdspell    # correct minor spelling errors in 'cd' arguments
shopt -s cmdhist    # save multi-line commands as a single history entry
# shopt -s dotglob  # include hidden '.' files in filename expansion
shopt -s extglob    # allows ?(), *(), +(), @(), !() in path expansion
