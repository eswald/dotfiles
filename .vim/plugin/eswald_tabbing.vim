" Standard tab-nav and -creation keystrokes
nnoremap <silent> <C-Tab> :tabnext<CR>
nnoremap <silent> <S-C-Tab> :tabprev<CR>
nnoremap <silent> <C-T> :tabnew<CR>

" Moving tabs around
if version >= 704
  nnoremap <silent> <F6> :tabmove -1<CR>
  nnoremap <silent> <F7> :tabmove +1<CR>
else
  nnoremap <silent> <F6> :silent! exec 'tabmove '.(tabpagenr() - 2)<CR>
  nnoremap <silent> <F7> :exec 'tabmove '.tabpagenr()<CR>
endif

nmap `<F6> <F6>
nmap `<F7> <F7>

" Most recently used tab
command! EswaldSaveTab exec "nnoremap `<lt>BS> :EswaldSaveTab<CR>".tabpagenr()."gt"
nnoremap <silent> `<Backspace> :EswaldSaveTab<CR>:tablast<CR>

" Screen-like backticks for navigation
nnoremap <silent> `n :EswaldSaveTab<CR>gt
nnoremap <silent> `p :EswaldSaveTab<CR>gT
nnoremap <silent> `1 :EswaldSaveTab<CR>1gt
nnoremap <silent> `2 :EswaldSaveTab<CR>2gt
nnoremap <silent> `3 :EswaldSaveTab<CR>3gt
nnoremap <silent> `4 :EswaldSaveTab<CR>4gt
nnoremap <silent> `5 :EswaldSaveTab<CR>5gt
nnoremap <silent> `6 :EswaldSaveTab<CR>6gt
nnoremap <silent> `7 :EswaldSaveTab<CR>7gt
nnoremap <silent> `8 :EswaldSaveTab<CR>8gt
nnoremap <silent> `9 :EswaldSaveTab<CR>9gt
nnoremap <silent> `0 :EswaldSaveTab<CR>10gt
nnoremap <silent> `! :EswaldSaveTab<CR>11gt
nnoremap <silent> `@ :EswaldSaveTab<CR>12gt
nnoremap <silent> `# :EswaldSaveTab<CR>13gt
nnoremap <silent> `$ :EswaldSaveTab<CR>14gt
nnoremap <silent> `% :EswaldSaveTab<CR>15gt
nnoremap <silent> `^ :EswaldSaveTab<CR>16gt
nnoremap <silent> `& :EswaldSaveTab<CR>17gt
nnoremap <silent> `* :EswaldSaveTab<CR>18gt
nnoremap <silent> `( :EswaldSaveTab<CR>19gt
nnoremap <silent> `) :EswaldSaveTab<CR>10gt

" Tab naming
nnoremap `t :let t:tabname="<C-R>=(exists('t:tabname')? t:tabname : '')<CR>"<Left>

" Moving windows between tabs
nnoremap <silent> `= :call EswaldMoveNextTab()<CR>
nnoremap <silent> `- :call EswaldMovePrevTab()<CR>
function! EswaldMoveNextTab()
  let buf = bufnr('%')
  tabnext
  exec "sbuffer" buf
  tabprev
  quit
  tabnext
endfunction
function! EswaldMovePrevTab()
  let buf = bufnr('%')
  tabprev
  exec "sbuffer" buf
  tabnext
  quit
  tabprev
endfunction

" For use in 'EswaldTabLine' and 'EswaldGuiTabLabel'
function! EswaldTabLabel(tnum)
  let label = a:tnum
  let bufnrlist = tabpagebuflist(a:tnum)
  
  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label .= '+'
      break
    endif
  endfor
  
  " Buffer name, with the path removed
  let tabname = gettabvar(a:tnum, "tabname")
  if strlen(tabname) == 0
    let tabname = fnamemodify(bufname(bufnrlist[tabpagewinnr(a:tnum) - 1]), ':t')
  endif
  
  " Append the buffer name
  return label . ' ' . tabname
endfunction

" For use in 'tabline'
function! EswaldTabLine()
  " Mostly from the 'tabpage' help text.
  let s = ''
  
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by EswaldTabLabel()
    let s .= ' %{EswaldTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  return s
endfunction

" For use in 'guitablabel'
function! EswaldGuiTabLabel()
  return EswaldTabLabel(v:lnum)
endfunction

set tabline=%!EswaldTabLine()
