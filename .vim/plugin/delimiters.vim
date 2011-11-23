" ----------------------------------------------------------------------
" File:         delimiters.vim - Automatically insert closing delimiters
" Author:       Eric Wald <breadman@users.sourceforge.net>
" Licence:      This program is free software; you can redistribute it and/or
"               modify it under the terms of the GNU General Public License.
"               See http://www.gnu.org/copyleft/gpl.txt
" Last Change:  18-May-2006
" ----------------------------------------------------------------------

" Available options: chars, use_filetype, keep_indent

" Flags:
" - a (abbreviate): Use an abbreviation instead of a mapping (only useful for words)
" - b (backslash): Don't insert the closer after a backslash
" - m (multiline): Automatically insert a newline before the closer
" - s (string): Don't insert a new delimiter pair within a string
" - o (opener): Don't create a map for the closing tag

if exists('g:delimiter_version') | finish | endif
let g:delimiter_version = '1.0'

" Line continuation used here
let s:save_cpo = &cpo
set cpo&vim

command! RemoveDelimiters silent call s:RemoveMappings()

augroup delimiters
  autocmd!
  autocmd BufWinEnter,FileType * silent call s:SetupBuffer()
augroup END

function! s:UseFiletypeSettings()
  if exists('b:delimiter_chars') || !s:GetValue('use_filetype', 0)
    return
  endif
  let ft = ',' . &filetype . ','
  if ',,' == ft
    let b:delimiter_chars = ''
  elseif ',html,xsl,xml,' =~ ft
    let b:delimiter_chars = '",<:>,(:),[:],{:},m:<!--:-->'
  elseif ',c,cpp,java,perl,' =~ ft
    let b:delimiter_chars = "',\",m:(:),m:[:],m:{:},s:?::"
  elseif ',vim,' =~ ft
    let b:delimiter_chars = "',<:>,(:),[:],{:},s:?::,ams:if:endif,ams:while:endwhile,ams:fun:endfunction"
  elseif ',text,' =~ ft
    let b:delimiter_chars = '",<:>,(:)'
  endif
endfunction

function! s:GetValue(varname, default)
  if exists('b:delimiter_'.a:varname)
    return b:delimiter_{a:varname}
  elseif exists('g:delimiter_'.a:varname)
    return g:delimiter_{a:varname}
  else
    return a:default
  endif
endfunction

function! s:SafeQuote(string)
  return (a:string =~ "'") ? '"' . escape(a:string, '\"') . '"' : "'" . a:string . "'"
endfunction

