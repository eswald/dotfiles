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
