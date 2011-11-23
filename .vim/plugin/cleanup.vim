function! s:cleanup() range
  execute 'normal! ' . a:firstline . 'ggmg'
  execute 'normal! ' . a:lastline . 'ggmh'
  
  'g,'hs@^//\(\t\+\)@\1//@e                               " Move comments from the beginning of a line to after the indent
  'g,'hs@}\zs\s*//\s*end.*@@e                             " Remove end-of-block comments
  'g,'hs/\S\zs\s\+$//e                                    " Remove whitespace at the end of each line
  'g,'hs/(\zs\s*\([^()]\+\)\(\n\s*\),\(.*\)$/\2\1,\2\3/e  " Move the first item of a multi-line comma-prefixed list to the next line
  'g,'hs/\(array\)\@<!(\zs\(\n\s*\)\+\ze\S//e             " Move the first argument of function calls onto the same line
  'g,'hs/array(\zs\([^()]\+\)\(\n\s*\)\(.*\)/\2\1\2\3/e   " Move the first element of a multi-line array to the next line
  'g,'hs/=>.*[^,]\zs\ze\n\s*)/,/e                         " Add a comma after the last element in an array
  'g,'hs/array(.*\zs,\ze)//e                              " Remove commas at the end of single-line arrays
  'g,'hs/[^,]\zs\n\s*\ze)//e                              " Remove newlines before the end of an argument list
  'g,'hs/\(\s*\/\/.*\|\)\(\n\s*\),/,\1\2/e                " Move commas from the beginning of a line to the end of the previous
  
  'g,'hs/\w\zs\s\+(/(/ge                                  " Remove spaces after function names
  'g,'hs/\<\(if\|els\?e\?if\|for\|foreach\|while\|switch\)\>(/\1 (/e  " Add a space between keywords and their conditions
  'g,'hs/){/) {/e                                         " Add a space between keyword conditions and block braces
  'g,'hs/\s*\n\s*{\s*$/ {/e                               " Move opening braces to the end of the previous line
  'g,'hs/^\(\s*\)\(if.*)\|else\|} else\)\(\n\1\s\+\S.*;\n\)/\1\2 {\3\1}\r/e  " Add braces around one-line blocks
  'g,'hs/}\zs\_s*\zeelse/ /e                              " Consolidate whitespace before else statements
  'g,'hs/else\_s*{/else {/e                               " Ensure a single space between an else statement and its opening brace
  'g,'hs/^\(.*{\n\)\(\s*\n\)\+/\1/e                       " Remove empty lines at the beginning of blocks
  'g+1,'h-1s/^\(\s*\)\(}\|)\+;\)\(\n\s*\)\(\S\)/\1\2\3\3\4/e  " Add an empty line after each block or multi-line statement
  'g,'hs/^\(\s*\n\)\+\ze\s*}//e                           " Remove empty lines at the end of blocks
  'g,'hs/\(,\)\s*\ze\S/\1 /ge                             " Use a single space between certain separators and the next item
  'g,'hs/\s\+\([;:,]\)/\1/ge                              " Remove any whitespace before certain separators
  'g,'hs/^\s*\k\+\(\[.\{-}\]\|\)\zs\s*=\s*\ze[^ \n\t>]/ = /ge  " Surround assignments with single spaces
  'g,'hs/\s*=>\s*/ => /ge                                 " Surround arrow operators with single spaces
  
  normal! 'g='h                                           " Re-indent, using the standard algorithm
  'g,'hs/^\ze\n\+\([\t ]\+\)/\1/e                         " Add indent space to blank lines
endf

nmap <unique> <Leader>cl <Plug>CleanupAll
vmap <unique> <Leader>cl <Plug>CleanupRange
nmap <silent> <Plug>CleanupAll :%call <SID>cleanup()<CR>
vmap <silent> <Plug>CleanupRange :call <SID>cleanup()<CR>

"silent! so %