" Defines the mappings indicated by user variables
function! s:SetupBuffer()
  echom 'SetupBuffer: filetype='.&filetype
  call s:UseFiletypeSettings()
  
  let chars = s:GetValue('chars', '",(:),[:],{:}')
  let ends = '^\V\%(' " Fix syntax highlighting: \)
  let mapcmd = 'silent! inoremap <unique> <silent> <buffer>'
  let abcmd = 'silent! inoreabb <buffer>'
  echom 'SetupBuffer: chars='.chars
  
  let mainflags = ''
  if s:GetValue('backslash', 0)
    let mainflags = mainflags . 'b'
  endif
  if s:GetValue('multiline', 0)
    let mainflags = mainflags . 'm'
  endif
  if s:GetValue('string', 0)
    let mainflags = mainflags . 's'
  endif
  echom 'SetupBuffer: mainflags='.mainflags
  
  while chars != ''
    let chars = substitute(chars, '^,\+', '', '')
    let delim = substitute(chars, '[^\\]\zs,.*$', '', '')
    let chars = substitute(chars, '^.\{-}\%([^\\],\|$\)', '', '')
    let flags = mainflags
    
    if delim =~ '^[a-z]*:'
      let flags = substitute(delim, ':.*$', '', '')
      let delim = substitute(delim, '^[^:]*:', '', '')
    endif
    
    let cmd = (flags =~ 'a') ? abcmd : mapcmd
    
    if delim =~ '[^\\]:.'
      " A pair of marks, used as delimiters
      let open  = substitute(delim, '[^\\]\zs:.*$', '', '')
      let close = substitute(delim, '^.\{-}[^\\]:', '', '')
      let open  = substitute(open, '\\\([:\\,]\)', '\1', 'g')
      let close = substitute(close, '\\\([:\\,]\)', '\1', 'g')
      
      if flags =~ 'm'
        let ends = ends . escape(close, '\') . '\|'
      endif
      
      if flags =~ '[bs]'
        execute cmd open
              \ '<C-R>=<SID>InsertPair(' s:SafeQuote(open) ','
              \ s:SafeQuote(close) ', "' . flags . '")<CR>'
      else
        execute cmd open
              \ open . close . s:StringMultiply('<Left>', strlen(close))
      endif
      
      if flags !~ 'o'
        execute cmd close
              \ '<C-R>=<SID>InsertDelim('.s:SafeQuote(close).', 1, "'.flags.'")<CR>'
      endif
    elseif delim != ''
      " A single mark, used like a quotation mark
      let delim = substitute(delim, '\\\([:\\,]\)', '\1', 'g')
      if flags =~ 'm'
        let ends = ends . escape(delim, '\') . '\|'
      endif
      execute cmd delim
            \ '<C-R>=<SID>InsertDelim('.s:SafeQuote(delim).', 0, "'.flags.'")<CR>'
    endif
  endwhile
  
  " Set buffer variables for ReturnWrapper()
  let b:delimiter_endings = substitute(ends, '|$', ')', '')
  if b:delimiter_endings !~ ')' | unlet b:delimiter_endings | endif
endfunction

function! s:RemoveMappings()
  echom 'RemoveMappings: filetype='.&filetype
  call s:UseFiletypeSettings()
  
  let chars = s:GetValue('chars', '",(:),[:],{:}')
  let ends = '^\V\%(' " Fix syntax highlighting: \)
  let mapcmd = 'silent! iunmap <buffer>'
  let abcmd = 'silent! iunabb <buffer>'
  echom 'RemoveMappings: chars='.chars
  
  while chars != ''
    let chars = substitute(chars, '^,\+', '', '')
    let delim = substitute(chars, '[^\\]\zs,.*$', '', '')
    let chars = substitute(chars, '^.\{-}\%([^\\],\|$\)', '', '')
    let flags = ''
    
    if delim =~ '^[a-z]*:'
      let flags = substitute(delim, ':.*$', '', '')
      let delim = substitute(delim, '^[^:]*:', '', '')
    endif
    
    let cmd = (flags =~ 'a') ? abcmd : mapcmd
    
    if delim =~ '[^\\]:.'
      " A pair of marks, used as delimiters
      let open  = substitute(delim, '[^\\]\zs:.*$', '', '')
      let close = substitute(delim, '^.\{-}[^\\]:', '', '')
      let open  = substitute(open, '\\\([:\\,]\)', '\1', 'g')
      let close = substitute(close, '\\\([:\\,]\)', '\1', 'g')
      
      execute cmd open
      execute cmd close
    elseif delim != ''
      " A single mark, used like a quotation mark
      let delim = substitute(delim, '\\\([:\\,]\)', '\1', 'g')
      execute cmd delim
    endif
  endwhile
endfunction

" Overcome a major Vim failing
" This method is less efficient than Benji Fisher's for large numbers,
" but we don't expect to multiply by more than about four.
function! s:StringMultiply(string, number)
  let result = a:string
  let len = 1
  while len < a:number
    let result = result . a:string
    let len = len + 1
  endwhile
  return result
endfunction

" Insert a new pair of delimiters, unless
"  a) in a string, and flags includes 's'
"  b) after a backslash, and flags includes 'b'
function! s:InsertPair(opening, closing, flags)
  let lnum = line('.')
  let line = getline(lnum)
  let col = col('.') - 1
  let syntx = synIDattr(synID(lnum, col, 0), 'name')
  echom 'InsertPair('.a:opening.','.a:closing.','.a:flags.','.syntx.')'
  
  if a:flags =~ 'b' && strpart(line, col - 1, 1) == '\'
    echom 'InsertPair option 1'
    " Insert an escaped delimiter directly
    return a:opening
  elseif a:flags =~ 's' && syntx =~? '\(string\)\|\(comment\)'
    echom 'InsertPair option 2'
    " Insert just the opening inside a string or a comment
    return a:opening
  else
    echom 'InsertPair option 3'
    " Insert both parts of the pair
    return a:opening . a:closing . 
          \ s:StringMultiply("\<Left>", strlen(a:closing))
  endif
endfunction

" Insert a new delimiter, unless
"  a) at the end of the line, and the first non-whitespace
"     character on the next line starts the delimiter; or
"  b) the character under the cursor starts the delimiter
" In certain situations, insert two of an unpaired delimiter.
function! s:InsertDelim(delim, paired, flags)
  let lnum = line('.')
  let line = getline(lnum)
  let col = col('.') - 1
  let syntx = synIDattr(synID(lnum, col, 0), 'name')
  
  let len = strlen(a:delim)
  let right = s:StringMultiply("\<Right>", len)
  let insert = a:paired ? a:delim :
        \ a:delim . a:delim . s:StringMultiply("\<Left>", len)

  if a:flags =~ 'b' && strpart(line, col - 1, 1) == '\'
    echom 'InsertDelim option 1'
    " Insert an escaped delimiter directly
    return a:delim
  elseif strpart(line, col, len) == a:delim
    echom 'InsertDelim option 2'
    " Pass right through the one already there
    return right
  elseif a:flags =~ 's' && syntx =~? '\(string\)\|\(comment\)'
    echom 'InsertDelim option 3'
    " Insert just one inside a string or a comment
    return a:delim
  elseif a:flags =~ 'm' && strpart(line, col) !~ '\S'
    echom 'InsertDelim option 4'
    " Pass through one on the next line, if it's there
    let mstr = escape(a:delim, '\')
    echom 'mstr = ' s:SafeQuote(mstr)
    let nextline = getline(lnum + 1)
    echom 'nextline = ' . s:SafeQuote(nextline)
    if strpart(nextline, 0, len) == a:delim
    echom 'InsertDelim option 4.1'
      normal! j0
      return right
    elseif nextline =~ '^\s\+\V' . mstr
    echom 'InsertDelim option 4.2'
      if a:delim =~ '^\s'
    echom 'InsertDelim option 4.2.1'
        execute 'normal! j0/\V' . mstr . "\<CR>"
      else
    echom 'InsertDelim option 4.2.2'
        normal! j^
      endif
      return right
    else
    echom 'InsertDelim option 4.3'
      " None on the next line; close or start a new block
      return insert
    endif
  else
    echom 'InsertDelim option 5'
    " Close or start a block
    return insert
  endif
endfunction

" Insert a carriage return, opening multiline blocks properly.
silent! inoremap <unique> <silent> <CR> <C-R>=<SID>ReturnWrapper()<CR>
function! s:ReturnWrapper()
  let tail = strpart(getline('.'), col('.') - 1)
  if tail =~ s:GetValue('endings', "^\<Plug><Plug>$")
    " Open a new line before closing multiline delimiters
    return "\<CR>\<C-O>O"
  elseif tail =~ '^\s\+\S'
    " Fix a rare indentation error
    normal! dw
    return "\<CR>"
  elseif s:GetValue('keep_indent', 0)
    " Don't let smartindent kill the indentation
    return " \<BS>\<CR>"
  endif
  
  " Reasonable default behavior
  return "\<CR>"
endfunction

" Reset compatibility
let &cpo = s:save_cpo
unlet s:save_cpo

" vim: sts=2 ts=8 et
