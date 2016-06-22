  if command -v stty > /dev/null 2>&1
  then
    export STTY_ORIG="$(stty -g)"
  fi
  
  function eswald_prompt {
    # Collect the error code before any commands.
    err=$?
    
    # These codes can be used if the explicit escape commands aren't portable.
    # I haven't yet seen such a situation.
    #bright="\[$(tput bold)\]"
    #red="\[$(tput setaf 1)\]"
    #blue="\[$(tput setaf 4)\]"
    #cyan="\[$(tput setaf 6)\]"
    #green="\[$(tput setaf 2)\]"
    #yellow="\[$(tput setaf 3)\]"
    #normal="\[$(tput sgr0)\]"
    
    bright="\[\e[1m\]"
    red="\[\e[1;31m\]"
    grey="\[\e[1;30m\]"
    blue="\[\e[0;34m\]"
    cyan="\[\e[0;36m\]"
    green="\[\e[0;32m\]"
    yellow="\[\e[0;33m\]"
    normal="\[\e[m\]"
    
    # Reverse a few modes that may have been accidentally invoked.
    # See http://invisible-island.net/xterm/ctlseqs/ctlseqs.html for more potential codes.
    # These come from tput cnorm, rmacs, and ed.
    reset="\[\e[34h\e[?25h\017\e[J\e[m\]"
    
    # Reverse curses tty manipulation.
    if [ -n "${STTY_ORIG:-}" ]
    then
      stty "$STTY_ORIG"
    fi
    
    if [ "$err" = "0" ]
    then
      # No error: Dark blue
      exitcolor="$blue"
    else
      # Error: Bright red
      exitcolor="$red"
    fi
    
    if jobs | grep -q Stopped
    then
      # Stopped jobs: Green
      jobcolor="$green"
    else
      # No stopped jobs: Dark blue
      jobcolor="$blue"
    fi
    
    if [ -w "$PWD" ]
    then
      # Writable path: Cyan
      pathcolor="$cyan"
    else
      # Unwritable path: Yellow/Brown
      pathcolor="$yellow"
    fi
    
    if [ "$USER" = "eswald" ]
    then
      # Standard username: Dark blue
      usercolor="$blue"
    else
      # Unusual username: Green
      usercolor="$green"
    fi
    
    # Python virtual environment
    if [ -n "$VIRTUAL_ENV" ]
    then
      virt="${VIRTUAL_ENV##*/}"
      if [ "$virt" = "sandbox" ]
      then
	virt="${VIRTUAL_ENV%/*}"
	virt="${virt##*/}/"
      fi
      envcode=" $blue(python: $virt)"
    else
      envcode=""
    fi
    
    # Find the git directory and branch, if any.
    # __git_ps1 proved to be far too slow in some situations.
    gitdir="$(git rev-parse --show-toplevel 2>/dev/null || true)"
    gitcode=""
    if [ -n "$gitdir" ]; then
	head="$(git rev-parse --abbrev-ref HEAD)"
	if [ "$(cd "$gitdir" && pwd -P)" = "$(pwd -P)" ]; then
	  gitlabel="${gitdir##*/}"
	else
	  gitlabel="$grey${gitdir##*/}"
	fi
	
	if [[ "$head" == 'master' ]]; then
	  githead="$blue$head"
	elif [[ "$head" == 'HEAD' ]]; then
	  githead="$red$head$blue"
	elif [ -n "$head" ]; then
	  githead="$grey$head$blue"
	fi
	
	gitcode=" $blue(git:$gitlabel $githead)"
    fi
    
    # Merge history with other shells.
    # It might be nice to pipe history stright into the python, instead of doing this file dance,
    # but a) we don't know how many commands to pipe, and b) the history number might interfere.
    histcode=""
    history -a
    if python ~/.python/eswald/unique_history.py "$HISTFILE" > /dev/null 2>&1
    then
      # Eternal history
      # Format: Process ID, user name, time finished, history number, time started, command
      echo $$ $USER "$(date +%s)" "$(HISTTIMEFORMAT="%s " history 1)" >> ~/.bash_eternal
      
      # Indicate the new history entry.
      histcode=" +"
    fi
    
    # These were attempts to collect commands from other shells, but they don't seem to work.
    #history -r
    #history -n
    
    exitcode="$exitcolor(exit $err$histcode)"
    timecode="$blue(\d \t)"
    jobcode="$jobcolor(\j jobs)"
    usercode="$usercolor(\u@\H)"
    pathcode="$pathcolor\w"
    echo "$reset$exitcode $usercode$envcode$gitcode $timecode $jobcode$normal\n$pathcode$cyan>$normal "
  }
  
  PROMPT_COMMAND="PS1='\[\e[0;36m\]\w>\[\e[m\] ';PROMPT_COMMAND='PS1=\"\$(eswald_prompt)\"'"
