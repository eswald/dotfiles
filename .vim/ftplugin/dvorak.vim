" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

if char2nr(getline(2)[0]) == 9
  setlocal sw=4 ts=4 noet
else
  setlocal sw=4 ts=8 sts=4 et
endif

setlocal nowrap lbr
setlocal fen foldmethod=marker foldmarker={,}
"setlocal fen foldmethod=syntax
nmap <silent> <buffer> <C-N> <Tab> eb:call <SID>CycleDirection()<CR>
"nmap <silent> <buffer> ; A";<Esc>lx

inoremap <buffer> MC: Move/Capture:
inoremap <buffer> M: Move:
inoremap <buffer> C: Capture:
inoremap <buffer> CV http://www.chessvariants.org/
iab <buffer> ans any number of spaces
iab <buffer> ANS Any number of spaces

let b:delimiter_chars = '",s:\::;,m:{:},(:),[:]'

if exists('g:didDvorakPlugin') | finish | endif
let g:didDvorakPlugin = 1

" au BufWritePre,FileWritePre * if &ft == 'dvorak' | RedateDvorak | endif
" command! RedateDvorak 1,10s/date:\s\+"\zs.\{-}\ze"/\=strftime("%d %b %Y")/e
      " \ | silent noh | normal! <C-O>

function! s:CycleDirection()
  let char = getline('.')[col('.') - 1]
  if char == 'o'
    normal! 5sdiaFd
  elseif char == 'O'
    normal! 5sDiaFD
  elseif char == 'd'
    normal! 6sradiFr
  elseif char == 'D'
    normal! 6sRadiFR
  elseif char == 'r'
    normal! 4shippogonFh
  elseif char == 'R'
    normal! 4sHippogonFH
  elseif char == 'h'
    normal! RorthFo
  elseif char == 'H'
    normal! ROrthFO
  elseif char == 'f'
    normal! 3sbackFb
  elseif char == 'F'
    normal! 3sBackFB
  elseif char == 'b'
    normal! cwsidewaysFs
  elseif char == 'B'
    normal! cwSidewaysFS
  elseif char == 's'
    normal! cwforwardFf
  elseif char == 'S'
    normal! cwForwardFF
  endif
endf
