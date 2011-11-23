if expand('%:p') =~ '/exile/'
  setlocal shiftwidth=4
  setlocal tabstop=4
  setlocal softtabstop=4
  setlocal expandtab
elseif expand('%:p') =~ '/boomerang/'
  setlocal shiftwidth=4
  setlocal tabstop=4
  setlocal softtabstop=4
  setlocal noexpandtab
  setlocal foldmethod=expr
  exe 'setlocal path+='.substitute(expand('%:p'),'/boomerang/.*','/boomerang/include','')
endif
