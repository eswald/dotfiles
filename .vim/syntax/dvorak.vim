" Vim syntax file
" Language:	Dvorak Deck Definition
" Maintainer:	Eric Wald <breadman@users.sourceforge.net>
" URL:		
" Last Change:	10-Oct-2005
" Loosely related to CSS

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'dvorak'
  setlocal iskeyword+=-
  " Useful for colors, but makes anchored links painful:
  "setlocal iskeyword+=#
endif

syn case ignore

syn keyword dvorakSpecialTag	contained deck thing action
syn keyword dvorakChessTag	contained piece castle royal pawn tile rotating neutral rule reference

syn keyword dvorakChessSpec	contained notation illustration alt-acknowledge reference
syn keyword dvorakTodoSpec	contained check
syn keyword dvorakCardSpec	contained acknowledgement count name text parent picture
syn keyword dvorakDeckSpec	contained authors date players rating status include
syn keyword dvorakColorSpec	contained card-background-colour title-colour text-background-colour text-colour bar-background-colour bar-text-colour picture-background-color

syn match   dvorakValueInteger	contained "[-+]\=\d\+"

syn keyword dvorakColor	contained aqua black blue fuchsia gray green lime maroon navy olive purple red silver teal yellow white
syn match   dvorakColor	contained "#\x\{3\}\>"
syn match   dvorakColor	contained "#\x\{6\}\>"

syn match   dvorakTag	"\K\k*\ze\_s*{" contains=dvorakSpecialTag,dvorakChessTag
syn match   dvorakSpecLabel	"\K\k*:\@=" contained contains=dvorak.*Spec
syn region  dvorakSpecification	matchgroup=dvorakSpecDelims start="\%(\K\k*\)\@<=:" end=";" transparent contained contains=dvorakColor,dvorakValueInteger,dvorakString,dvorakSpecialTag,dvorakChessTag

syn match   dvorakBraceError	"}"
syn region  dvorakDefinition	transparent fold matchgroup=dvorakBraces start="{" end="}" contains=dvorakSpecification,dvorakSpecLabel

syn match   dvorakHtmlError	contained "[<&>]"
syn match   dvorakActionLabel	contained '\%(^\|"\|&ldquo;\|&quot;\)\@<=\S\+\s\?\S\+:'
syn match   dvorakHtmlEntity	contained "&\k\{-};"
syn match   dvorakHtmlTag	contained "<.\{-}>"
syn region  dvorakString	start=+"+ end=+"+ contains=dvorakActionLabel,dvorakHtml.*

if main_syntax == "dvorak"
  syn sync minlines=10
  syn sync match dvorakSyncString grouphere dvorakDefinition '";'
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_dvorak_syn_inits")
  if version < 508
    let did_dvorak_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    "command -nargs=+ HiLink hi link <args>
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink dvorakSpecialTag       Keyword
  HiLink dvorakChessTag         Keyword
  HiLink dvorakPredefSpec       Keyword
  HiLink dvorakCardSpec         dvorakPredefSpec
  HiLink dvorakChessSpec	dvorakPredefSpec
  HiLink dvorakTodoSpec		Todo
  HiLink dvorakDeckSpec         dvorakPredefSpec
  HiLink dvorakColorSpec        dvorakPredefSpec
  HiLink dvorakValueInteger     Number
  HiLink dvorakColor            Constant
  HiLink dvorakTag              Identifier
  HiLink dvorakSpecLabel        Identifier
  HiLink dvorakSpecDelims       Operator
  HiLink dvorakBraceError       Error
  HiLink dvorakBraces           Delimiter
  HiLink dvorakActionLabel      Label
  HiLink dvorakHtmlError        Error
  HiLink dvorakHtmlEntity       SpecialChar
  HiLink dvorakHtmlTag          Tag
  HiLink dvorakString           String
  HiLink dvorakComment          Comment
  
  delcommand HiLink
endif

let b:current_syntax = "dvorak"

if main_syntax == 'dvorak'
  unlet main_syntax
endif

" vim: ts=8 noet
