" Indent settings guesser.
function! EswaldCheckIndent()
  let l:lastline = line('$')
  if l:lastline > 1024
    " Don't run forever on huge files.
    let l:lastline = 1024
  endif
  
  let l:index = 0
  let l:lasttabs = 0
  let l:lastindent = 0
  let l:tablines = 0
  let l:spacelines = 0
  let l:counts = [0, 0, 0, 0, 0, 0, 0, 0, 0]
  while l:index < l:lastline
    let l:index += 1
    let l:line = getline(l:index)
    
    " Ignore lines likely to give odd results.
    " Whitespace lines, comment lines, and mixed tabs, for example.
    if l:line =~ '^\s*$\|^\s*[/*#{}]%\@!\|^ \+\t'
      continue
    endif
    
    if l:line =~ '^\t'
      let l:tablines += 1
      let l:lasttabs = strlen(matchstr(l:line, '^\t*'))
      if l:lastindent > 0
	let l:diff = l:lastindent / l:lasttabs
	if l:diff * l:lasttabs == l:lastindent
	  if l:diff <= 8
	    " Guess that the tabs were meant to match the surrounding spaces.
	    let l:counts[l:diff] += 1
	  endif
	endif
      endif
      let l:lastindent = 0
      continue
    endif
    
    let l:spaces = strlen(matchstr(l:line, '^ *'))
    if l:spaces > 0
      let l:spacelines += 1
    endif
    
    if l:lasttabs > 0
      if l:spaces > 0
	let l:diff = l:spaces / l:lasttabs
	if l:diff * l:lasttabs == l:spaces
	  if l:diff <= 8
	    " Guess that the spaces were meant to match the surrounding tabs.
	    let l:counts[l:diff] += 1
	  endif
	endif
      endif
      let l:lasttabs = 0
    else
      let l:diff = l:spaces - l:lastindent
      if l:diff < 0
	" abs() isn't always available.
	let l:diff = -l:diff
      endif
      if l:diff <= 8
	let l:counts[l:diff] += 1
      endif
    endif
    
    let l:lastindent = l:spaces
  endwhile
  
  let l:spaces = 0
  let l:lines = 0
  let l:index = 1
  while l:index < 8
    let l:index += 1
    if l:counts[l:index] > l:lines
      let l:spaces = l:index
      let l:lines = l:counts[l:index]
    endif
  endwhile
  
  if l:tablines > 2 * l:spacelines
    " Use tabs for indenting.
    if l:lines > 2
      " Let the tabs match the surrounding spaces.
      let &l:shiftwidth = l:spaces
      let &l:softtabstop = l:spaces
    else
      " Use the preset value for shiftwidth,
      " but ensure that the tabstop matches it.
      let &l:tabstop = &l:shiftwidth
    endif
    setlocal noexpandtab
  elseif l:spacelines > 2 * l:tablines
    " Use spaces for indenting.
    let &l:shiftwidth = l:spaces
    let &l:softtabstop = l:spaces
    let &l:tabstop = l:spaces
    setlocal expandtab
  endif
endfunction
