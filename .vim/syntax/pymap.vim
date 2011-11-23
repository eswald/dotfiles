" Vim syntax file
" Language:	PyDip .tty file
" Maintainer:	Eric Wald <breadman@users.sourceforge.net
" Last Change:	Today

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

syn clear
syn match mapBlack	'0'
syn match mapRed	'1'
syn match mapGreen	'2'
syn match mapYellow	'3'
syn match mapBlue	'4'
syn match mapMagenta	'5'
syn match mapCyan	'6'
syn match mapWhite	'7'
hi def mapBlack  	ctermfg=DarkGray	ctermbg=black
hi def mapRed    	ctermfg=red 	ctermbg=red
hi def mapGreen  	ctermfg=green	ctermbg=green
hi def mapYellow 	ctermfg=yellow	ctermbg=yellow
hi def mapBlue   	ctermfg=blue	ctermbg=blue
hi def mapMagenta	ctermfg=magenta	ctermbg=magenta
hi def mapCyan   	ctermfg=cyan	ctermbg=cyan
hi def mapWhite  	ctermfg=white	ctermbg=white

let b:current_syntax = "pymap"
