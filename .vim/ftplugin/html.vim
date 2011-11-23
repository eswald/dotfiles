" Don't overwrite settings for PHP files
if &ft == 'html'
  setlocal ts=8 sw=2 sts=2 et tw=78
endif

vnoremap <buffer> <C-U> <C-\><C-N>g`>a<lt>/u><C-\><C-N>g`<i<lt>u><C-\><C-G>
vnoremap <buffer> <C-B> <C-\><C-N>g`>a<lt>/b><C-\><C-N>g`<i<lt>b><C-\><C-G>

" Italics would be nice, but <C-I> also happens to be <Tab>...
"vnoremap <buffer> <C-I> <C-\><C-N>g`>a<lt>/em><C-\><C-N>g`<i<lt>em><C-\><C-G>
