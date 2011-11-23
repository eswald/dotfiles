" Vim filetype plugin file
" Language:	Dvorak Deck Definition
" Maintainer:	Eric Wald <breadman@sourceforge.net>
" URL:		
" Last Change:	15-Sep-2004
" Rather esoteric, but these are things I like.


" Let colons count as part of a word, since they are used in various names
setlocal isk+=:

" Find tags in the help system
setlocal tags+=$VIMRUNTIME/doc/tags,~/.vim/doc/tags

" Execute a command line in a script file
nnoremap <silent> <buffer> <CR><CR> :exe getline('.')<CR>:echo getline('.')<CR>

" Execute the whole script quickly
nnoremap <silent> <buffer> <LocalLeader>so :w<CR>:so %<CR>

" Fix the spaces caused by pasting in example code
vnoremap <buffer> == :call s:ReformatSpaces()<CR>
function! s:ReformatSpaces()
  let line = line('.')
  s/ / /ge
  s/\s\+$//e
  exe line
  normal ==
endfunction

" Set indenting according to internet standard
setlocal shiftwidth=2 tabstop=8 softtabstop=2

" Wrapping preferences
setlocal nowrap tw=78 fo=crql1

" Folding preferences
setlocal fen fdls=1 fdn=3 fdm=indent fdi=

" Easy increment/decrement
iab <buffer> ++ <Esc>1hdiW1hpa = <Esc>pa + 1
iab <buffer> -- <Esc>1hdiW1hpa = <Esc>pa - 1
