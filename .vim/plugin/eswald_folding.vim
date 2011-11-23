" Default foldmethod
" Similar to fdm=indent, but lets blank and comment lines default high.
set fen fdm=expr fdi=
set foldexpr=EswaldFoldLevel(v:lnum)

function! EswaldFoldLevel(lnum)
  let ignored = '^\s*\([#/*]\|$\)'
  if getline(a:lnum) !~ ignored
    " In the general case, just use the indent level.
    " It would be nice if it didn't skip several levels...
    return indent(a:lnum) / &sw
  endif
  
  let previndent = 0
  let prevnum = a:lnum - 1
  while prevnum > 0
    if getline(prevnum) =~ ignored
      let prevnum = prevnum - 1
    else
      let previndent = indent(prevnum) / &sw
      break
    endif
  endwhile
  
  let nextindent = 0
  let maxline = line('$')
  let nextnum = a:lnum + 1
  while nextnum <= maxline
    if getline(nextnum) =~ ignored
      let nextnum = nextnum + 1
    else
      let nextindent = indent(nextnum) / &sw
      break
    endif
  endwhile
  
  return max([previndent, nextindent])
endfunction

" Smart Folding and paging
nnoremap <silent> <Space> za
"nnoremap <silent> <Space> :if foldlevel('.') > 0 <Bar> exec "normal! za" <Bar> else <Bar> exec "normal! \<lt>C-F>" <Bar> endif<CR>
"nnoremap <silent> <Space> :if foldlevel('.') > 0 <Bar> exec "normal! za" <Bar> else <Bar> exec "normal! \<lt>C-F>" <Bar> nnoremap <lt>buffer> b <lt>C-B><Bar> endif<CR>
"nnoremap <silent> B B:silent! nunmap <lt>buffer> b<CR>
"nnoremap <silent> w w:nnoremap <lt>buffer> b b<CR>
nnoremap z<Space> za

" Idea waiting for a mapping
" VimTip #1022, by i5513
"set foldexpr=getline(v:lnum)!~@/
"nmap ?? :set foldmethod=expr<CR>
