setlocal fen fdm=expr fdl=99 fdls=99
setlocal foldexpr=DiffFoldLevel(v:lnum)

function! DiffFoldLevel(lnum)
  let thisline = getline(a:lnum)
  if thisline =~ '^@@'
    return 1
  elseif thisline =~ '^ '
    return 2
  elseif thisline =~ '^[+-]'
    return 3
  endif
  
  return 0
endfunction
