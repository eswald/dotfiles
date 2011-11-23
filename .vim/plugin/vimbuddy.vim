" Description: VimBuddy statusline character
" Author:      Flemming Madsen <fma@cci.dk>
" Modified:    14-Oct-2005
" Version:     0.9.25
"
" Usage:       Just drop this file into a plugin directory on your runtimepath.
"              It will insert a little character into your statusline.
"              To see him all of the time, :set laststatus=2
"
"              VimBuddy uses the values of 'statusline', 'ruler', and
"              'rulerformat' that are in effect when it is sourced; for best
"              effect, set them in your .vimrc file.  If you want to position
"              VimBuddy yourself, insert %{VimBuddy()} into your 'statusline'.
"

" Install VimBuddy in the statusline
if has('statusline')
	let s:msg  = '%<%f %h%m%r%=%k '
	let s:warn = ' %{VimBuddy()}  '
	let s:err  = s:msg . s:warn
	
	if &stl == ''
		" Simulate the normal statusline
		if has('cmdline_info') && &ruler
			if &rulerformat == ''
				let s:err  = s:msg . '%-12.(%l,%c%V%)' . s:warn . '%P'
			else
				let s:err = s:err . '%-18.18(' . &ruf . '%)'
			endif
		endif
	elseif &stl =~ 'VimBuddy'
		" Use the user's setting
		let s:err = &stl
	else
		" Insert VimBuddy before the last element
		let s:err = substitute(&stl, '%[^%]*$', s:warn . '\0', '')
	endif
	
	execute 'set statusline='.escape(s:err, "\\ \t\|\"")
endif

" Initialize the script variables
let v:errmsg     = v:errmsg     . ' '
let v:statusmsg  = v:statusmsg  . ' '
let v:warningmsg = v:warningmsg . ' '
let s:err  = v:errmsg
let s:msg  = v:statusmsg
let s:warn = v:warningmsg
let s:onemore  = ']'
let s:lastcol  = -1
let s:lastline = -1
let s:lastnose = 0

function! VimBuddy()
	" VimBuddy follows you around the windows
	let buf = bufnr('%')
	if exists('g:actual_curbuf') && g:actual_curbuf != buf
		let padlen = 3 - strlen(''.buf)
		if padlen == 2
			return '  '.buf
		elseif padlen == 1
			return ' '.buf
		else
			return ''.buf
		endif
	endif
	
	" VimBuddy winks once in a while, but not often
	let ccol = col('.')
	let eyes  = (match(getline('.'), '^[:;8]-[/()DoObpÞ]', ccol-1) >= 0) ? ';' : ':'
	
	" VimBuddy responds to system messages
	if s:err != v:errmsg && v:errmsg != ''
		let v:errmsg = v:errmsg . ' '
		let s:err = v:errmsg
		let mouth = '('
		let s:onemore = mouth
	elseif s:warn != v:warningmsg && v:warningmsg != ''
		let v:warningmsg = v:warningmsg . ' '
		let s:warn = v:warningmsg
		let mouth = '|'
		let s:onemore = mouth
	elseif s:msg != v:statusmsg && v:statusmsg != ''
		let v:statusmsg = v:statusmsg . ' '
		let s:msg = v:statusmsg

		" How impressed should we be?
		if v:statusmsg =~ 'lines *$'
			let num = substitute(v:statusmsg, '^\(\d*\).*', '\1', '') + 0
			let mouth = num > 20 ? 'O' : 'o'
			if num > 100
				let eyes = '8'
			endif
		elseif v:statusmsg =~ '^"[^"]*" \d\+L, \d\+C'
			let mouth = ')'
			let eyes = ';'
		else
			let mouth = '/'
		endif

		let s:onemore = mouth
	elseif s:onemore != ''
		let mouth = s:onemore
		let s:onemore = ''
	else
		" Happiness is my favourite mood
		let mouth = ')'
	endif

	" VimBuddy's nose rotates when you type
	let num = s:lastcol - ccol
	let s:lastcol = ccol
	if (num == 1 || num == -1) && s:lastline == line('.')
		let s:lastnose = (4 + s:lastnose + num) % 4
		if s:lastnose == 0
			let nose = '-'
		elseif s:lastnose == 1
			let nose = '/'
		elseif s:lastnose == 2
			let nose = '|'
		else
			let nose = '\'
		endif
	else
		let s:lastline = line('.')
		let s:lastnose = 0
		let nose = '-'
	endif
	
	" Put him all together
	return eyes . nose . mouth
endfunction

