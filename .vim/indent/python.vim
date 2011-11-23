" Vim indent file
" Language:	Python
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Original Author:	David Bustos <bustos@caltech.edu>
" Modified By:	Eric Wald <eswald@brainshell.org>
" Last Change:	27-Feb-2008

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

" Some preliminary settings
setlocal nolisp		" Make sure lisp indenting doesn't supersede us
setlocal autoindent	" indentexpr isn't much help otherwise

setlocal indentexpr=GetPythonIndent(v:lnum)
setlocal indentkeys+=<:>,=elif,=except

" Only define the function once.
if exists("*GetPythonIndent")
  finish
endif

let s:maxoff = 50     " maximum number of lines to look backwards for brackets

function! GetPythonIndent(lnum)
  " If this line is explicitly joined: If the previous line was also joined,
  " line it up with that one, otherwise add two 'shiftwidth'
  if getline(a:lnum - 1) =~ '\\$'
    if a:lnum > 1 && getline(a:lnum - 2) =~ '\\$'
      return indent(a:lnum - 1)
    endif
    return indent(a:lnum - 1) + (&sw * 2)
  endif

  " If the start of the line is in a string, don't change the indent.
  if has('syntax_items')
	\ && synIDattr(synID(a:lnum, 1, 1), "name") == "pythonString"
    return -1
  endif

  " Search backwards for the previous non-empty line.
  let plnum = prevnonblank(a:lnum - 1)

  if plnum == 0
    " This is the first non-empty line, use zero indent.
    return 0
  endif

  " If the previous line is inside brackets, find the indent of the starting
  " line.
  " Trick: use the non-existing 'dummy' variable to break out of the loop when
  " going too far back.  Without that trick, however, the 'r' flag would be
  " useful.
  call cursor(plnum, 1)
  let skip = "line('.') < " . (plnum - s:maxoff) . " ? dummy :"
	  \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
	  \ . " =~ 'python\\(Comment\\|String\\)'"
  let plevel = 0
  while searchpair('[{([]', '', '[])}]', 'bW', skip) > 0
    let plevel = plevel + 1
  endwhile
  let plnumstart = line('.')
  let plindent = indent(plnumstart)
  let plstart = getline(plnumstart)


  " When inside brackets: Add one 'shiftwidth' for each level of open
  " brackets, plus an extra if the first line starts with a block-opening
  " keyword.  Again, the 'r' and 'm' flags would be useful, but not with the
  " dummy trick.
  " i = (a
  "     + b
  "     + c)
  " while (a or (b
  "             and c)
  "         or d):
  "     f(a, [b,
  "             c],
  "         d,
  "         e)
  call cursor(a:lnum, 1)
  let extra = 0
  while searchpair('[{([]', '', '[])}]', 'bW', skip) > 0
    let extra = extra + 1
  endwhile
  if extra > 0
    if plevel > 0
      return indent(plnum) + (&sw * (extra - plevel))
    else
      if plstart =~ '^\s*\(def\|class\|if\|elif\|for\|while\|try\|except\|else\|finally\|with\)\>'
	let extra = extra + 1
      endif
      return plindent + (&sw * extra)
    endif
  endif


  " Get the line and remove a trailing comment.
  " Use syntax highlighting attributes when possible.
  let pline = getline(plnum)
  let pline_len = strlen(pline)
  let col = 0
  while col < pline_len
    if pline[col] == '#' && (!has('syntax_items')
	    \ || synIDattr(synID(plnum, col + 1, 1), "name") == "pythonComment")
      let pline = strpart(pline, 0, col)
      break
    endif
    let col = col + 1
  endwhile

  " If the previous line ended with a colon, indent this line
  if pline =~ ':\s*$'
    return plindent + &sw
  endif

  " If the line has already been dedented, trust it
  if indent(a:lnum) <= plindent - &sw
    return -1
  endif

  " If the previous line was a stop-execution statement...
  if plstart =~ '^\s*\(break\|continue\|raise\|return\|pass\)\>'
    " Recommend one dedent
    return plindent - &sw
  endif

  " If the current line begins with a keyword that lines up with 'try'
  if getline(a:lnum) =~ '^\s*\(except\|finally\)\>'
    let lnum = plnum
    while lnum >= 1
      if getline(lnum) =~ '^\s*\(try\|except\)\>'
	let ind = indent(lnum)
	if ind >= indent(a:lnum)
	  return -1	" indent is already less than this
	endif
	return ind	" line up with previous try or except
      endif
      let lnum = lnum - 1
    endwhile
    return -1		" no matching 'try'!
  endif

  " If the current line starts an else block, dedent
  if getline(a:lnum) =~ '^\s*\(elif\|else\)\>'
    " Unless the previous line was a one-liner
    if plstart =~ '^\s*\(for\|if\|try\|elif\|while\|except\)\>'
      return plindent
    endif

    return plindent - &sw
  endif

  " Finally, use the indent from the start of the previous line
  return plindent
endfunction

" vim:sw=2
