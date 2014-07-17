" Options for plain-text files
setlocal fdl=99 fdm=manual
setlocal comments=fb:-,fb:*

iab <buffer> y and

vnoremap <buffer> <C-U> <C-\><C-N>g`>a_<C-\><C-N>g`<i_<C-\><C-G>
vnoremap <buffer> <C-B> <C-\><C-N>g`>a*<C-\><C-N>g`<i*<C-\><C-G>

" Italics would be nice, but <C-I> also happens to be <Tab>...
"vnoremap <buffer> <C-I> <C-\><C-N>g`>a/<C-\><C-N>g`<i/<C-\><C-G>

" Simplify todo lists.
" Typing a checkmark is hard enough without requiring the replace character command.
nnoremap <buffer> ✓ r✓

" Match an existing indent width, if we find one.
call EswaldCheckIndent()

if &keymap == "dvorak"
  "set iminsert=1
endif 
