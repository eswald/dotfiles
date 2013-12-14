" Session management
set sessionoptions-=options
set sessionoptions-=buffers
set sessionoptions-=winsize
set sessionoptions-=curdir
set sessionoptions-=folds
set sessionoptions-=help
set sessionoptions+=winpos
set sessionoptions+=resize
set sessionoptions+=tabpages

function! SaveCurrentSession()
  " Save the session, if one has loaded,
  " but not while it's still loading.
  if v:this_session != "" && !exists("g:SessionLoad")
    " Todo: Escape any whitespace, particularly spaces
    exe "mksession! " . v:this_session
    
    " Write custom tab names to another file.
    " Source that one, instead of the main session file.
    let lines = ['source '.escape(v:this_session, ' \')]
    for i in range(tabpagenr('$'))
      let name = gettabvar(i, 'tabname')
      if name != ''
	let lines += ['call settabvar('.i.', "tabname", "'.escape(name, '"\').'")']
      endif
    endfor
    call writefile(lines, substitute(v:this_session, '[^/]*$', 'Tab\0', ''))
  endif
endfunction

augroup eswald_sessions
  au!
  " Todo: Make this work properly
  au BufRead session.vim au VimEnter so %
  au VimLeave * call SaveCurrentSession()
  au BufWinEnter * call SaveCurrentSession()
augroup END
