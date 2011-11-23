" Vim indent file
" Language:	ZRF (Zillions Rules File for Zillions of Games)
"               see http://www.zillionsofgames.com for more info
" Maintainer:	Eric Wald
" Last Change:	2004 Aug 18

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetZRFIndent()
setlocal indentkeys=),o,O,e

" Only define the function once.
" if exists("*GetZRFIndent")
  " finish
" endif

function! GetZRFIndent()
  " Find a non-blank line above the current line.
  let lnum = prevnonblank(v:lnum - 1)

  " At the start of the file use zero indent.
  if lnum == 0
    return 0
  endif

  " Add a 'shiftwidth' after unclosed parentheses
  let thisline = substitute(getline(v:lnum), '\s\+', '', 'g')
  let lastline = substitute(getline(lnum), '^\%(\s*)\)\+', '', '')
  let diff = strlen(substitute(lastline, '[^(]\+', '', 'g'))
  let diff = diff - strlen(substitute(lastline, '[^)]\+', '', 'g'))
  
  " Unindent for initial closing parentheses
  let diff = diff - strlen(substitute(thisline, '^)*\zs.*', '', ''))

  " Unindent 'else' at the beginning of a line, and re-indent below
  if thisline =~ '^else'
    let diff = diff - 1
  endif
  if lastline =~ '^\s*else'
    let diff = diff + 1
  endif

  return indent(lnum) + diff * &sw
endfunction

" vim: sw=2
