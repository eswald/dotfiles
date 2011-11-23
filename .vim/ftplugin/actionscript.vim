if exists("b:did_ftplugin") | finish | endif

setlocal ts=4 sw=4 noet nowrap tw=150 fo=crql1
setlocal fen fdls=1 fdn=7 fdm=expr fdi=
setlocal fde=EswaldFoldLevel(v:lnum)

let b:delimiter_chars = "s:',\",(:),[:],m:{:}"
