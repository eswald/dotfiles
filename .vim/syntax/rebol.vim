" Vim syntax file
" Language:   	Rebol
" Maintainer: 	Mike Williams <mrw@eandem.co.uk>
" Filenames:  	*.r
" Last Change:	27th June 2002
" URL:        	http://www.eandem.co.uk/mrw/vim
"

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Rebol is case insensitive
syn case ignore

" As per current users documentation
if version < 600
  set isk=@,48-57,!,&,',*-.,=,?,_,\|,~
else
  setlocal isk=@,48-57,!,&,',*-.,=,?,_,\|,~
endif

" Yer TODO highlighter
syn keyword	rebolTodo	display contained TODO Fixme Note

" Words
" These cover most cases, but by no means all.
" Must be defined above numbers and keyword sets.
" Note that keywords override the first set-word definition;
" this may be considered a Good Thing(tm).
syn match	rebolWord	"\<\K\k*\>"
syn match	rebolLitWord	"\<'\K\k*\>"
syn match	rebolGetWord	"\k\@<!:\K\k*\>"
syn match	rebolRefinement	":\@<!/\+\k\+\>"
syn match	rebolGetField	"/:\K\k*\>"
syn match	rebolSetWord	"\<\K\k*:\%(\k\|//\)\@!"
syn match	rebolSetWord	"\k\@<=:\%(\s\|[]{;}(\")[]\|$\)\@="
syn match	rebolSetPath	"\k\@<=/\K\k*:\%(\s\|[]{;}(\")[]\|$\)\@="

" URLs
" This is convoluted, but it's based on net-utils/url-parser.
syn match	rebolURL	contained "\%(\a\|\d\|[.+-]\)\+:\%(\s\|[][)(}{;\"]\|$\)\@!\%(//\)\?\%(\%(\w\|[#-'*-.=|]\)*\%(:.*\)\?@\)\?\%(\w\|[#-'*-.=|]\)*\%(\w\|[$-'*-/:=|?@~]\)*\%(#\%(\w\|[$-'*-.:=|?@~]\)*\)\?" contains=rebolScheme,rebolPort,rebolFileError
" This one matches more closely what the console thinks is an url.
syn match	rebolURLError	"\<\K\k*:[^]([:space:]){\";}[]\+" contains=rebolURL

" Numerical Types
syn match	rebolInteger	"\<[+-]\?\d\+['\d]*\>"
syn match	rebolDecimal	"\<[+-]\?\%(\d\+['\d]*\)\?[,.]['\d]*\%(e[+-]\?\d\+\)\?\>"
syn match	rebolDecimal	"\<[+-]\?\d\+['\d]*e[+-]\?\d\+\>"
syn match	rebolMoney	"\<\a\{0,3}\$['\d]*\%([,.]\d*\%('\d*\)*\)\?"
syn match	rebolIssue	"\k\@<!\%(#\k*\)\+\>"
syn match	rebolTuple	"\<\d\+\%(\.\d*\)\{2,9}\>"
syn match	rebolTuple	"\<\.\d\+\%(\.\d*\)\{1,8}\>"
syn match	rebolPair	"\<[-+]\?\d\+x[-+]\?\d\+\>"

" Time
syn match	rebolTime	"\<[+-]\?\d*:\%(\d\+:\)\?\d\+\%([.,]\d*\)\?\%([AP]M\)\?\>"
syn match	rebolTimeError	"\<[+-]\?\d*:\d\+\%([.,]\d*\)\?[AP]M\>"
syn match	rebolTimeError	"\<[+-]\?\d*:\%(\d\+:\)\?[.,]\d*\%([AP]M\)\?\>"

