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

" Some systems use BGR instead of RGB;
" let g:colorswap = 1 to correct that.
if exists("g:colorswap") && g:colorswap
  let s:black   = 0
  let s:blue    = 1
  let s:green   = 2
  let s:cyan    = 3
  let s:red     = 4
  let s:magenta = 5
  let s:yellow  = 6
  let s:white   = 7
else
  let s:black   = 0
  let s:red     = 1
  let s:green   = 2
  let s:yellow  = 3
  let s:blue    = 4
  let s:magenta = 5
  let s:cyan    = 6
  let s:white   = 7
endif

exec "hi Normal term=NONE cterm=NONE ctermfg=".s:cyan  "ctermbg=".s:black "gui=NONE guifg=DarkCyan guibg=Black"
exec "hi Ignore term=bold cterm=bold ctermfg=".s:black "ctermbg=".s:black "gui=NONE guifg=DarkGray guibg=bg"

" Standard syntax highlighting colors
exec "hi Comment      term=bold      cterm=NONE ctermfg=".s:magenta "ctermbg=".s:black "gui=NONE guifg=DarkMagenta guibg=bg"
exec "hi Constant     term=underline cterm=NONE ctermfg=".s:red     "ctermbg=".s:black "gui=NONE guifg=DarkRed     guibg=bg"
exec "hi Identifier   term=underline cterm=NONE ctermfg=".s:green   "ctermbg=".s:black "gui=NONE guifg=DarkGreen   guibg=bg"
exec "hi Statement    term=bold      cterm=NONE ctermfg=".s:yellow  "ctermbg=".s:black "gui=NONE guifg=DarkYellow  guibg=bg"
exec "hi PreProc      term=underline cterm=bold ctermfg=".s:blue    "ctermbg=".s:black "gui=NONE guifg=LightBlue   guibg=bg"
exec "hi Type         term=underline cterm=NONE ctermfg=".s:white   "ctermbg=".s:black "gui=NONE guifg=LightGray   guibg=bg"
exec "hi Special      term=bold      cterm=NONE ctermfg=".s:white   "ctermbg=".s:blue  "gui=NONE guifg=LightGray   guibg=DarkBlue"
exec "hi Underlined   term=underline cterm=bold ctermfg=".s:cyan    "ctermbg=".s:black "gui=NONE guifg=LightCyan   guibg=bg"
exec "hi Error        term=reverse   cterm=NONE ctermfg=".s:white   "ctermbg=".s:red   "gui=NONE guifg=LightGray   guibg=DarkRed"
exec "hi Todo         term=standout  cterm=bold ctermfg=".s:yellow  "ctermbg=".s:black "gui=NONE guifg=LightYellow guibg=bg"

" Secondary syntax categories
exec "hi Number       term=underline cterm=bold ctermfg=".s:red     "ctermbg=".s:black "gui=NONE guifg=Red     guibg=bg"
exec "hi Label        term=underline cterm=bold ctermfg=".s:green   "ctermbg=".s:black "gui=NONE guifg=Green   guibg=bg"
exec "hi Operator     term=underline cterm=bold ctermfg=".s:magenta "ctermbg=".s:black "gui=NONE guifg=Magenta guibg=bg"
exec "hi Tag          term=underline cterm=bold ctermfg=".s:white   "ctermbg=".s:black "gui=NONE guifg=White   guibg=bg"
hi link String          Constant
hi link Character       Constant
hi link Boolean         Constant
hi link Float           Number
hi link Function        Identifier
hi link Conditional     Statement
hi link Repeat          Statement
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
hi link Delimiter       Special
hi link SpecialComment  Special
hi link Debug           Special

