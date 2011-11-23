" Message window viewer
" Author:        Eric Wald
" Last Modified: 04-Oct-2004
" 
" Particularly useful when used with echomsg debugging statements

command! Messages call s:RepeatMess()

function! s:RepeatMess()
  " Open and clear a temporary buffer, re-using if possible
  let bname = '[Recent Messages]'
  let winnum = bufwinnr(bname)
  if winnum != -1
      if winnr() != winnum
          exe winnum . 'wincmd w'
      endif
  else
      let bufnum = bufnr(bname)
      let bcmd = (bufnum == -1) ? bname : '+buffer' . bufnum
      exe 'silent! botright 1split' bcmd
  endif
  setlocal modifiable
  silent! %delete _
  
  " Collect the messages (through a register) into the buffer
  let old_a = @a
  redir @a
  silent! messages
  redir END
  silent! put! a
  let @a = old_a
  
  " Remove extra whitespace
  silent! g/^$/d
  silent! %s/^ \+//e
  
  " Mark the buffer as scratch
  setlocal buftype=nofile
  setlocal bufhidden=delete
  setlocal noswapfile
  setlocal nowrap
  setlocal nobuflisted
  setlocal nomodified
  setlocal nomodifiable
  
  " Expand to the number of lines
  silent! execute 'resize' line('$')
  silent! normal! Gzb
  
  " Basic syntax highlighting
  " Tries to emulate the actual highlighting, but doesn't always.
  syntax clear
  syntax case ignore
  syntax match messError '^.*error.*$'
  syntax match messError '^E\d\+:.*$'
  syntax match messWarn '^search hit .*$'
  syntax match messWarn '^.*warning.*$'
  syntax match messLine '^line\s\+\d\+:'
  hi def link messError ErrorMsg
  hi def link messWarn WarningMsg
  hi def link messLine LineNr
  
  " Maps
  nmap <buffer> <Esc> :close<CR>
  nmap <buffer> q :close<CR>
  nmap <buffer> u :Mess<CR>
endfunction
