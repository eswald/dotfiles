" Vim color file
" Maintainer:	Eric Wald <eswald@brainshell.org>
" Last Change:	04-Mar-2008
" Mimics a 16-color terminal, even in a gui.

" On a Black background:
"  0 - Black           (None)
"  1 - DarkRed         Constant WarningMsg
"  2 - DarkGreen       Identifier MoreMsg Question
"  3 - DarkYellow      Statement
"  4 - DarkBlue        Folded FoldColumn
"  5 - DarkMagenta     Comment LineNr
"  6 - DarkCyan        Normal
"  7 - (Light)Gray     Type
"  8 - DarkGray        Ignore NonText
"  9 - (Light)Red      Number
" 10 - (Light)Green    Label Title
" 11 - (Light)Yellow   Todo
" 12 - (Light)Blue     PreProc SpecialKey Directory
" 13 - (Light)Magenta  Operator SignColumn
" 14 - (Light)Cyan     Underlined ModeMsg
" 15 - White           Tag

" Other backgrounds:
" Black       on DarkGreen:   DiffAdd
" Black       on DarkYellow:  Search
" Black       on DarkBlue:    StatusLineNC
" Black       on DarkMagenta: Visual
" Black       on DarkCyan:    IncSearch
" DarkRed     on DarkRed:     DiffDelete
" DarkBlue    on DarkBlue:    VertSplit
" LightYellow on DarkBlue:    WildMenu
" LightGray   on DarkRed:     Error
" LightGray   on DarkBlue:    Special StatusLine
" LightGray   on DarkMagenta: DiffChange
" White       on DarkRed:     ErrorMsg
" White       on DarkMagenta: DiffText
" White       on DarkCyan:    VisualNOS

" term options: bold, underline, reverse, italic, standout, NONE

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "linux"

hi Normal term=NONE cterm=NONE ctermfg=6 ctermbg=0 gui=NONE guifg=DarkCyan guibg=Black
hi Ignore term=bold cterm=bold ctermfg=0 ctermbg=0 gui=NONE guifg=DarkGray guibg=bg

" Standard syntax highlighting colors
hi Comment      term=bold      cterm=NONE ctermfg=5 ctermbg=0 gui=NONE guifg=DarkMagenta guibg=bg
hi Constant     term=underline cterm=NONE ctermfg=1 ctermbg=0 gui=NONE guifg=DarkRed     guibg=bg
hi Identifier   term=underline cterm=NONE ctermfg=2 ctermbg=0 gui=NONE guifg=DarkGreen   guibg=bg
hi Statement    term=bold      cterm=NONE ctermfg=3 ctermbg=0 gui=NONE guifg=DarkYellow  guibg=bg
hi PreProc      term=underline cterm=bold ctermfg=4 ctermbg=0 gui=NONE guifg=LightBlue   guibg=bg
hi Type         term=underline cterm=NONE ctermfg=7 ctermbg=0 gui=NONE guifg=LightGray   guibg=bg
hi Special      term=bold      cterm=NONE ctermfg=7 ctermbg=4 gui=NONE guifg=LightGray   guibg=DarkBlue
hi Underlined   term=underline cterm=bold ctermfg=6 ctermbg=0 gui=NONE guifg=LightCyan   guibg=bg
hi Error        term=reverse   cterm=NONE ctermfg=7 ctermbg=1 gui=NONE guifg=LightGray   guibg=DarkRed
hi Todo         term=standout  cterm=bold ctermfg=3 ctermbg=0 gui=NONE guifg=LightYellow guibg=bg

" Secondary syntax categories
hi link String          Constant
hi link Character       Constant
hi      Number          term=underline cterm=bold ctermfg=1 ctermbg=0 gui=NONE guifg=Red     guibg=bg
hi link Boolean         Constant
hi link Float           Number
hi link Function        Identifier
hi link Conditional     Statement
hi link Repeat          Statement
hi      Label           term=underline cterm=bold ctermfg=2 ctermbg=0 gui=NONE guifg=Green   guibg=bg
hi      Operator        term=underline cterm=bold ctermfg=5 ctermbg=0 gui=NONE guifg=Magenta guibg=bg
hi link Keyword         Statement
hi link Exception       Statement
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc
hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type
hi link SpecialChar     Special
hi      Tag             term=underline cterm=bold ctermfg=7 ctermbg=0 gui=NONE guifg=White   guibg=bg
hi link Delimiter       Special
hi link SpecialComment  Special
hi link Debug           Special