" Dates
" Technically, the year must be less than 16384 (2^14),
" and the time zone hour gets wrapped into the range -32..31
syn match	rebolDate	"\<\d\{1,2}\([/-]\)\%(\d\{1,2}\|\a\{3,}\)\1\%(1\?\d\{1,4}\)\%(\/[+-]\?\d*:\%(\d\+:\)\?\d\+\%([.,]\d*\)\?\%([AP]M\)\?\%([-+]\%(1[012]\|\d\|\d*:\)\d\d\)\?\)\?\>" contains=rebolMonth,rebolDateError,rebolTime,rebolTimeError
syn match	rebolDate	"\<\%(1\?\d\{4}\)\([/-]\)\%(\d\{1,2}\|\a\{3,}\)\1\d\{1,2}\%(\/[+-]\?\d*:\%(\d\+:\)\?\d\+\%([.,]\d*\)\?\%([AP]M\)\?\%([-+]\%(1[012]\|\d\|\d*:\)\d\d\)\?\)\?\>" contains=rebolMonth,rebolDateError,rebolTime,rebolTimeError
syn match	rebolDateError	"\a\+" contained
syn match	rebolMonth	"Jan\%[uary]\|Feb\%[ruary]\|Mar\%[ch]\|Apr\%[il]\|May\|June\?\|July\?\|Aug\%[ust]\|Sep\%[tember]\|Oct\%[ober]\|Nov\%[ember]\|Dec\%[ember]" contained

" Binary
syn match	rebolBinary	"2\?#{\_s*\%(\%([10]\_s*\)\{8}\)*}"
syn match	rebolBinary	"\%(16\)\?#{\_s*\%(\%(\x\_s*\)\{2}\)*}"
syn match	rebolBinary	"\%(64\)\?#{\_s*\%(\%(\%(\a\|\d\|+\)\_s*\)\{4}\)*\%(\%(\%(\a\|\d\|+\)\_s*\)\{2}\%(\a\|\d\|+\|=\)\_s*=\_.\{-}\)\?}" contains=rebolMultiLine

" File
syn match	rebolFile	"%\%(\k\|[/%]\)\+" contains=rebolFileWrap
syn match	rebolFileWrap	"%\@<=\%(\k\|[/%]\)\+" transparent contained contains=rebolFileError
syn region	rebolFile	oneline start=+%"+ end=+"+ contains=rebolStringCharacter

" Email
syn match	rebolEmail	"\<\k\+@\k*\>"

" Tags
syn region	rebolTag	start="<\k" end=">" contains=rebolTagString,rebolURL,rebolTagInteger
syn match	rebolTagString	"\%(=\s*\)\@<=\(["']\).\{-}\1" contains=rebolURL,rebolInteger
syn match	rebolTagInteger	"\%(=\s*\(['"]\?\)\)\@<=[+-]\?\d\+\1\@!"

