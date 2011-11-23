" Vim syntax file
" Language:	Wiki source file
" Maintainer:	Eric Wald <breadman@users.sourceforge.net
" Last Change:	Today

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

syn clear
syn case match
syn match wikiError	"'\{2,}"
syn match wikiLink	'\<\([A-Z][a-z]\+\)\{2,}\>'
syn region wikiTag	matchgroup=wikiDelim start="\[\[" end="]]" oneline
syn region wikiItalic	matchgroup=wikiDelim start="''" skip="'''.\{-}'''" end="''" oneline contains=wikiItalicBold,wikiError,wikiTag,wikiLink,wikiWarning
syn region wikiBold	matchgroup=wikiDelim start="'''" end="'''" oneline contains=wikiBoldItalic,wikiError,wikiTag,wikiLink,wikiWarning
syn region wikiBoldItalic	contained matchgroup=wikiDelim start="''" end="''" oneline contains=wikiError,wikiTag,wikiLink,wikiWarning
syn region wikiItalicBold	contained matchgroup=wikiDelim start="'''" end="'''" oneline contains=wikiError,wikiTag,wikiLink,wikiWarning

syn case ignore
syn match wikiError	'\<i\.\?e\>\.\?'
syn match wikiError	'\<e\.\?g\>\.\?'
syn match wikiError	'\<n\.\?b\>\.\?'
syn match wikiError	'\<o\.\?k\>\.\?'
syn match wikiError	'\<c\.\?f\>\.\?'
syn match wikiWarning	"\<it'\?s\>'\?"

hi def wikiTag   	ctermfg=DarkMagenta
hi def wikiLink  	ctermfg=DarkMagenta
hi def wikiWarning	ctermfg=yellow
hi def wikiBold  	ctermfg=cyan
hi def wikiItalic	ctermfg=grey
hi def wikiBoldItalic	ctermfg=white
hi def link wikiItalicBold	wikiBoldItalic
hi def link wikiDelim	Ignore
hi def link wikiError	Error

let b:current_syntax = "wiki"

" Test regions:
"none ''italic'' none ''italic'' none
"none '''bold''' none '''bold''' none
"none '''bold ''bold italic'' bold''' none '''bold''' none
"none ''italic '''italic bold''' italic'' none '''bold''' none
"none '''bold ''bold italic'' bold''' none ''italic'' none
"none ''italic '''italic bold''' italic'' none ''italic'' none
