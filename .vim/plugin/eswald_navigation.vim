" Custom navigation keymaps

" Allow insert-mode backspaces to backspace over anything.
set backspace=2

" Control-movement switches windows.
" <C-L> also keeps its screen-redraw functionality.
noremap <C-K> <C-W>W<C-W>_
noremap <C-J> <C-W>w<C-W>_
noremap <C-L> <C-W>l<C-W>_<C-L>
noremap <C-H> <C-W>h<C-W>_

" K and J page up and down.
noremap K <C-B>
noremap J <C-F>

" H and L go to the start and end of the line.
noremap L lg$
noremap H hg0

" j and k move within a wrapped line.
noremap j gj
noremap k gk

" Ins/Del work like Lynx: Two lines up or down, scrolling if possible.
nnoremap <Insert> 2<C-U>
nnoremap <Delete> 2<C-D>

" After remapping J and adding a new map for gj,
" we can use the latter as a new map for the former.
noremap gj J

" Use Emacs-style readline keys on the command line.
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-F> <Right>
set cedit=


" Use backspace to navigate the jump list.
nnoremap <BS> <C-O>
nnoremap <S-BS> <C-I>


" Searching
set ignorecase smartcase
set nohlsearch

" Make n/N always search forward/backward, respectively
nnoremap # *NN

" Search within a visual range
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l

" Search for a visually selected item
vnoremap * "9y/<C-R>=substitute(escape(@9, '\\/.*$^~[]'), '[ \t\n\r]\+', '\\_s\\+', 'g')<CR><CR>
vnoremap # "9y?<C-R>=substitute(escape(@9, '\\/.*$^~[]'), '[ \t\n\r]\+', '\\_s\\+', 'g')<CR><CR>

" Re-search, ignoring space and caps differences
nnoremap g/ /\c<C-R>=substitute(@/, '[ \t\n\r]\+', '\\_s\\+', 'g')<CR><CR>

" New maps for character searches within a line,
" to leave ; open for another command.
noremap <Tab> ;
noremap m; ;
noremap m, ,


" Standard help key
nnoremap <silent> <F1> :sp<BAR>tag <C-R>=expand('<cword>')<CR><CR>

" Let gf open new windows
nnoremap gf :sp <cfile><CR>

" Quickfix editing
nnoremap <C-N> :cnext<CR>
nnoremap <C-P> :cprev<CR>
set switchbuf+=useopen,split

" Enhance C-^ to go to next file unless an alternate exists
" VimTip #1023, by Yakov Lerner
function! s:SwitchFile()
  if expand('#') == ''
    silent! next
  else
    normal! 
  endif
endfunction
map <silent> <C-^> :call <SID>SwitchFile()<CR>

" Indent-aware block movement functions
function! EswaldNextBlankLine(mode)
  if a:mode == 'v'
    " Restore the visual selection
    normal! gv
  endif
  
  " Move to the next blank line at the same or lower indentation level.
  let l:index = nextnonblank('.')
  let l:lastline = line('$')
  
  if l:index == 0
    normal! G
    return
  endif
  
  let l:indent = indent(l:index)
  while l:index < l:lastline
    let l:index += 1

    let l:folded = foldclosedend(l:index)
    if l:folded > 0
      " This line is in a fold.
      " Skip the folded lines for efficiency.
      let l:index = l:folded
      continue
    endif
    
    let l:nonblank = nextnonblank(l:index)
    if l:nonblank > l:index
      " This line is blank.  Should we stop here?
      if indent(l:nonblank) <= l:indent
	" Yes: The next line starts a new block.
	break
      else
	" No: The next line is another part of the same block.
	" Skip the blank lines for efficiency.
	let l:index = l:nonblank
	continue
      endif
    elseif l:nonblank == 0
      " The rest of the file is blank.  Stop here.
      break
    endif
  endwhile
  
  " Move to the found line.
  exec 'normal' l:index . 'gg'
endfunction

function! EswaldPrevBlankLine(mode)
  if a:mode == 'v'
    " Restore the visual selection
    normal! gv
  endif
  
  " Move to the previous blank line at the same or lower indentation level.
  let l:index = prevnonblank('.')
  
  if l:index == 0
    normal gg
    return
  endif
  
  let l:iline = nextnonblank('.')
  if l:iline == 0
    let l:iline = l:index
  endif
  
  let l:indent = indent(l:iline)
  while l:index > 1
    let l:prevline = l:index
    let l:index -= 1

    let l:folded = foldclosed(l:index)
    if l:folded > 0
      " This line is in a fold.
      " Skip the folded lines for efficiency.
      let l:index = l:folded
      continue
    endif
    
    let l:nonblank = prevnonblank(l:index)
    if l:nonblank == 0
      " The rest of the file is blank.  Stop here.
      break
    elseif l:nonblank < l:index
      " This line is blank.  Should we stop here?
      if indent(l:prevline) <= l:indent
	" Yes: The previous line starts a new block.
	break
      else
	" No: The previous line is another part of the same block.
	" Skip the blank lines for efficiency.
	let l:index = l:nonblank
      endif
    elseif indent(l:index) < l:indent
      " Let the smallest indent in the block define its beginning.
      let l:indent = indent(l:index)
    endif
  endwhile
  
  " Move to the found line.
  exec 'normal' l:index . 'gg'
endfunction

function! EswaldNextUnfoldedBlankLine(mode)
  if a:mode == 'v'
    " Restore the visual selection
    normal! gv
  endif
  
  " Move to the next blank line not inside a closed fold.
  let l:index = nextnonblank('.')
  let l:lastline = line('$')
  
  while l:index < l:lastline
    let l:index += 1

    let l:folded = foldclosedend(l:index)
    if l:folded > 0
      " This line is in a fold.
      " Skip the folded lines for efficiency.
      let l:index = l:folded
      continue
    endif

    let l:nonblank = nextnonblank(l:index)
    if l:nonblank == 0
      " The rest of the file is blank.  Stop here.
      break
    elseif l:nonblank > l:index
      " Blank line that's not in a fold.
      break
    endif
  endwhile
  
  " Move to the found line.
  exec 'normal' l:index . 'gg'
endfunction

function! EswaldPrevUnfoldedBlankLine(mode)
  if a:mode == 'v'
    " Restore the visual selection
    normal! gv
  endif
  
  " Move to the previous blank line not inside a closed fold.
  let l:index = prevnonblank('.')
  
  while l:index > 1
    let l:index -= 1

    let l:folded = foldclosed(l:index)
    if l:folded > 0
      " This line is in a fold.
      " Skip the folded lines for efficiency.
      let l:index = l:folded
      continue
    endif
    
    let l:nonblank = prevnonblank(l:index)
    if l:nonblank == 0
      " The rest of the file is blank.  Stop here.
      break
    elseif l:nonblank < l:index
      " Blank line that's not in a fold.
      break
    endif
  endwhile

  " Move to the found line.
  exec 'normal' l:index . 'gg'
endfunction

noremap <silent> } :call<space>EswaldNextBlankLine(mode())<CR>
noremap <silent> { :call<space>EswaldPrevBlankLine(mode())<CR>
vnoremap <silent> } :<C-U>call<space>EswaldNextBlankLine('v')<CR>
vnoremap <silent> { :<C-U>call<space>EswaldPrevBlankLine('v')<CR>