" Strings
syn region	rebolString	oneline start=+[#\^]\@<!"+ skip=+^"+ end=+"+  contains=rebolStringCharacter
syn region	rebolMultiLine	matchgroup=rebolDelim fold start=+[#\^]\@<!{+ end=+\^\@<!}+ contains=rebolStringCharacter,rebolMultiLine

" Characters
" Order is important here, for proper highlighting
syn region	rebolCharacterError	oneline start=/#"/ skip=/^"/ end=/"/
syn match	rebolCharacter		/#"\^\?."/ contains=rebolStringCharacter
syn match	rebolCharacter		/#"\^(\%(back\|del\|line\|null\|page\|tab\|esc\|\x\{1,4}\))"/ contains=rebolStringCharacter
syn match	rebolStringCharacter	contained "\^."
syn match	rebolStringCharacter	contained "\^(\%(back\|del\|line\|null\|page\|tab\|esc\%(ape\)\?\|\x\{1,4}\))"
syn match	rebolFileError		contained "%.." contains=rebolFileCharacter
syn match	rebolFileCharacter	contained "%\x\{2}"

" Inline operators
syn match	rebolMathOperator	"\%(\k\|%\)\@<!\%(\*\{1,2}\|+\|-\)\k\@!"
syn match	rebolMathOperator	"\%(\k\|[:%/]\)\@<!/\{1,2}\%(\k\|/\)\@!"
syn match	rebolLogicOperator	"\k\@<![<>=]=\?\k\@!"
syn match	rebolLogicOperator	"\k\@<!<>\k\@!"
syn match	rebolLogicOperator	"\<=?\>"
syn keyword	rebolBinaryOperator	and or xor

" Built-in constants
syn keyword	rebolNone	none
syn keyword	rebolBoolean	true false
syn keyword	rebolPort	contained clipboard console dns file serial
syn keyword	rebolPort	sound tcp udp

" Datatypes
syn keyword	rebolType	action! binary! bitset! block! char! context!
syn keyword	rebolType	datatype! date! decimal! email! end! error!
syn keyword	rebolType	event! file! function! get-word! hash! image!
syn keyword	rebolType	integer! issue! library! list! lit-path!
syn keyword	rebolType	lit-word! logic! money! native! none! object!
syn keyword	rebolType	op! pair! paren! path! port! refinement!
syn keyword	rebolType	routine! set-path! set-word! string! struct!
syn keyword	rebolType	symbol! tag! time! tuple! unset! url! word!
syn keyword	rebolTypeClass	any-block! any-function! any-string! any-type!
syn keyword	rebolTypeClass	any-word! number! series!


if exists('rebol_core')
  if rebol_core > 20500
    " 2.5.5
    syn keyword	rebolOrdinalAction	sixth seventh eighth ninth tenth
    syn keyword	rebolSystemFunction	free-boot license
    syn keyword	rebolSystemNative	create-link get-env set-browser-path stats
    syn keyword	rebolStringNative	decloak encloak
    syn keyword	rebolNative		native
    " 2.5.3
    syn keyword	rebolSeriesFunction	alter
    syn keyword	rebolStringFunction	build-markup
    " 2.5.2
    syn keyword	rebolSystemFunction	component?
    syn keyword	rebolTypeFunction	construct
    syn keyword	rebolFileFunction	suffix?
    syn keyword	rebolMathFunction	sign?
    " 2.5.1
    syn keyword	rebolScheme		system
    syn keyword	rebolRepeatNative	remove-each
    syn keyword	rebolExceptionFunction	attempt
    
    " After 2.5.0, but in View 1.2.8 (Core 2.5.3?)
    syn keyword	rebolEmailFunction	build-attach-body
    syn keyword	rebolTypeFunction	to-datatype to-error to-library to-port
    syn keyword	rebolHelpFunction	dump-obj
    syn keyword	rebolSystemNative	run
    
    " After 2.5.0, but in 2.5.5
    syn keyword	rebolCharacter		lf
    syn keyword	rebolSystemBlock	datatypes
    syn keyword	rebolScriptSetting	path script
  endif
  
  if rebol_core < 20500
    " In 2.3.0, but not 2.5.0
    syn keyword	rebolNetworkFunction	decode-cgi-query
  else
    " In 2.5.0, but not 2.3.0
    syn keyword	rebolTypeFunction	context
    syn keyword	rebolNetworkFunction	decode-url dispatch
    syn keyword	rebolSeriesFunction	extract
    syn keyword	rebolPortNative 	get-modes set-modes
    syn keyword	rebolControlFunction	has
    syn keyword	rebolSysLogicFunction	link-app? link?
    syn keyword	rebolMathNative 	maximum-of minimum-of
    syn keyword	rebolTypeNative 	to-local-file to-rebol-file
  endif
    
  
  " Pre-defined constants
  syn keyword	rebolDecimal	pi
  syn keyword	rebolInteger	zero
  syn keyword	rebolBoolean	on off yes no
  syn keyword	rebolCharacter	backslash cr escape newline slash tab
  syn keyword	rebolString	crlf font-fixed font-sans-serif font-serif
  syn keyword	rebolScheme	contained daytime finger ftp http imap nntp pop smtp whois
  
  " Functions with special types
  syn keyword	rebolControlFunction	does func function switch
  syn keyword	rebolControlNative	break comment do exit halt q quit return
  syn keyword	rebolExceptionFunction	throw-on-error
  syn keyword	rebolExceptionNative	catch disarm throw try
  syn keyword	rebolRepeatFunction	for forall forever forskip
  syn keyword	rebolRepeatNative	foreach loop repeat until while
  syn keyword	rebolHelpFunction	? ?? about help probe source trace what
  
  syn keyword	rebolSystemFunction	protect-system save-user set-net
  syn keyword	rebolSystemFunction	set-user-name upgrade Usage write-user
  syn keyword	rebolSystemNative	browse free launch now protect recycle
  syn keyword	rebolSystemNative	secure unprotect
  
  " Conditional and comparison functions
  syn keyword	rebolLogicNative	all any not
  syn keyword	rebolLogicAction	equal? greater-or-equal? greater?
  syn keyword	rebolLogicAction	lesser-or-equal? lesser? not-equal?
  syn keyword	rebolLogicAction	same? strict-equal? strict-not-equal?
  syn keyword	rebolLogicFunction	found?
  syn keyword	rebolMathLogicAction	even? negative? odd? positive? zero?
  syn keyword	rebolConditionalNative	either else if
  
  syn keyword	rebolMathNative 	arccosine arcsine arctangent checksum
  syn keyword	rebolMathNative 	cosine debase enbase exp log-10 log-2
  syn keyword	rebolMathNative 	log-e sine square-root tangent
  syn keyword	rebolMathAction 	abs absolute divide max maximum min
  syn keyword	rebolMathAction 	minimum multiply negate power random
  syn keyword	rebolMathAction 	remainder subtract
  syn keyword	rebolBitwiseAction	and~ complement or~ xor~
  
  syn keyword	rebolPortNative 	close open query read read-io
  syn keyword	rebolPortNative 	save update wait write write-io
  syn keyword	rebolFileFunction	cvs-date cvs-version delete do-boot
  syn keyword	rebolFileFunction	echo info? rename size?
  syn keyword	rebolEmailFunction	import-email resend send
  syn keyword	rebolNetworkFunction	decode-cgi net-error
  syn keyword	rebolDirectoryFunction	change-dir clean-path dirize list-dir
  syn keyword	rebolDirectoryFunction	make-dir split-path what-dir
  syn keyword	rebolPortLogicFunction	connected? dir? exists? modified? script?
  
  syn keyword	rebolConsoleFunction	confirm ask input
  syn keyword	rebolConsoleNative	input? prin print
  
  syn keyword	rebolStringNative	compress decompress dehex detab entab
  syn keyword	rebolStringNative	load lowercase mold uppercase
  syn keyword	rebolStringAction	trim
  
  syn keyword	rebolParsingFunction	parse-email-addrs parse-header
  syn keyword	rebolParsingFunction	parse-header-date parse-xml
  syn keyword	rebolParsingNative	parse
  
  syn keyword	rebolSeriesAction	at back change clear copy cp find head
  syn keyword	rebolSeriesAction	index? insert last length? next pick
  syn keyword	rebolSeriesAction	poke remove select skip sort tail
  syn keyword	rebolSeriesLogicAction	empty? head? tail?
  syn keyword	rebolSeriesFunction	append array join offset?
  syn keyword	rebolSeriesFunction	reform rejoin remold repend replace
  syn keyword	rebolOrdinalAction	first second third fourth fifth
  syn keyword	rebolDatasetNative	difference exclude intersect union unique
  syn keyword	rebolBlockNative	compose form reduce reverse
  
  syn keyword	rebolContextNative	alias bind get in set unset use value?
  
  syn keyword	rebolTypeFunction	build-tag charset to-binary
  syn keyword	rebolTypeFunction	to-bitset to-block to-char to-date
  syn keyword	rebolTypeFunction	to-decimal to-email to-file to-get-word
  syn keyword	rebolTypeFunction	to-hash to-idate to-image to-integer
  syn keyword	rebolTypeFunction	to-issue to-list to-lit-path
  syn keyword	rebolTypeFunction	to-lit-word to-logic to-money to-none
  syn keyword	rebolTypeFunction	to-pair to-paren to-path to-refinement
  syn keyword	rebolTypeFunction	to-set-path to-set-word to-string
  syn keyword	rebolTypeFunction	to-tag to-time to-tuple to-url to-word
  syn keyword	rebolTypeNative 	to-hex type?
  syn keyword	rebolTypeAction 	make to
  
  " Functions to determine something's type.
  " Note that these are the data types, minus end!, symbol!, and context!.
  syn keyword	rebolTypeLogicAction	action? any-block? any-function?
  syn keyword	rebolTypeLogicAction	any-string? any-type? any-word? binary?
  syn keyword	rebolTypeLogicAction	bitset? block? char? datatype? date?
  syn keyword	rebolTypeLogicAction	decimal? email? error? event? file?
  syn keyword	rebolTypeLogicAction	function? get-word? hash? image?
  syn keyword	rebolTypeLogicAction	integer? issue? library? list? lit-path?
  syn keyword	rebolTypeLogicAction	lit-word? logic? money? native? none?
  syn keyword	rebolTypeLogicAction	number? object? op? pair? paren? path?
  syn keyword	rebolTypeLogicAction	port? refinement? routine? series?
  syn keyword	rebolTypeLogicAction	set-path? set-word? string? struct? tag?
  syn keyword	rebolTypeLogicAction	time? tuple? unset? url? word?
  
  
  " Objects used by the system
  syn keyword	rebolObject	error-object header-rules mail-list-rules REBOL
  syn keyword	rebolObject	net-utils Root-Protocol System xml-language
  syn keyword	rebolLogicFlag	net-watch
endif



" Key words for Rebol/View
if exists("rebol_view")
  syn keyword	rebolCacheFunction	exists-thru? launch-thru load-image
  syn keyword	rebolCacheFunction	load-thru path-thru read-net read-thru
  syn keyword	rebolCryptNative	crypt-strength? dh-compute-key
  syn keyword	rebolCryptNative	dh-generate-key dh-make-key
  syn keyword	rebolCryptNative	dsa-generate-key dsa-make-key
  syn keyword	rebolCryptNative	dsa-make-signature dsa-verify-signature
  syn keyword	rebolCryptNative	rsa-encrypt rsa-generate-key rsa-make-key
  
  " These are set to none in 1.2.46, but still defined
  syn keyword	rebolPrefsFunction	save-prefs view-prefs
  
  syn keyword	rebolViewNative 	caret-to-offset hide offset-to-caret
  syn keyword	rebolViewNative 	show size-text textinfo
  syn keyword	rebolViewFunction	center-face choose clear-fields confine
  syn keyword	rebolViewFunction	deflag-face do-face do-face-alt
  syn keyword	rebolViewFunction	find-key-face find-window flag-face
  syn keyword	rebolViewFunction	focus get-style layout make-face
  syn keyword	rebolViewFunction	screen-offset? scroll-para set-font
  syn keyword	rebolViewFunction	set-para set-style span? stylize
  syn keyword	rebolViewFunction	unfocus unview view win-offset?
  
  syn keyword	rebolEventFunction	do-events insert-event-func
  syn keyword	rebolEventFunction	open-events remove-event-func
  syn keyword	rebolViewHelpFunction	dump-face dump-pane vbug
  syn keyword	rebolViewPopupFunction	alert confirm flash hide-popup inform
  syn keyword	rebolViewPopupFunction	request request-color request-date
  syn keyword	rebolViewPopupFunction	request-download request-file
  syn keyword	rebolViewPopupFunction	request-list request-pass
  syn keyword	rebolViewPopupFunction	request-text show-popup
  syn keyword	rebolViewLogicFunction	flag-face? in-window? viewed?
  syn keyword	rebolViewApplication	desktop editor emailer
  
  " Words that should perhaps be in Core
  syn keyword	rebolPairLogicFunction	inside? outside? within?
  syn keyword	rebolSeriesFunction	alter
  syn keyword	rebolSystemNative	call
  syn keyword	rebolLogicFlag		alive?
  
  syn keyword	rebolCtxObject	ctx-edit ctx-emailer ctx-text ctx-viewtop
  syn keyword	rebolViewObject	blank-face face svv svvc svvf
  
  syn keyword	rebolViewFile	view-root
  syn keyword	rebolViewImage	logo.gif
  syn keyword	rebolViewObject	netscan req-file req-funcs sound user-prefs 
  syn keyword	rebolFontString	font-fixed font-sans-serif font-serif
  
  syn keyword	rebolColor	aqua bar-color base-color beige black blue
  syn keyword	rebolColor	brick brown button-color coal coffee crimson
  syn keyword	rebolColor	cyan forest gold gray green ivory khaki leaf
  syn keyword	rebolColor	linen magenta main-color maroon mint navy
  syn keyword	rebolColor	oldrab olive orange over-color papaya pewter
  syn keyword	rebolColor	pink purple rebolor red sienna silver sky snow
  syn keyword	rebolColor	tan teal violet water wheat white yellow
  
  if rebol_view > 10201
    " In 1.2.8, but not 1.2.1
    syn keyword	rebolTypeFunction	as-pair
    syn keyword	rebolColorFunction	brightness?
    syn keyword	rebolFileFunction	link-relative-path
    syn keyword	rebolPopupFunction	notify
    syn keyword	rebolPopupNative	local-request-file
    syn keyword	rebolViewFunction	scroll-drag
    
    " In 1.2.10, but not 1.2.8
    syn keyword	rebolRegistryNative	create-reg delete-reg exists-reg?
    syn keyword	rebolRegistryNative	get-reg list-reg set-reg
    syn keyword	rebolRegistryFunction	unset-reg-funcs 
    
    " I'm guessing on these
    syn keyword	rebolPrefsFile	lic
    syn keyword	rebolLogicFlag	view?
    
    " In 1.2.46 (Core 5.6.0), but not 1.2.10
    syn keyword	rebolMathFunction	mod modulo round
    syn keyword	rebolCacheFunction	do-thru load-stock load-stock-block
    syn keyword	rebolPrefsFunction	scan-eudora-prefs scan-netscape-prefs 
    syn keyword	rebolHilightFunction	hilight-all hilight-text unlight-text
    syn keyword	rebolRegistryFunction	get-net-info
    syn keyword	rebolPairLogicFunction	overlap?
    syn keyword	rebolControlNative	unless
    syn keyword	rebolSystemNative	do-browser
    syn keyword	rebolColorNative	hsv-to-rgb rgb-to-hsv
    
    syn keyword	rebolViewFunction	clear-face edge-size? get-face reset-face
    syn keyword	rebolViewFunction	resize-face scroll-face set-face
    syn keyword	rebolViewAction		copy*
    
    " In 1.2.46, but not 1.2.1
    syn keyword	rebolViewImage	btn-dn.png btn-up.png exlamation.gif
    syn keyword	rebolViewImage	help.gif info.gif stop.gif
    syn keyword	rebolLogicFlag	rebol-command? rebol-encap? rebol-link?
    syn keyword	rebolLogicFlag	rebol-pro? rebol-view?
    syn keyword	rebolCtxObject	ctx-access
    syn keyword	rebolColor	reblue
  else
    " Lost by 1.2.8
    syn keyword	rebolViewApplication	demo
    syn keyword	rebolRegistryNative	exists-key?
    syn keyword	rebolRegistryBlock	hkey-opts
    syn keyword	rebolSystemFunction	view-install
    
    " Lost by 1.2.10
    syn keyword	rebolPrefsFunction	boot-prefs load-prefs set-user view-prefs
    syn keyword	rebolRegistryFunction	get-net-info
    syn keyword	rebolSystemFunction	reboot uninstall view?
    syn keyword	rebolPrefsFile	license prefs-file
    
    " Lost by 1.2.46
    syn keyword	rebolTypeFunction	to-event
    syn keyword	rebolCtxObject		ctx-prefs ctx-program
    syn keyword	rebolViewBlock		do-start
  endif
endif


" Blocks and Comments
syn match	rebolComment	";.*$" contains=rebolTodo
if exists('rebol_folding') && version >= 600
  setlocal	foldmethod=syntax
  syn sync	fromstart
  syn region	rebolBlock	matchgroup=rebolDelim start=/\%(comment\s*\)\@<!\[/ end=/\]/ transparent fold contains=TOP
  syn region	rebolParen	matchgroup=rebolDelim start=/(/  end=/)/  transparent fold contains=TOP
  syn region	rebolComment	start=/comment\s*\[/ end=/]/ fold contains=rebolComment,rebolBlock,rebolString,rebolMultiLine
else
  syn region	rebolBlock	matchgroup=rebolDelim start=/\[/ end=/\]/ transparent contains=TOP
  syn region	rebolComment	start=/comment\s*\[/ end=/]/ contains=rebolComment,rebolBlock,rebolString,rebolMultiLine
  syn match	rebolDelim	"[]()[]"
endif


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_rebol_syntax_inits")
  if version < 508
    let did_rebol_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  
  HiLink rebolOperator		Operator
  HiLink rebolMathOperator	rebolOperator
  HiLink rebolLogicOperator	rebolOperator
  HiLink rebolBinaryOperator	rebolOperator
  
  HiLink rebolType		Type
  HiLink rebolTypeClass		rebolType
  
  HiLink rebolWord		Identifier
  HiLink rebolLitWord		rebolWord
  HiLink rebolGetWord		rebolWord
  HiLink rebolGetField		rebolWord
  HiLink rebolRefinement	rebolWord
  HiLink rebolSetWord		Label
  HiLink rebolSetPath		rebolSetWord
  
  HiLink rebolString		String
  HiLink rebolTagString		rebolString
  HiLink rebolMultiLine		rebolString
  HiLink rebolFile		String
  HiLink rebolIssue		String
  HiLink rebolCharacter		Character
  HiLink rebolStringCharacter	SpecialChar
  HiLink rebolFileCharacter	SpecialChar
  
  HiLink rebolURL		Tag
  HiLink rebolPort		rebolURL
  HiLink rebolScheme		rebolPort
  HiLink rebolEmail		rebolURL
  HiLink rebolTag		Tag
  
  HiLink rebolDecimal		Float
  HiLink rebolInteger		Number
  HiLink rebolTagInteger	rebolInteger
  HiLink rebolDate		Number
  HiLink rebolTime		rebolDate
  HiLink rebolMonth		rebolDate
  HiLink rebolMoney		Number
  HiLink rebolBinary		Number
  HiLink rebolTuple		Number
  HiLink rebolPair		Number
  HiLink rebolBoolean		Boolean
  HiLink rebolNone		rebolBoolean
  
  HiLink rebolComment		Comment
  HiLink rebolTodo		Todo
  
  HiLink rebolDelim		Delimiter
  
  HiLink rebolError		Error
  HiLink rebolCharacterError	rebolError
  HiLink rebolDateError		rebolError
  HiLink rebolFileError		rebolError
  HiLink rebolTimeError		rebolError
  HiLink rebolURLError		rebolError
  
  HiLink rebolFunction		Function
  HiLink rebolNative		rebolFunction
  HiLink rebolAction		rebolFunction
  
  HiLink rebolExceptionFunction	Exception
  HiLink rebolExceptionNative	Exception
  HiLink rebolControlFunction	Statement
  HiLink rebolControlNative	Statement
  HiLink rebolRepeatFunction	Repeat
  HiLink rebolRepeatNative	Repeat
  HiLink rebolHelpFunction	Debug
  
  HiLink rebolConditionalNative	Conditional
  HiLink rebolLogicFunction	Conditional
  HiLink rebolLogicNative	rebolLogicFunction
  HiLink rebolLogicAction	rebolLogicFunction
  HiLink rebolLogicFlag		rebolLogicFunction
  
  HiLink rebolMathNative	rebolNative
  HiLink rebolMathAction	rebolAction
  HiLink rebolMathFunction	rebolFunction
  HiLink rebolBitwiseAction	rebolMathAction
  HiLink rebolMathLogicAction	rebolLogicAction
  HiLink rebolPairLogicFunction	rebolLogicFunction
  
  HiLink rebolSystemNative	rebolNative
  HiLink rebolSystemFunction	rebolFunction
  HiLink rebolRegistryNative	rebolSystemNative
  HiLink rebolSysLogicFunction	rebolLogicFunction
  HiLink rebolRegistryFunction	rebolSystemFunction
  HiLink rebolPrefsFunction	rebolSystemFunction
  
  HiLink rebolPortNative	rebolNative
  HiLink rebolCryptNative	rebolNative
  HiLink rebolFileFunction	rebolFunction
  HiLink rebolPortLogicFunction	rebolLogicFunction
  HiLink rebolDirectoryFunction	rebolFileFunction
  HiLink rebolNetworkFunction	rebolFileFunction
  HiLink rebolEmailFunction	rebolNetworkFunction
  HiLink rebolCacheFunction	rebolNetworkFunction
  
  HiLink rebolConsoleNative	rebolNative
  HiLink rebolConsoleFunction	rebolFunction
  HiLink rebolStringAction	rebolAction
  HiLink rebolStringNative	rebolNative
  HiLink rebolStringFunction	rebolFunction
  HiLink rebolParsingNative	rebolNative
  HiLink rebolParsingFunction	rebolFunction
  
  HiLink rebolSeriesAction	rebolAction
  HiLink rebolOrdinalAction	rebolSeriesAction
  HiLink rebolSeriesLogicAction	rebolLogicAction
  HiLink rebolSeriesFunction	rebolFunction
  HiLink rebolDatasetNative	rebolNative
  HiLink rebolBlockNative	rebolNative
  
  HiLink rebolTypeAction	rebolAction
  HiLink rebolTypeNative	rebolNative
  HiLink rebolTypeFunction	rebolFunction
  HiLink rebolTypeLogicAction	rebolLogicAction
  HiLink rebolContextNative	rebolNative
  
  HiLink rebolKeyword		Keyword
  HiLink rebolSystemObject	rebolKeyword
  HiLink rebolSystemBlock	rebolKeyword
  HiLink rebolScriptSetting	rebolKeyword
  HiLink rebolColor		rebolTuple
  
  HiLink rebolViewNative	rebolNative
  HiLink rebolViewFunction	rebolFunction
  HiLink rebolColorNative	rebolMathNative
  HiLink rebolColorFunction	rebolMathFunction
  HiLink rebolEventFunction	rebolViewFunction
  HiLink rebolHilightFunction	rebolViewFunction
  HiLink rebolViewHelpFunction	rebolHelpFunction
  HiLink rebolViewLogicFunction	rebolLogicFunction
  HiLink rebolViewPopupFunction	rebolViewFunction
  HiLink rebolViewApplication	rebolViewFunction
  
  HiLink rebolViewObject	rebolSystemObject
  HiLink rebolViewBlock		rebolSystemBlock
  HiLink rebolRegistryBlock	rebolSystemBlock
  HiLink rebolCtxObject		rebolViewObject
  HiLink rebolFontString	rebolKeyword
  HiLink rebolViewImage		rebolKeyword
  HiLink rebolPrefsFile		rebolKeyword
  HiLink rebolViewFile		rebolKeyword
  
  delcommand HiLink
endif

let b:current_syntax = "rebol"
" vim: ts=8 noet sw=2 isk=@,48-57,!,-,.,?
