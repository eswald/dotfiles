# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]
then
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

if [ -n "$force_color_prompt" ]
then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null
  then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]
then
  red="\[\e[1;31m\]"
  blue="\[\e[0;34m\]"
  cyan="\[\e[0;36m\]"
  green="\[\e[0;32m\]"
  yellow="\[\e[0;33m\]"
  normal="\[\e[0m\]"

  #function eswald_prompt_exitcolor {
  #  if [ "$1" = "0" ]
  #  then
  #    # No error: Dark blue
  #    echo "[0;34m"
  #  else
  #    # Error: Bright red
  #    echo "[1;31m"
  #  fi
  #}

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
  
  function eswald_prompt_usercolor {
    user="$1"
    if [ "$user" = "eswald" ]
    then
      # Standard username: Dark blue
      echo "[0;34m"
    else
      # Unusual username: Cyan
      echo "[0;36m"
    fi
  }

  #exitcode="\[\e\$(eswald_prompt_exitcolor $?)\](exit $?)"
  exitcode="\$(if [ \$? = 0 ]; then echo '$blue(exit '\$?')'; else echo '$red(exit '\$?')'; fi; )"
  timecode="$blue(\t)"
  jobcode="\[\e\$(eswald_prompt_jobcolor)\](\j jobs)"
  usercode="\[\e\$(eswald_prompt_usercolor \u)\](\u@\H)"
  pathcode="\[\e\$(eswald_prompt_pathcolor)\]\w"
  PS1="$exitcode $usercode $timecode $jobcode$normal\n$pathcode$cyan>$normal "
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

unset color_prompt force_color_prompt

#USER_PROMPT_COMMAND="PS1='$PS1'"
