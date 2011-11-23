
" Only load this indent file when no other was loaded.
if exists("b:did_indent") | finish | endif
let b:did_indent = 1

setlocal indentexpr=GetDvorakIndent()
setlocal indentkeys=0{,0},!^F,o,O
setlocal autoindent

function! GetDvorakIndent()
  let lnum = prevnonblank(v:lnum - 1)

  " Start with no indent
  if lnum == 0
    return 0
  endif

  " Check for opening brace on the previous line
  " Skip if it also contains a closing brace
  let ind = indent(lnum)
  let line = getline(lnum)
  if line =~ '{\(.*}\)\@!'
    let ind = &sw
  endif

  " Check for opening or closing strings
  if line =~ '";$'
    let ind = &sw
  elseif line =~ '\s*\k\+:\s*"[^"]*$'
    let ind = 0
  endif

  " Check for closing brace first on current line
  let line = getline(v:lnum)
  if line =~ '^\s*}'
    let ind = 0
  endif

  return ind
endfunction
