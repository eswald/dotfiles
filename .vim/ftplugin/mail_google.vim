" Get rid of the blank lines, email address, and extraneous date info
if expand('%') =~ 'mail\.google\.com'
  while getline(1) == ''
    1delete
  endwhile
  
  1s/ *<[^>]\+@[^>]\+\.[^>]\+> wrote/ wrote/e
  1s/ \d\+ at \d\+:\d\d [AP]M, / /e
  if exists('*strftime')
    execute strftime('s/On %a, %b *%e, //e')
  endif
endif
