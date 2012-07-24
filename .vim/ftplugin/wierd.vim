setlocal ts=1 et sw=1 list nofen nowrap
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

" Search for subroutine definition
nnoremap <buffer> [d /^<C-R>=expand('<cword>')<CR>:<CR>

au WinEnter <buffer> set virtualedit=all
au WinLeave <buffer> set virtualedit=block
