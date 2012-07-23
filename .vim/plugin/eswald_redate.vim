" Redate file headers automatically
" For use with BufWritePre autocommands in filetype plugins.

function! RedateHeader(format)
  " Mark the current position, and find the end of the header (if possible)
  silent! normal! msHmtgg$%
  let lastline = line('.')
  if lastline == 1
    " Header not found, so use fifteen lines or the full file
    let lastline = s:Min(15, line('$'))
  endif
  
  " Replace any timestamps discovered, in whatever format
  silent! execute '1,' . lastline . 's/\m\%(date\|changed\?\|modifi\w\+\):\s\+"\?\zs\%(\a\|\d\|[/,:-]\)*/\=strftime("' . a:format . '")/ie'
  
  " Increment the version marker
  "silent! execute '1,' . lastline . "g/[Vv]ersion:/normal! $\<C-a>"
  
  " Restore the marked position
  silent! normal! 'tzt`s
endf

function! s:Min(number, ...)
  let result = a:number
  let index = a:0
  while index > 0
    let result = (a:{index} > result) ? result : a:{index}
    let index = index - 1
  endwhile
  return result
endf
