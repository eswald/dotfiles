setlocal sts=4 sw=4 ts=8 et nowrap tw=98
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
nnoremap <silent> <buffer> ) :call<space>search('^\s*$\<Bar>\%$','We')<CR>
nnoremap <silent> <buffer> ( :call<space>search('^\s*$\<Bar>\%^','Web')<CR>

" Change keyword argument lines to dictionary format.
nnoremap <silent> <buffer> <leader>d :s/\(\w\+\) *= */"\1": /<CR>
vnoremap <silent> <buffer> <leader>d :s/\(\w\+\) *= */"\1": /<CR>

" Change dictionary entries to keyword arguments.
nnoremap <silent> <buffer> <leader>D :s/\(['"]\)\(\w\+\)\1 *: */\2 = /<CR>
vnoremap <silent> <buffer> <leader>D :s/\(['"]\)\(\w\+\)\1 *: */\2 = /<CR>
