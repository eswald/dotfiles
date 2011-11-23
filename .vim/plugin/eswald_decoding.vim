" UU Encoding
nnoremap <silent> <Leader>ue :%!uuencode -m /dev/stdout<CR>
nnoremap <silent> <Leader>ud :%!uudecode -o /dev/stdout<CR>
vnoremap <silent> <Leader>ue   !uuencode -m /dev/stdout<CR>
vnoremap <silent> <Leader>ud   !uudecode -o /dev/stdout<CR>

" HTML entity encoding/decoding
function! HtmlEncode()
  silent s/&/\&amp;/eg
  silent s/</\&lt;/eg
  silent s/>/\&gt;/eg
endfunction

function! HtmlDecode()
  silent s/&lt;/</eg
  silent s/&gt;/>/eg
  silent s/&amp/\&;/eg
endfunction

noremap <silent> <Leader>he :call HtmlEncode()<CR>
noremap <silent> <Leader>hd :call HtmlDecode()<CR>

" Decode URL encodings.
nnoremap <silent> <Leader>Ud :%s/%\(\x\x\)/\=nr2char('0x'.submatch(1))/ge<CR>
vnoremap <silent> <Leader>Ud  :s/%\(\x\x\)/\=nr2char('0x'.submatch(1))/ge<CR>

" Decode Quoted-Printable mail
" VimTip #1012, perhaps by Bertram Scharpf
nnoremap <silent> <Leader>Q :%s/=\(\x\x\<BAR>\n\)/\=submatch(1)=='\n'?'':nr2char('0x'.submatch(1))/ge<CR>
vnoremap <silent> <Leader>Q  :s/=\(\x\x\<BAR>\n\)/\=submatch(1)=='\n'?'':nr2char('0x'.submatch(1))/ge<CR>
