" Use .vimrc files in the ELinks directory.
"
" To use this file, drop it in ~/.vim/ftplugin and set filetype plugin on.
" (Or, to eliminate the need for this file, set exrc, but that's insecure.)
"
" For .h files, link it as cpp_elinks.vim or define c_syntax_for_h in ~/.vimrc.
" For .inc files, let g:filetype_inc = 'c' in ~/.vimrc.

if expand('%:p:h') =~ 'elinks'
  " Use these settings for .inc and .h files, too.
  let c_syntax_for_h = 1
  let g:filetype_inc = 'c'

  setlocal shiftwidth=8
  setlocal tabstop=8
  setlocal softtabstop=0
  setlocal noexpandtab
endif
