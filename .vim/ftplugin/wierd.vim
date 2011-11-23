setlocal ve=all ts=1 et sw=1 list nofen
nnoremap <buffer> <space> r<space>
vnoremap <buffer> <space> r<space>
nnoremap <buffer> * r*
vnoremap <buffer> * r*
nnoremap <buffer> , r*
vnoremap <buffer> , r*
noremap <buffer> w W
noremap <buffer> b B
noremap <buffer> e E
noremap <buffer> v <c-v>
ab wierd wierd
unab wierd

augroup Wierd
  au!
  au BufEnter *.w set virtualedit=all
  au BufLeave *.w set virtualedit=block
augroup END
