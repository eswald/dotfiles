" Create directories by opening new files within them.
" http://www.ibm.com/developerworks/linux/library/l-vim-script-5/index.html?ca=dat

augroup AutoMkdir
  autocmd!
  autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END

function! EnsureDirExists ()
  let required_dir = expand("%:h")
  if !isdirectory(required_dir)
    call AskQuit("Directory '" . required_dir . "' doesn't exist.", "&Create it?")
    
    try
      call mkdir( required_dir, 'p' )
    catch
      call AskQuit("Can't create '" . required_dir . "'", "&Continue anyway?")
    endtry
  endif
endfunction

function! AskQuit (msg, proposed_action)
  if confirm(a:msg, "&Quit?\n" . a:proposed_action) == 1
    exit
  endif
endfunction
