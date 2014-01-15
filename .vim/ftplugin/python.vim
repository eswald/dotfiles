setlocal sts=4 sw=4 ts=8 et nowrap tw=78
call EswaldCheckIndent()
setlocal fen fdls=1 fdn=5 fdm=indent fdi=
let python_highlight_all = 1
let b:delimiter_chars = "s:',om:r''':'''#\"\"\"#''',\",(:),[:],{:}"
setlocal iskeyword=@,48-57,_,192-255

setlocal formatoptions-=t
setlocal formatoptions+=c
setlocal formatoptions+=r
setlocal formatoptions-=o
setlocal formatoptions+=q
setlocal formatoptions-=w
setlocal formatoptions-=a
setlocal formatoptions+=n
setlocal formatoptions+=2
setlocal formatoptions+=l
setlocal formatoptions-=m
setlocal formatoptions+=1
try
  setlocal formatoptions+=j
catch
endtry

" Easier tagging and searching
nnoremap <silent> <buffer> <F1> :sp<BAR>tag <C-R>=expand('<cword>')<CR><CR>
nnoremap <buffer> <F2> :!ctags %:p:h/*.py<CR>

" Search for function definition
" Todo: Search for import statements, too.
nnoremap <buffer> [d ?^[<space>\t]*\(def\<bar>class\<bar>import.*\<bar>from<space>.*import.*\)<space>\zs<C-R>=expand('<cword>')<CR>\><CR>

" Blocks, instead of sentences
nnoremap <silent> <buffer> ) /^\s*\zs$\<Bar>\%$<CR>
nnoremap <silent> <buffer> ( ?^\s*\zs$\<Bar>\%^<CR>
