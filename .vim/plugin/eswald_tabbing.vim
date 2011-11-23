" Standard tab-nav and -creation keystrokes
nnoremap <silent> <C-Tab> :tabnext<CR>
nnoremap <silent> <S-C-Tab> :tabprev<CR>
nnoremap <silent> <C-T> :tabnew<CR>

" Moving tabs around
nnoremap <silent> <F6> :silent! exec 'tabmove '.(tabpagenr() - 2)<CR>
nnoremap <silent> <F7> :exec 'tabmove '.tabpagenr()<CR>

" Screen-like backticks for navigation
nnoremap <silent> `n gt
nnoremap <silent> `p gT
nnoremap <silent> `1 1gt
nnoremap <silent> `2 2gt
nnoremap <silent> `3 3gt
nnoremap <silent> `4 4gt
nnoremap <silent> `5 5gt
nnoremap <silent> `6 6gt
nnoremap <silent> `7 7gt
nnoremap <silent> `8 8gt
nnoremap <silent> `9 9gt
nnoremap <silent> `0 10gt
nnoremap <silent> `! 11gt
nnoremap <silent> `@ 12gt
nnoremap <silent> `# 13gt
nnoremap <silent> `$ 14gt
nnoremap <silent> `% 15gt
nnoremap <silent> `^ 16gt
nnoremap <silent> `& 17gt
nnoremap <silent> `* 18gt
nnoremap <silent> `( 19gt
nnoremap <silent> `) 10gt
nnoremap <silent> `<Backspace> :tablast<CR>

" Tab naming
nnoremap `t :let t:tabname=""<Left>

" For use in 'guitablabel'
function! EswaldGuiTabLabel()
  let label = v:lnum
  let bufnrlist = tabpagebuflist(v:lnum)
  
  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label .= '+'
      break
    endif
  endfor
  
  " Buffer name, with the path removed
  if exists("t:tabname") && strlen(t:tabname)
    let tabname = t:tabname
  else
    let tabname = fnamemodify(bufname(bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
  endif
  
  " Append the buffer name
  return label . ' ' . tabname
endfunction