" System colors
hi SpecialKey   term=bold           cterm=bold ctermfg=4 ctermbg=0 gui=NONE guifg=LightBlue    guibg=bg
hi NonText      term=bold           cterm=bold ctermfg=0 ctermbg=0 gui=NONE guifg=DarkGray     guibg=bg
hi Directory    term=bold           cterm=bold ctermfg=4 ctermbg=0 gui=NONE guifg=LightBlue    guibg=bg
hi ErrorMsg     term=standout       cterm=bold ctermfg=7 ctermbg=1 gui=NONE guifg=White        guibg=DarkRed
hi IncSearch    term=reverse        cterm=NONE ctermfg=0 ctermbg=6 gui=NONE guifg=Black        guibg=DarkCyan
hi Search       term=reverse        cterm=NONE ctermfg=0 ctermbg=3 gui=NONE guifg=Black        guibg=DarkYellow
hi MatchParen   term=bold           cterm=bold ctermfg=4           gui=NONE                    guibg=DarkMagenta
hi MoreMsg      term=bold           cterm=NONE ctermfg=2 ctermbg=0 gui=NONE guifg=DarkGreen    guibg=bg
hi ModeMsg      term=bold           cterm=bold ctermfg=6 ctermbg=0 gui=NONE guifg=LightCyan    guibg=bg
hi LineNr       term=underline      cterm=NONE ctermfg=5 ctermbg=0 gui=NONE guifg=DarkMagenta  guibg=bg
hi Question     term=standout       cterm=NONE ctermfg=2 ctermbg=0 gui=NONE guifg=DarkGreen    guibg=bg
hi StatusLine   term=bold,reverse   cterm=NONE ctermfg=7 ctermbg=4 gui=NONE guifg=LightGray    guibg=DarkBlue
hi StatusLineNC term=reverse        cterm=NONE ctermfg=0 ctermbg=4 gui=NONE guifg=Black        guibg=DarkBlue
hi VertSplit    term=reverse        cterm=NONE ctermfg=4 ctermbg=4 gui=NONE guifg=DarkBlue     guibg=DarkBlue
hi Title        term=bold           cterm=bold ctermfg=2 ctermbg=0 gui=NONE guifg=LightMagenta guibg=bg
hi Visual       term=reverse        cterm=NONE ctermfg=0 ctermbg=5 gui=NONE guifg=Black        guibg=DarkMagenta
hi VisualNOS    term=bold,underline cterm=bold ctermfg=7 ctermbg=6 gui=NONE guifg=White        guibg=DarkCyan
hi WarningMsg   term=standout       cterm=NONE ctermfg=1 ctermbg=0 gui=NONE guifg=DarkRed      guibg=bg
hi WildMenu     term=standout       cterm=bold ctermfg=3 ctermbg=4 gui=NONE guifg=LightYellow  guibg=DarkBlue
hi Folded       term=standout       cterm=NONE ctermfg=4 ctermbg=0 gui=NONE guifg=DarkBlue     guibg=bg
hi FoldColumn   term=standout       cterm=NONE ctermfg=4 ctermbg=0 gui=NONE guifg=DarkBlue     guibg=bg
hi DiffAdd      term=bold           cterm=NONE ctermfg=0 ctermbg=2 gui=NONE guifg=Black        guibg=DarkGreen
hi DiffChange   term=bold           cterm=NONE ctermfg=7 ctermbg=5 gui=NONE guifg=LightGray    guibg=DarkMagenta
hi DiffDelete   term=bold           cterm=NONE ctermfg=1 ctermbg=1 gui=NONE guifg=DarkRed      guibg=DarkRed
hi DiffText     term=reverse        cterm=bold ctermfg=7 ctermbg=5 gui=NONE guifg=White        guibg=DarkMagenta
hi SignColumn   term=standout       cterm=bold ctermfg=5 ctermbg=0 gui=NONE guifg=LightMagenta guibg=bg
" hi Cursor       
" hi lCursor  	guifg=black 	guibg=red
" hi CursorIM     
