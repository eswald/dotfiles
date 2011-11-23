" Options for plain-text files
setlocal fdl=99 fdm=manual
setlocal comments=fb:-,fb:*

iab <buffer> y and

vnoremap <buffer> <C-U> <C-\><C-N>g`>a_<C-\><C-N>g`<i_<C-\><C-G>
vnoremap <buffer> <C-B> <C-\><C-N>g`>a*<C-\><C-N>g`<i*<C-\><C-G>

" Italics would be nice, but <C-I> also happens to be <Tab>...
"vnoremap <buffer> <C-I> <C-\><C-N>g`>a/<C-\><C-N>g`<i/<C-\><C-G>

if &keymap == "dvorak"
  "set iminsert=1
endif 
