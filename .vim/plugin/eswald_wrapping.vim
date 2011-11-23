" Maps for wrapping selected text in various delimiters.
" Based on http://vim.wikia.com/wiki/Surround_selection_with_text
" See also the Surround plugin: http://www.vim.org/scripts/script.php?script_id=1697

" Wrap highlighted text in doublequotes.
" Quicker, but less correct than the below.
"vnoremap [q "zdi"<C-R>z"<Esc>

" Surrounding a selection with specific text
fun! Surround(s1, s2) range
  exe "normal vgvmboma\<ESC>"
  normal `a
  let lineA = line(".")
  let columnA = col(".")
  
  normal `b
  let lineB = line(".")
  let columnB = col(".")
  
  " exchange marks
  if lineA > lineB || lineA <= lineB && columnA > columnB
    " save b in c
    normal mc
    " store a in b
    normal `amb
    " set a to old b
    normal `cma
  endif
  
  exe "normal! `ba" . a:s2 . "\<ESC>`ai" . a:s1 . "\<ESC>"
endfun

" Command-line access, though a little odd in line-based visual mode.
command! -range -nargs=* Sur call Surround(<f-args>)

" Sample commands
vnoremap _" :call Surround('"', '"')<CR>
vnoremap _( :call Surround('(', ')')<CR>
vnoremap _[ :call Surround('[', ']')<CR>
vnoremap _{ :call Surround('{', '}')<CR>

" Wrap ansii color character commands around the selected text.
" Good for adding color to stdout. [b=blue, [r=red, etc
vnoremap [r :call Surround("<C-V><C-V><C-V><Esc>[1;31m", "<C-V><C-V><C-V><Esc>[0m")<CR>
vnoremap [g :call Surround("<C-V><C-V><C-V><Esc>[1;32m", "<C-V><C-V><C-V><Esc>[0m")<CR>
vnoremap [y :call Surround("<C-V><C-V><C-V><Esc>[1;33m", "<C-V><C-V><C-V><Esc>[0m")<CR>
vnoremap [b :call Surround("<C-V><C-V><C-V><Esc>[1;34m", "<C-V><C-V><C-V><Esc>[0m")<CR>
vnoremap [m :call Surround("<C-V><C-V><C-V><Esc>[1;35m", "<C-V><C-V><C-V><Esc>[0m")<CR>
vnoremap [c :call Surround("<C-V><C-V><C-V><Esc>[1;36m", "<C-V><C-V><C-V><Esc>[0m")<CR>
