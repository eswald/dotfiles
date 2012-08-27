# vim: ft=sh et sts=2 sw=2 ts=2
shopt -s extglob

__nosewords()
{
  local file base pattern words
  fname="$1"
  base="$2"
  cname=."$fname".nwc
  
  if [ "$cname" -ot "$fname" ]
  then
    nosetests -v --collect-only "$fname" 2> "$cname"
  fi
  
  case "$base" in
    *.*)
      pattern='s/^\(\w\+\) (\w\+\.\(\w\+\)).*$/\2.\1/;s/^\w\+\.\(\w\+\)[ (].*/\1 /';;
    *)
      pattern='s/^\(\w\+\) (\w\+\.\(\w\+\)).*$/\2/;s/^\w\+\.\(\w\+\)[ (].*/\1 /';;
  esac
  words=$(grep 'ok$' "$cname" | sed "$pattern" | uniq)
  compgen -W "${words}" -- "$base"
}

_nosetests()
{
  COMPREPLY=()
  local cur fname base
  compopt -o nospace
  cur="${COMP_WORDS[COMP_CWORD]}"
  case "$cur" in
    -*)
      COMPREPLY=( $(compgen -W "-vx --collect-only" -- "$cur") )
      return 0;;
    :)
      # Look at the previous COMP_WORD for the file name.
      fname="${COMP_WORDS[COMP_CWORD-1]}"
      COMPREPLY=( $(__nosewords $fname "") )
      return 0;;
    *:*)
      # For when the colon doesn't separate words.
      fname=${cur%%:*}
      base=${cur#*:}
      COMPREPLY=( $(__nosewords "$fname" "$base" | sed "s|^|$fname:|") )
      return 0;;
    *.py)
      # The filename was already complete, so we want a test case or suite.
      COMPREPLY=( "$cur:" )
      #COMPREPLY=( $(__nosewords "$cur" "" | sed "s|^|$fname:|") )
      return 0;;
    *)
      if [[ "${COMP_WORDS[COMP_CWORD-1]}" == ":" ]]
      then
        # Complete the test part, with the file earlier.
        fname="${COMP_WORDS[COMP_CWORD-2]}"
        COMPREPLY=( $(__nosewords "$fname" "$cur") )
        if [[ "${COMPREPLY[@]}" == "$cur" ]]
        then
          # Add the dot automatically, and any known prefix beyond that.
          COMPREPLY=( $(__nosewords "$fname" "$cur.") )
        fi
      else
        # Match the filename, limiting to test case modules.
        COMPREPLY=( $(compgen -f -X '!test*.py' -- "$cur") )
      fi
      return 0;;
  esac
}

complete -F _nosetests nosetests
