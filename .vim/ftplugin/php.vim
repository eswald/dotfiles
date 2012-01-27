" Don't load again for the same buffer (but let the main plugin file set this)
if exists("b:did_ftplugin") | finish | endif

setlocal nowrap tw=150 fo=crql1
setlocal fen fdls=1 fdn=7 fdm=indent fdi=

let s:tablines = 0
let s:spacelines = 0
let s:pos = getpos('.')
try
  redir => subcount
  silent %s/^\t//ne
  redir END
  if strlen(subcount)
    let s:tablines = matchstr(subcount, '\d\+') + 0
  endif
  
  redir => subcount
  silent %s/^    //ne
  redir END
  if strlen(subcount)
    let s:spacelines = matchstr(subcount, '\d\+') + 0
  endif
finally
  redir END
  call setpos('.', s:pos)
endtry

if s:tablines > s:spacelines
  " Use tabs for indenting.
  let s:indenter = 'tabs'
  setlocal sw=4 ts=4 noet
else
  " Use spaces for indenting.
  let s:indenter = 'spaces'
  setlocal sw=4 sts=4 ts=8 et
endif


" Let dollar signs be counted as part of the name
setlocal isk+=$

" Syntax settings
let php_sql_query = (expand('%:p') =~ '/models/')
"let php_baselib = 1
let php_htmlInStrings = (expand('%:e') == 'thtml')
"let php_oldStyle = 1
"let php_asp_tags = 1
"let php_noShortTags = 1
"let php_parent_error_close = 1
"let php_parent_error_open = 1
"let php_folding = 1
"let php_sync_method = x

let b:delimiter_chars = "s:',\",(:),[:],m:{:}"

" Normal HTML text has no synID-name. So we have to specify this problem case here.
" Note that you should not try to comment lines starting with '<?'.
call EnhCommentifyFallback4Embedded('&ft == "php" && synFiletype == ""', "html")

" Search for function definition
nnoremap <buffer> [d /function<space>&\?<C-R>=expand('<cword>')<CR><CR>

" Blocks, instead of sentences
nnoremap <buffer> ) /^\s*\zs$<CR>
nnoremap <buffer> ( ?^\s*\zs$<CR>
