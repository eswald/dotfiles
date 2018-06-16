# Completion for the ~/bin/apt command.
# $COMP_CWORD: Word number of the cursor position, 0-based
# $COMP_KEY:   Key used to invoke completion
# $COMP_LINE:  Current command line
# $COMP_POINT: Index of cursor within the line
# $COMP_TYPE:  Type of completion; tab, ?, !, @, %
# $COMP_WORDS: Array of words in the command line

_apt_complete() {
  local current command commands
  COMPREPLY=()
  # http://stackoverflow.com/questions/12933362/getting-compgen-to-include-slashes-on-directories-when-looking-for-files
  compopt +o default
  current="${COMP_WORDS[COMP_CWORD]}"
  if [ "$COMP_CWORD" = "1" ]
  then
    commands="update search find show install apply installed which list remove autoremove"
    COMPREPLY=( $(compgen -W "$commands" -- "$current") )
  else
    command="${COMP_WORDS[1]}"
    case "$command" in
      install|show|installed|list|remove)
	COMPREPLY=( $(apt-cache --no-generate pkgnames "$current" 2> /dev/null) )
	;;
      apply)
	compopt -o default
	compopt -o filenames
	COMPREPLY=( $(compgen -G '*.deb' -- "$current") )
	;;
      which)
	compopt -o default
	compopt -o filenames
	;;
      *)
	;;
    esac
  fi
}

if ! command -v apt > /dev/null 2>&1
then
  alias apt=fake-apt
  complete -o default -F _apt_complete apt
fi

# vim: ft=sh et sts=2 sw=2 ts=2
