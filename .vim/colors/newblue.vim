" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Eric Wald <breadman@sourceforge.net>
" Last Change:	2004 Apr 12
" Revised from "blue.vim" to my personal preferences

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "newblue"

hi Normal		guifg=white		guibg=darkBlue 	gui=none
hi Underlined	guifg=white		guibg=bg    	gui=underline
hi Constant		guifg=cyan 	    guibg=bg    	gui=none
hi Number		guifg=cyan 	    guibg=bg    	gui=bold
hi Identifier	guifg=green 	guibg=bg    	gui=none
hi Type			guifg=green 	guibg=bg    	gui=bold
hi Function 	guifg=green 	guibg=bg    	gui=underline
hi Statement	guifg=yellow	guibg=bg    	gui=none
hi Label		guifg=yellow 	guibg=bg    	gui=bold
hi Operator		guifg=red   	guibg=bg    	gui=none
hi PreProc		guifg=magenta	guibg=bg    	gui=none
hi Special		guifg=magenta	guibg=bg    	gui=bold
hi Tag    		guifg=magenta	guibg=bg    	gui=underline

hi Comment		guifg=black		guibg=blue  	gui=none
hi Todo			guifg=yellow	guibg=NONE  	gui=underline
hi SpecialKey	guifg=white 	guibg=blue    	gui=bold
hi Directory	guifg=cyan  	guibg=bg    	gui=none
hi Ignore   	guifg=blue  	guibg=bg    	gui=none

hi MoreMsg		guifg=yellow	guibg=black 	gui=bold
hi ModeMsg		guifg=cyan  	guibg=bg    	gui=none
hi Question 	guifg=green 	guibg=bg    	gui=bold
hi WarningMsg	guifg=yellow	guibg=bg    	gui=none
hi ErrorMsg		guifg=yellow 	guibg=black  	gui=none
hi Error		guifg=red   	guibg=black		gui=underline

hi Cursor		guifg=black		guibg=green
hi lCursor  	guifg=black 	guibg=red
hi Search		guifg=yellow	guibg=black
hi IncSearch	guifg=yellow	guibg=black
hi title		guifg=white		guibg=NONE  	gui=bold

hi LineNr		guifg=black 	guibg=darkgrey	gui=bold
hi NonText		guifg=white		guibg=grey25 	gui=bold
hi VertSplit	guifg=darkgrey	guibg=black 	gui=bold
hi StatusLineNC	guifg=blue  	guibg=black 	gui=none
hi StatusLine	guifg=blue  	guibg=black 	gui=bold
hi WildMenu 	guifg=green 	guibg=black 	gui=bold

hi clear Visual
hi Visual		guifg=black		guibg=Cyan

hi DiffChange	guifg=black 	guibg=darkgreen
hi DiffText		guifg=black 	guibg=darkgrey
hi DiffAdd		guifg=black 	guibg=blue
hi DiffDelete   guifg=black 	guibg=red

hi Folded		guifg=cyan  	guibg=blue
hi FoldColumn	guifg=black 	guibg=darkgrey

