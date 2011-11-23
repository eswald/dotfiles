" Vim syntax file
" Language:     Plain Text, with some markup
" Maintainer:   Eric Wald <eswald@brainshell.org>
" Last change:  13-Jul-2006

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Decide whether to include hyphens, underscores, and the like in words
setlocal iskeyword+='

syn case ignore

syn keyword textTodo 		todo fixme
syn match   textLink		/<\%(\%(URL\|LNK\)[:=]\)\(.\{-}\)>/
syn match   textLink		"<\%(\a\|\d\|[.+-]\)\+:\%(//\)\?\%(\%(\w\|[#-'*-.=|]\)*\%(:.*\)\?@\)\?\%(\w\|[#-'*-.=|]\)*\%(\w\|[$-'*-/:=|?@~]\)*\%(#\%(\w\|[$-'*-.:=|?@~]\)*\)\?>"
syn match   textLink		/<\%(\w\|[.]\)\+@\%(\w\+.\)\+\w\+>/
syn match   textLink		`\v<(((https?|ftp|gopher)://|(mailto|file|news):)[^' 	<>"]+|(www|web|w3)[a-z0-9_-]*\.[a-z0-9._-]+\.[^' 	<>"]+)[a-z0-9/]`

" Start- and end-string recognition rules as used by reStructuredText,
" except for a couple of exclusion rules.
" http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#inline-markup
" syn match   textContinue	'[/*_] $' extend containedin=textBold,textItalics,textUnderline
syn region  textBold		oneline matchgroup=textDelims start='\%(^\|\s\|['"({</:[-]\)\zs\*\ze\S' end='\S\zs\*\ze\([]'")}>/:.,;!?\\-]\|\s\|$\)'
syn region  textItalics		oneline matchgroup=textDelims start='\%(^\|\s\|['"({</:[-]\)\zs/\ze\S' end='\S\zs/\ze\([]'")}>/:.,;!?\\-]\|\s\|$\)'
syn region  textUnderline	oneline matchgroup=textDelims start='\%(^\|\s\|['"({</:[-]\)\zs_\ze\S' end='\S\zs_\ze\([]'")}>/:.,;!?\\-]\|\s\|$\)'

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_text_syntax_inits")
  if version < 508
    let did_pcc_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
    command -nargs=+ HiDef  hi <args>
  else
    command -nargs=+ HiLink hi def link <args>
    command -nargs=+ HiDef  hi def <args>
  endif

  HiDef  textBold	term=bold cterm=bold gui=bold
  HiDef  textItalics	term=standout ctermfg=7 gui=italic
  HiDef  textUnderline	term=underline ctermbg=5 gui=underline

  HiLink    textLink	Tag
  HiLink    textTodo	Todo
  HiLink    textDelims	Ignore
  HiLink    textContinue	Ignore

  delcommand HiLink
  delcommand HiDef
endif

let b:current_syntax = "text"
" vim: ts=8 sw=2 noexpandtab
