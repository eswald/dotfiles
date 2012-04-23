# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]
then
  debian_chroot=$(cat /etc/debian_chroot)
fi

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null
then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
else
  color_prompt=
fi

if [ "$color_prompt" = yes ]
then
  function eswald_prompt {
    # Collect the error code before any commands.
    err=$?
    
    red="\[\e[1;31m\]"
    blue="\[\e[0;34m\]"
    cyan="\[\e[0;36m\]"
    green="\[\e[0;32m\]"
    yellow="\[\e[0;33m\]"
    normal="\[\e[0m\]"
    
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
    
    exitcode="$exitcolor(exit $err)"
    timecode="$blue(\t)"
    jobcode="$jobcolor(\j jobs)"
    usercode="$usercolor(\u@\H)"
    pathcode="$pathcolor\w"
    echo "$exitcode $usercode $timecode $jobcode$normal\n$pathcode$cyan>$normal "
  }
  
  PROMPT_COMMAND='PS1="$(eswald_prompt)"'
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

unset color_prompt force_color_prompt

#USER_PROMPT_COMMAND="PS1='$PS1'"
