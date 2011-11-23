"Avoid folding
setlocal fdl=99 fdc=0 fdm=syntax fdn=1 nofen
nnoremap <silent> <buffer> <Space> <PageDown>

"Remapping navigation keys
"nnoremap <silent> <buffer> b <C-B>
nnoremap <silent> <buffer> <CR> <C-]>
"nnoremap <silent> <buffer> <BS> <C-T>
nnoremap <silent> <buffer> u <C-T>
vnoremap <silent> <buffer> <CR> <C-]>

"Undo my crazy text stuff
if &keymap == "dvorak"
  set iminsert=0
endif 