" System colors
exec "hi SpecialKey   term=bold           cterm=bold ctermfg=".s:blue    "ctermbg=".s:black   "gui=NONE guifg=LightBlue    guibg=bg"
exec "hi NonText      term=bold           cterm=bold ctermfg=".s:black   "ctermbg=".s:black   "gui=NONE guifg=DarkGray     guibg=bg"
exec "hi Directory    term=bold           cterm=bold ctermfg=".s:blue    "ctermbg=".s:black   "gui=NONE guifg=LightBlue    guibg=bg"
exec "hi ErrorMsg     term=standout       cterm=bold ctermfg=".s:white   "ctermbg=".s:red     "gui=NONE guifg=White        guibg=DarkRed"
exec "hi IncSearch    term=reverse        cterm=NONE ctermfg=".s:black   "ctermbg=".s:cyan    "gui=NONE guifg=Black        guibg=DarkCyan"
exec "hi Search       term=reverse        cterm=NONE ctermfg=".s:black   "ctermbg=".s:yellow  "gui=NONE guifg=Black        guibg=DarkYellow"
exec "hi MatchParen   term=bold           cterm=bold ctermfg=".s:blue    "ctermbg=".8         "gui=NONE                    guibg=DarkMagenta"
exec "hi MoreMsg      term=bold           cterm=NONE ctermfg=".s:green   "ctermbg=".s:black   "gui=NONE guifg=DarkGreen    guibg=bg"
exec "hi ModeMsg      term=bold           cterm=bold ctermfg=".s:cyan    "ctermbg=".s:black   "gui=NONE guifg=LightCyan    guibg=bg"
exec "hi LineNr       term=underline      cterm=NONE ctermfg=".s:magenta "ctermbg=".s:black   "gui=NONE guifg=DarkMagenta  guibg=bg"
exec "hi Question     term=standout       cterm=NONE ctermfg=".s:green   "ctermbg=".s:black   "gui=NONE guifg=DarkGreen    guibg=bg"
exec "hi StatusLine   term=bold,reverse   cterm=NONE ctermfg=".s:white   "ctermbg=".s:blue    "gui=NONE guifg=LightGray    guibg=DarkBlue"
exec "hi StatusLineNC term=reverse        cterm=NONE ctermfg=".s:black   "ctermbg=".s:blue    "gui=NONE guifg=Black        guibg=DarkBlue"
exec "hi VertSplit    term=reverse        cterm=NONE ctermfg=".s:blue    "ctermbg=".s:blue    "gui=NONE guifg=DarkBlue     guibg=DarkBlue"
exec "hi Title        term=bold           cterm=bold ctermfg=".s:green   "ctermbg=".s:black   "gui=NONE guifg=LightMagenta guibg=bg"
exec "hi Visual       term=reverse        cterm=NONE ctermfg=".s:black   "ctermbg=".s:magenta "gui=NONE guifg=Black        guibg=DarkMagenta"
exec "hi VisualNOS    term=bold,underline cterm=bold ctermfg=".s:white   "ctermbg=".s:cyan    "gui=NONE guifg=White        guibg=DarkCyan"
exec "hi WarningMsg   term=standout       cterm=NONE ctermfg=".s:red     "ctermbg=".s:black   "gui=NONE guifg=DarkRed      guibg=bg"
exec "hi WildMenu     term=standout       cterm=bold ctermfg=".s:yellow  "ctermbg=".s:blue    "gui=NONE guifg=LightYellow  guibg=DarkBlue"
exec "hi Folded       term=standout       cterm=NONE ctermfg=".s:blue    "ctermbg=".s:black   "gui=NONE guifg=DarkBlue     guibg=bg"
exec "hi FoldColumn   term=standout       cterm=NONE ctermfg=".s:blue    "ctermbg=".s:black   "gui=NONE guifg=DarkBlue     guibg=bg"
exec "hi DiffAdd      term=bold           cterm=NONE ctermfg=".s:black   "ctermbg=".s:green   "gui=NONE guifg=Black        guibg=DarkGreen"
exec "hi DiffChange   term=bold           cterm=NONE ctermfg=".s:white   "ctermbg=".s:magenta "gui=NONE guifg=LightGray    guibg=DarkMagenta"
exec "hi DiffDelete   term=bold           cterm=NONE ctermfg=".s:red     "ctermbg=".s:red     "gui=NONE guifg=DarkRed      guibg=DarkRed"
exec "hi DiffText     term=reverse        cterm=bold ctermfg=".s:white   "ctermbg=".s:magenta "gui=NONE guifg=White        guibg=DarkMagenta"
exec "hi SignColumn   term=standout       cterm=bold ctermfg=".s:magenta "ctermbg=".s:black   "gui=NONE guifg=LightMagenta guibg=bg"
" hi Cursor       
" hi lCursor  	guifg=black 	guibg=red
" hi CursorIM     
