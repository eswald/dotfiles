setlocal commentstring=;%s
setlocal ts=3 sw=3 noet

inoremap <buffer> <CR> <C-R>=<SID>ReturnWrapper()<CR>
function! s:ReturnWrapper()
  let text = strpart(getline('.'), col('.') - 1)
  if text =~ '^\%(\s*)\)\+$'
    " Opens up a new line with the proper indentation
    return "\<CR>\<ESC>O"
  elseif text =~ '^\s\+\S'
    " Fixes a rare indentation error
    return "\<ESC>wi\<CR>"
  else
    " Avoids killing the indentation
    return " \<BS>\<CR>"
  endif
endf

