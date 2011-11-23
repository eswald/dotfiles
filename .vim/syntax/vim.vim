" Vim syntax file
" Language:	Vim 6.2f script
" Maintainer:	Dr. Charles E. Campbell, Jr. <Charles.E.Campbell.1@nasa.gov>
" Last Change:	03-Nov-2006 27, 2003
" Version:	6.2f-02

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" vimTodo: contains common special-notices for comments
" Use the vimCommentGroup cluster to add your own.
syn keyword vimTodo contained	COMBAK	NOT	RELEASED	TODO	WIP
syn cluster vimCommentGroup	contains=vimTodo

" regular vim commands
syn keyword vimCommand contained	DeleteFirst I N[ext] Nread Nw P[rint] X ab[breviate] abc[lear] abo[veleft] al[l] arga[dd] argd[elete] argdo arge[dit] argg[lobal] argl[ocal] ar[gs] argu[ment] as[cii] bN[ext] bad[d] ba[ll] bd[elete] bel[owright] bf[irst] bl[ast] bm[odified] bn[ext] bo[tright] bp[revious] brea[k] breaka[dd] breakd[el] breakl[ist] br[ewind] bro[wse] bufdo b[uffer] buffers bun[load] bw[ipeout] cN[ext] ca[bbrev] cabc[lear] cal[l] cat[ch] cc ccl[ose] cd ce[nter] cf[ile] cfir[st] cg[etfile] c[hange] chd[ir] che[ckpath] checkt[ime] cla[st] cl[ist] clo[se] cmapc[lear] cnew[er] cn[ext] cnf[ile] cnorea[bbrev] col[der] colo[rscheme] comc[lear] comp[iler] conf[irm] con[tinue] cope[n] co[py] cp[revious] cq[uit] cr[ewind] cuna[bbrev] cu[nmap] cw[indow] debugg[reedy] delc[ommand] d[elete] delf[unction] diffg[et] diffpatch diffpu[t] diffsplit diffthis dig[raphs] di[splay] dj[ump] dl[ist] dr[op] ds[earch] dsp[lit] echoe[rr] echom[sg] echon e[dit] el[se] elsei[f] em[enu] emenu* endf[unction] en[dif] endt[ry] endw[hile] ene[w] ex exi[t] f[ile] files filetype fina[lly] fin[d] fini[sh] fir[st] fix[del] fo[ld] foldc[lose] folddoc[losed] foldd[oopen] foldo[pen] fu[nction] g[lobal] go[to] gr[ep] grepa[dd] ha[rdcopy] h[elp] helpf[ind] helpg[rep] helpt[ags] hid[e] his[tory] ia[bbrev] iabc[lear] if ij[ump] il[ist] imapc[lear] inorea[bbrev] is[earch] isp[lit] iuna[bbrev] iu[nmap] j[oin] ju[mps] k lan[guage] la[st] lc[d] lch[dir] le[ft] lefta[bove] l[ist] lm[ap] lmapc[lear] lno[remap] lo[adview] ls lu[nmap] mak[e] ma[rk] marks mat[ch] menut[ranslate] mk[exrc] mks[ession] mkvie[w] mkv[imrc] mod[e] m[ove] new n[ext] nmapc[lear] noh[lsearch] norea[bbrev] norm[al] nu[mber] nun[map] omapc[lear] on[ly] o[pen] opt[ions] ou[nmap] pc[lose] ped[it] pe[rl] perld[o] po[p] pop[up] pp[op] pre[serve] prev[ious] p[rint] prompt promptf[ind] promptr[epl] ps[earch] ptN[ext] pta[g] ptf[irst] ptj[ump] ptl[ast] ptn[ext] ptp[revious] ptr[ewind] pts[elect] pu[t] pw[d] pyf[ile] py[thon] qa[ll] q[uit] quita[ll] r[ead] rec[over] redi[r] red[o] redr[aw] reg[isters] res[ize] ret[ab] retu[rn] rew[ind] ri[ght] rightb[elow] rub[y] rubyd[o] rubyf[ile] ru[ntime] rv[iminfo] sN[ext] sal[l] sa[rgument] sav[eas] sbN[ext] sba[ll] sbf[irst] sbl[ast] sbm[odified] sbn[ext] sbp[revious] sbr[ewind] sb[uffer] scripte[ncoding] scrip[tnames] se[t] setf[iletype] setg[lobal] setl[ocal] sf[ind] sfir[st] sh[ell] sign sil[ent] si[malt] sla[st] sl[eep] sm[agic] sn[ext] sni[ff] sno[magic] so[urce] sp[lit] spr[evious] sr[ewind] sta[g] star[tinsert] stj[ump] st[op] stopi[nsert] sts[elect] sun[hide] sus[pend] sv[iew] syncbind t tN[ext] ta[g] tags tc[l] tcld[o] tclf[ile] te[aroff] tf[irst] the th[row] tj[ump] tl[ast] tm[enu] tn[ext] to[pleft] tp[revious] tr[ewind] try ts[elect] tu[nmenu] una[bbreviate] u[ndo] unh[ide] unm[ap] up[date] verb[ose] ve[rsion] vert[ical] v[global] vie[w] vi[sual] vmapc[lear] vne[w] vs[plit] vu[nmap] wN[ext] wa[ll] wh[ile] winc[md] windo winp[os] winpos* win[size] wn[ext] wp[revous] wq wqa[ll] w[rite] ws[verb] wv[iminfo] xa[ll] x[it] y[ank]
syn match   vimCommand contained	"\<z[-+^.=]"

" vimOptions are caught only when contained in a vimSet
syn keyword vimOption contained	: acd ai akm al aleph allowrevins altkeymap ambiwidth ambw ar arab arabic arabicshape ari arshape autochdir autoindent autoread autowrite autowriteall aw awa background backspace backup backupcopy backupdir backupext backupskip balloondelay ballooneval bdir bdlay beval bex bg bh bin binary biosk bioskey bk bkc bl bomb breakat brk browsedir bs bsdir bsk bt bufhidden buflisted buftype casemap cb ccv cd cdpath cedit cf ch charconvert ci cin cindent cink cinkeys cino cinoptions cinw cinwords clipboard cmdheight cmdwinheight cmp cms co columns com comments commentstring compatible complete conc conceallevel confirm consk conskey copyindent cp cpo cpoptions cpt crb cscopepathcomp cscopeprg cscopequickfix cscopetag cscopetagorder cscopeverbose cspc csprg csqf cst csto csverb cursorbind cwh debug deco def define delcombine dex dg dict dictionary diff diffexpr diffopt digraph dip dir directory display dy ea ead eadirection eb ed edcompatible ef efm ei ek enc encoding endofline eol ep equalalways equalprg errorbells errorfile errorformat esckeys et eventignore ex expandtab exrc fcl fcs fdc fde fdi fdl fdls fdm fdn fdo fdt fen fenc fencs ff ffs fileencoding fileencodings fileformat fileformats filetype fillchars fk fkmap fml fmr fo foldclose foldcolumn foldenable foldexpr foldignore foldlevel foldlevelstart foldmarker foldmethod foldminlines foldnestmax foldopen foldtext formatoptions formatprg fp ft gcr gd gdefault gfm gfn gfs gfw ghr go gp grepformat grepprg guicursor guifont guifontset guifontwide guiheadroom guioptions guipty helpfile helpheight hf hh hi hid hidden highlight history hk hkmap hkmapp hkp hl hls hlsearch ic icon iconstring ignorecase im imactivatekey imak imc imcmdline imd imdisable imi iminsert ims imsearch inc include includeexpr incsearch inde indentexpr indentkeys indk inex inf infercase insertmode is isf isfname isi isident isk iskeyword isp isprint joinspaces js key keymap keymodel keywordprg km kmp kp langmap langmenu laststatus lazyredraw lbr lcs linebreak lines linespace lisp lispwords list listchars lm lmap loadplugins lpl ls lsp lw lz ma magic makeef makeprg mat matchpairs matchtime maxfuncdepth maxmapdepth maxmem maxmemtot mef menuitems mfd mh mis ml mls mm mmd mmt mod modeline modelines modifiable modified more mouse mousef mousefocus mousehide mousem mousemodel mouses mouseshape mouset mousetime mp mps nf nrformats nu number oft osfiletype pa para paragraphs paste pastetoggle patchexpr patchmode path pdev penc pex pexpr pfn pheader pi pm popt preserveindent previewheight previewwindow printdevice printencoding printexpr printfont printheader printoptions pt pvh pvw readonly remap report restorescreen revins ri rightleft rightleftcmd rl rlc ro rs rtp ru ruf ruler rulerformat runtimepath sb sbo sbr sc scb scr scroll scrollbind scrolljump scrolloff scrollopt scs sect sections secure sel selection selectmode sessionoptions sft sh shcf shell shellcmdflag shellpipe shellquote shellredir shellslash shelltype shellxquote shiftround shiftwidth shm shortmess shortname showbreak showcmd showfulltag showmatch showmode shq si sidescroll sidescrolloff siso sj slm sm smartcase smartindent smarttab smd sn so softtabstop sol sp splitbelow splitright spr sr srr ss ssl ssop st sta startofline statusline stl sts su sua suffixes suffixesadd sw swapfile swapsync swb swf switchbuf sws sxq syn syntax ta tabstop tag tagbsearch taglength tagrelative tags tagstack tb tbi tbidi tbis tbs tenc term termbidi termencoding terse textauto textmode textwidth tf tgst thesaurus tildeop timeout timeoutlen title titlelen titleold titlestring tl tm to toolbar toolbariconsize top tr ts tsl tsr ttimeout ttimeoutlen ttm tty ttybuiltin ttyfast ttym ttymouse ttyscroll ttytype tw tx uc ul undolevels updatecount updatetime ut vb vbs vdir ve verbose vi viewdir viewoptions viminfo virtualedit visualbell vop wa wak warn wb wc wcm wd weirdinvert wfh wh whichwrap wig wildchar wildcharm wildignore wildmenu wildmode wim winaltkeys winfixheight winheight winminheight winminwidth winwidth wiv wiw wm wmh wmnu wmw wrap wrapmargin wrapscan write writeany writebackup writedelay ws ww

" These are the turn-off setting variants
syn keyword vimOption contained	loadplugins noacd noai noakm noallowrevins noaltkeymap noar noarab noarabic noarabicshape noari noarshape noatuochdir noautoindent noautoread noautowrite noautowriteall noaw noawa nobackup noballooneval nobeval nobin nobinary nobiosk nobioskey nobk nobomb nocf noci nocin nocindent nocompatible noconfirm noconsk noconskey nocopyindent nocp nocrb nocscopetag nocscopeverbose nocst nocsverb nocursorbind nodg nodiff nodigraph nodisable noea noeb noed noedcompatible noek noendofline noeol noequalalways noerrorbells noesckeys noet noex noexpandtab noexrc nofen nofk nofkmap nofoldenable nogd nogdefault noguipty nohid nohidden nohk nohkmap nohkmapp nohkp nohls nohlsearch noic noicon noignorecase noim noimc noimcmdline noimd noincsearch noinf noinfercase noinsertmode nois nojoinspaces nojs nolazyredraw nolbr nolinebreak nolisp nolist noloadplugins nolpl nolz noma nomagic nomh noml nomod nomodeline nomodifiable nomodified nomore nomousef nomousefocus nomousehide nonu nonumber nopaste nopi nopreserveindent nopreviewwindow nopvw noreadonly noremap norestorescreen norevins nori norightleft norightleftcmd norl norlc noro nors noru noruler nosb nosc noscb noscrollbind noscs nosecure nosft noshellslash noshiftround noshortname noshowcmd noshowfulltag noshowmatch noshowmode nosi nosm nosmartcase nosmartindent nosmarttab nosmd nosn nosol nosplitbelow nosplitright nospr nosr nossl nosta nostartofline noswapfile noswf nota notagbsearch notagrelative notagstack notbi notbidi notbs notermbidi noterse notextauto notextmode notf notgst notildeop notimeout notitle noto notop notr nottimeout nottybuiltin nottyfast notx novb novisualbell nowa nowarn nowb noweirdinvert nowildmenu nowiv nowmnu nowrap nowrapscan nowrite nowriteany nowritebackup nows

" termcap codes (which can also be set)
syn keyword vimOption contained	t_AB t_AF t_AL t_CS t_CV t_Co t_DL t_F1 t_F2 t_F3 t_F4 t_F5 t_F6 t_F7 t_F8 t_F9 t_IE t_IS t_K1 t_K3 t_K4 t_K5 t_K6 t_K7 t_K8 t_K9 t_KA t_KB t_KC t_KD t_KE t_KF t_KG t_KH t_KI t_KJ t_KK t_KL t_RI t_RV t_Sb t_Sf t_WP t_WS t_ZH t_ZR t_al t_bc t_cd t_ce t_cl t_cm t_cs t_da t_db t_dl t_fs t_k1 t_k2 t_k3 t_k4 t_k5 t_k6 t_k7 t_k8 t_k9 t_kB t_kD t_kI t_kN t_kP t_kb t_kd t_ke t_kh t_kl t_kr t_ks t_ku t_le t_mb t_md t_me t_mr t_ms t_nd t_op t_se t_so t_sr t_te t_ti t_ts t_ue t_us t_ut t_vb t_ve t_vi t_vs t_xs
syn match   vimOption contained	"t_#2"
syn match   vimOption contained	"t_#4"
syn match   vimOption contained	"t_%1"
syn match   vimOption contained	"t_%i"
syn match   vimOption contained	"t_&8"
syn match   vimOption contained	"t_*7"
syn match   vimOption contained	"t_@7"
syn match   vimOption contained	"t_k;"

" these settings don't actually cause errors in vim, but were supported by vi and don't do anything in vim
syn keyword vimErrSetting contained	hardtabs ht w1200 w300 w9600 wi window

" AutoBuf Events
syn case ignore
syn keyword vimAutoEvent contained	BufAdd BufCreate BufDelete BufEnter BufFilePost BufFilePre BufHidden BufLeave BufNew BufNewFile BufRead BufReadCmd BufReadPost BufReadPre BufUnload BufWinEnter BufWinLeave BufWipeout BufWrite BufWriteCmd BufWritePost BufWritePre Cmd-event CmdwinEnter CmdwinLeave CursorHold E135 E143 E200 E201 E203 E204 EncodingChanged FileAppendCmd FileAppendPost FileAppendPre FileChangedRO FileChangedShell FileEncoding FileReadCmd FileReadPost FileReadPre FileType FileWriteCmd FileWritePost FileWritePre FilterReadPost FilterReadPre FilterWritePost FilterWritePre FocusGained FocusLost FuncUndefined GUIEnter RemoteReply StdinReadPost StdinReadPre Syntax TermChanged TermResponse User UserGettingBored VimEnter VimLeave VimLeavePre WinEnter WinLeave

" Highlight commonly used Groupnames
syn keyword vimGroup contained	Comment Constant String Character Number Boolean Float Identifier Function Statement Conditional Repeat Label Operator Keyword Exception PreProc Include Define Macro PreCondit Type StorageClass Structure Typedef Special SpecialChar Tag Delimiter SpecialComment Debug Underlined Ignore Error Todo

" Default highlighting groups
syn keyword vimHLGroup contained	Conceal Cursor CursorIM DiffAdd DiffChange DiffDelete DiffText Directory ErrorMsg FoldColumn Folded IncSearch LineNr Menu ModeMsg MoreMsg NonText Normal Question Scrollbar Search SpecialKey StatusLine StatusLineNC Title Tooltip VertSplit Visual VisualNOS WarningMsg WildMenu
syn case match

" Function Names
syn keyword vimFuncName contained	MyCounter append argc argidx argv browse bufexists buflisted bufloaded bufname bufnr bufwinnr byte2line char2nr cindent col confirm cscope_connection cursor delete did_filetype escape eventhandler executable exists expand filereadable filewritable fnamemodify foldclosed foldclosedend foldlevel foldtext foreground function getbufvar getchar getcharmod getcwd getfsize getftime getline getreg getregtype getwinposx getwinposy getwinvar glob globpath has hasmapto histadd histdel histget histnr hlID hlexists hostname iconv indent input inputdialog inputrestore inputsave inputsecret isdirectory libcall libcallnr line line2byte lispindent localtime maparg mapcheck match matchend matchstr mode nextnonblank nr2char prevnonblank remote_expr remote_foreground remote_peek remote_read remote_send rename resolve search searchpair server2client serverlist setbufvar setline setreg setwinvar strftime stridx strlen strpart strridx strtrans submatch substitute synID synIDattr synIDtrans system tempname tolower toupper type virtcol visualmode winbufnr wincol winheight winline winnr winwidth

"--- syntax above generated by mkvimvim ---

" Special Vim Highlighting

" All vimCommands are contained by vimIsCommands.
syn match vimCmdSep	"[:|]\+"	skipwhite nextgroup=vimAddress,vimAutoCmd,vimCommand,vimExtCmd,vimFilter,vimLet,vimMap,vimMark,vimSet,vimSyntax,vimUserCmd
syn match vimIsCommand	"\<\a\+\>"	contains=vimCommand
syn match vimVar	"\<[bwglsav]:\K\k*\>"
syn match vimVar contained	"\<\K\k*\>"
syn match vimFunc	"\I\i*\s*("	contains=vimFuncName,vimCommand

" Insertions And Appends: insert append
" =======================
syn region vimInsert	matchgroup=vimCommand start="^[: \t]*a\%[ppend]$"	matchgroup=vimCommand end="^\.$""
syn region vimInsert	matchgroup=vimCommand start="^[: \t]*i\%[nsert]$"	matchgroup=vimCommand end="^\.$""

" Behave!
" =======
syn match   vimBehave	"\<be\%[have]\>" skipwhite nextgroup=vimBehaveModel,vimBehaveError
syn keyword vimBehaveModel contained	mswin	xterm
syn match   vimBehaveError contained	"[^ ]\+"

" Filetypes
" =========
syn match   vimFiletype	"\<filet\%[ype]\(\s\+\I\i*\)*\(|\|$\)"	skipwhite contains=vimFTCmd,vimFTOption,vimFTError
syn match   vimFTError  contained	"\I\i*"
syn keyword vimFTCmd    contained	filet[ype]
syn keyword vimFTOption contained	on	off	indent	plugin

" Augroup : vimAugroupError removed because long augroups caused sync'ing problems.
" ======= : Trade-off: Increasing synclines with slower editing vs augroup END error checking.
syn cluster vimAugroupList	contains=vimIsCommand,vimFunction,vimFunctionError,vimLineComment,vimSpecFile,vimOper,vimNumber,vimComment,vimString,vimSubst,vimMark,vimRegister,vimAddress,vimFilter,vimCmplxRepeat,vimComment,vimLet,vimSet,vimAutoCmd,vimRegion,vimSynLine,vimNotation,vimCtrlChar,vimFuncVar,vimContinue
syn region  vimAugroup	start="\<aug\%[roup]\>\s\+\K\k*" end="\<aug\%[roup]\>\s\+[eE][nN][dD]\>"	contains=vimAugroupKey,vimAutoCmd,@vimAugroupList keepend
syn match   vimAugroupError	"\<aug\%[roup]\>\s\+[eE][nN][dD]\>"
syn keyword vimAugroupKey contained	aug[roup]

" Functions : Tag is provided for those who wish to highlight tagged functions
" =========
syn cluster vimFuncList	contains=vimFuncKey,Tag,vimFuncSID
syn cluster vimFuncBodyList	contains=vimIsCommand,vimFunction,vimFunctionError,vimFuncBody,vimLineComment,vimSpecFile,vimOper,vimNumber,vimComment,vimString,vimSubst,vimMark,vimRegister,vimAddress,vimFilter,vimCmplxRepeat,vimComment,vimLet,vimSet,vimAutoCmd,vimRegion,vimSynLine,vimNotation,vimCtrlChar,vimFuncVar,vimContinue
syn match   vimFunctionError	"\<fu\%[nction]!\=\s\+\U.\{-}("me=e-1	contains=vimFuncKey,vimFuncBlank nextgroup=vimFuncBody
syn match   vimFunction	"\<fu\%[nction]!\=\s\+\(<[sS][iI][dD]>\|s:\|\u\)\w*("me=e-1	contains=@vimFuncList nextgroup=vimFuncBody
syn region  vimFuncBody  contained	start=")"	end="\<endf"	contains=@vimFuncBodyList
syn match   vimFuncVar   contained	"a:\(\I\i*\|\d\+\)"
syn match   vimFuncSID   contained	"<[sS][iI][dD]>\|\<s:"
syn keyword vimFuncKey   contained	fu[nction]
syn match   vimFuncBlank contained	"\s\+"

syn keyword vimPattern  contained	start	skip	end

" Operators
syn match vimOper	"\(==\|!=\|>=\|<=\|=\~\|!\~\|>\|<\|=\)[?#]\{0,2}"	skipwhite nextgroup=vimString,vimSpecFile
syn match vimOper	"||\|&&\|+\|-\|\."	skipwhite nextgroup=vimString,vimSpecFile

" Special Filenames, Modifiers, Extension Removal
syn match vimSpecFile	"<c\(word\|WORD\)>"	nextgroup=vimSpecFileMod,vimSubst
syn match vimSpecFile	"<\([acs]file\|amatch\|abuf\)>"	nextgroup=vimSpecFileMod,vimSubst
syn match vimSpecFile	"\s%[ \t:]"ms=s+1,me=e-1	nextgroup=vimSpecFileMod,vimSubst
syn match vimSpecFile	"\s%$"ms=s+1	nextgroup=vimSpecFileMod,vimSubst
syn match vimSpecFile	"\s%<"ms=s+1,me=e-1	nextgroup=vimSpecFileMod,vimSubst
syn match vimSpecFile	"#\d\+\|[#%]<\>"	nextgroup=vimSpecFileMod,vimSubst
syn match vimSpecFileMod	"\(:[phtre]\)\+"	contained

" User-Specified Commands
syn cluster vimUserCmdList	contains=vimAddress,vimSyntax,vimHighlight,vimAutoCmd,vimCmplxRepeat,vimComment,vimCtrlChar,vimEscapeBrace,vimFilter,vimFunc,vimFunction,vimIsCommand,vimMark,vimNotation,vimNumber,vimOper,vimRegion,vimRegister,vimLet,vimSet,vimSetEqual,vimSetString,vimSpecFile,vimString,vimSubst,vimSubstRep,vimSubstRange,vimSynLine
syn keyword vimUserCommand	contained	com[mand]
syn match   vimUserCmd	"\<com\%[mand]!\=\>.*$"	contains=vimUserAttrb,vimUserCommand,@vimUserCmdList
syn match   vimUserAttrb	contained	"-n\%[args]=[01*?+]"	contains=vimUserAttrbKey,vimOper
syn match   vimUserAttrb	contained	"-com\%[plete]="	contains=vimUserAttrbKey,vimOper nextgroup=vimUserAttrbCmplt,vimUserCmdError
syn match   vimUserAttrb	contained	"-ra\%[nge]\(=%\|=\d\+\)\="	contains=vimNumber,vimOper,vimUserAttrbKey
syn match   vimUserAttrb	contained	"-cou\%[nt]=\d\+"	contains=vimNumber,vimOper,vimUserAttrbKey
syn match   vimUserAttrb	contained	"-bang\=\>"	contains=vimOper,vimUserAttrbKey
syn match   vimUserAttrb	contained	"-bar\>"	contains=vimOper,vimUserAttrbKey
syn match   vimUserAttrb	contained	"-re\%[gister]\>"	contains=vimOper,vimUserAttrbKey
syn match   vimUserCmdError	contained	"\S\+\>"
syn keyword vimUserAttrbKey	contained	bar	ban[g]	cou[nt]	ra[nge]
syn keyword vimUserAttrbKey	contained	com[plete]	n[args]	re[gister]
syn keyword vimUserAttrbCmplt	contained	augroup	environment	function	mapping	tag
syn keyword vimUserAttrbCmplt	contained	buffer	event	help	menu	tag_listfiles
syn keyword vimUserAttrbCmplt	contained	command	expression	highlight	option	var
syn keyword vimUserAttrbCmplt	contained	dir	file

" Numbers
" =======
syn match vimNumber	"\<\d\+\([lL]\|\.\d\+\)\="
syn match vimNumber	"-\d\+\([lL]\|\.\d\+\)\="
syn match vimNumber	"\<0[xX]\x\+"
syn match vimNumber	"#\x\{6}"

" Errors
" ======
syn match  vimElseIfErr	"\<else\s\+if\>"

" Lower Priority Comments: after some vim commands...
" =======================
syn match  vimComment	excludenl +\s"[^\-:.%#=*].*$+lc=1	contains=@vimCommentGroup,vimCommentString
syn match  vimComment	+\<endif\s\+".*$+lc=5	contains=@vimCommentGroup,vimCommentString
syn match  vimComment	+\<else\s\+".*$+lc=4	contains=@vimCommentGroup,vimCommentString
syn region vimCommentString	contained oneline start='\S\s\+"'ms=s+1	end='"'

" Environment Variables
" =====================
syn match vimEnvvar	"\$\I\i*"
syn match vimEnvvar	"\${\I\i*}"

" Try to catch strings, if nothing else matches (therefore it must precede the others!)
"  vimEscapeBrace handles ["]  []"] (ie. "s don't terminate string inside [])
syn region vimEscapeBrace	oneline contained transparent	start="[^\\]\(\\\\\)*\[\^\=\]\=" skip="\\\\\|\\\]" end="\]"me=e-1
syn match  vimPatSepErr	contained	"\\)"
syn match  vimPatSep	contained	"\\|"
syn region vimPatSepZone	contained transparent matchgroup=vimPatSep start="\\%\=(" skip="\\\\" end="\\)"	contains=@vimStringGroup
syn region vimPatRegion	contained transparent matchgroup=vimPatSep start="\\[z%]\=(" end="\\)"	contains=@vimSubstList oneline
syn match  vimNotPatSep	contained	"\\\\"
syn cluster vimStringGroup	contains=vimEscapeBrace,vimPatSep,vimNotPatSep,vimPatSepErr,vimPatSepZone
syn region vimString	oneline keepend	start=+[^:a-zA-Z>!\\]"+lc=1 skip=+\\\\\|\\"+ end=+"+	contains=@vimStringGroup
syn region vimString	oneline keepend	start=+[^:a-zA-Z>!\\]'+lc=1 end=+'+	contains=@vimStringGroup
syn region vimString	oneline	start=+=!+lc=1	skip=+\\\\\|\\!+ end=+!+	contains=@vimStringGroup
syn region vimString	oneline	start="=+"lc=1	skip="\\\\\|\\+" end="+"	contains=@vimStringGroup
syn region vimString	oneline	start="[^\\]+\s*[^a-zA-Z0-9. \t]"lc=1 skip="\\\\\|\\+" end="+"	contains=@vimStringGroup
syn region vimString	oneline	start="\s/\s*\A"lc=1 skip="\\\\\|\\+" end="/"	contains=@vimStringGroup
syn match  vimString	contained	+"[^"]*\\$+	skipnl nextgroup=vimStringCont
syn match  vimStringCont	contained	+\(\\\\\|.\)\{-}[^\\]"+

" Substitutions
" =============
syn cluster vimSubstList	contains=vimPatSep,vimPatRegion,vimPatSepErr,vimSubstTwoBS,vimSubstRange,vimNotation
syn cluster vimSubstRepList	contains=vimSubstSubstr,vimSubstTwoBS,vimNotation
syn cluster vimSubstList	add=vimCollection
syn match   vimSubst	"\(:\+\s*\|^\s*\||\s*\)\<s\%[ubstitute][:[:alpha:]]\@!" nextgroup=vimSubstPat
syn match   vimSubst1       contained	"s\%[ubstitute]\>"	nextgroup=vimSubstPat
syn region  vimSubstPat     contained	matchgroup=vimSubstDelim start="\z([^a-zA-Z( \t[\]&]\)"rs=s+1 skip="\\\\\|\\\z1" end="\z1"re=e-1,me=e-1	 contains=@vimSubstList	nextgroup=vimSubstRep4	oneline
syn region  vimSubstRep4    contained	matchgroup=vimSubstDelim start="\z(.\)" skip="\\\\\|\\\z1" end="\z1" matchgroup=vimNotation end="<[cC][rR]>" contains=@vimSubstRepList	nextgroup=vimSubstFlagErr
syn region  vimCollection   contained transparent	start="\\\@<!\[" skip="\\\[" end="\]"	contains=vimCollClass
syn match   vimCollClassErr contained	"\[:.\{-\}:\]"
syn match   vimCollClass    contained transparent	"\[:\(alnum\|alpha\|blank\|cntrl\|digit\|graph\|lower\|print\|punct\|space\|upper\|xdigit\|return\|tab\|escape\|backspace\):\]"
syn match   vimSubstSubstr  contained	"\\z\=\d"
syn match   vimSubstTwoBS   contained	"\\\\"
syn match   vimSubstFlagErr contained	"[^< \t\r]\+" contains=vimSubstFlags
syn match   vimSubstFlags   contained	"[&cegiIpr]\+"

" 'String'
syn match  vimString	"[^(,]'[^']\{-}'"lc=1	contains=@vimStringGroup

" Marks, Registers, Addresses, Filters
syn match  vimMark	"[!,:]'[a-zA-Z0-9]"lc=1
syn match  vimMark	"'[a-zA-Z0-9][,!]"me=e-1
syn match  vimMark	"'[<>][,!]"me=e-1
syn match  vimMark	"\<norm\s'[a-zA-Z0-9]"lc=5
syn match  vimMark	"\<normal\s'[a-zA-Z0-9]"lc=7
syn match  vimPlainMark contained	"'[a-zA-Z0-9]"

syn match  vimRegister	'[^(,;.]"[a-zA-Z0-9.%#:_\-/][^a-zA-Z_"]'lc=1,me=e-1
syn match  vimRegister	'\<norm\s\+"[a-zA-Z0-9]'lc=5
syn match  vimRegister	'\<normal\s\+"[a-zA-Z0-9]'lc=7
syn match  vimPlainRegister contained	'"[a-zA-Z0-9\-:.%#*+=]'

syn match  vimAddress	",[.$]"lc=1	skipwhite nextgroup=vimSubst1
syn match  vimAddress	"%\a"me=e-1	skipwhite nextgroup=vimString,vimSubst1

syn match  vimFilter contained	"^!.\{-}\(|\|$\)"	contains=vimSpecFile
syn match  vimFilter contained	"\A!.\{-}\(|\|$\)"ms=s+1	contains=vimSpecFile

" Complex repeats (:h complex-repeat)
syn match  vimCmplxRepeat	'[^a-zA-Z_/\\]q[0-9a-zA-Z"]'lc=1
syn match  vimCmplxRepeat	'@[0-9a-z".=@:]'

" Set command and associated set-options (vimOptions) with comment
syn region vimSet	matchgroup=vimCommand start="\<setlocal\|set\>" end="|"me=e-1 end="$" matchgroup=vimNotation end="<[cC][rR]>" keepend contains=vimSetEqual,vimOption,vimErrSetting,vimComment,vimSetString
syn region vimSetEqual  contained	start="="	skip="\\\\\|\\\s" end="[| \t]\|$"me=e-1 contains=vimCtrlChar,vimSetSep,vimNotation
syn region vimSetString contained	start=+="+hs=s+1	skip=+\\\\\|\\"+  end=+"+	contains=vimCtrlChar
syn match  vimSetSep    contained	"[,:]"

" Let
" ===
syn keyword vimLet	let	unl[et]	skipwhite nextgroup=vimVar

" Autocmd
" =======
syn match   vimAutoEventList	contained	"\(!\s\+\)\=\(\a\+,\)*\a\+"	contains=vimAutoEvent nextgroup=vimAutoCmdSpace
syn match   vimAutoCmdSpace	contained	"\s\+"	nextgroup=vimAutoCmdSfxList
syn match   vimAutoCmdSfxList	contained	"\S*"
syn keyword vimAutoCmd	au[tocmd] do[autocmd] doautoa[ll]	skipwhite nextgroup=vimAutoEventList

" Echo and Execute -- prefer strings!
" ================
syn region  vimEcho	oneline excludenl matchgroup=vimCommand start="\<ec\%[ho]\>" skip="\(\\\\\)*\\|" end="$\||" contains=vimFuncName,vimString,vimOper,varVar
syn region  vimExecute	oneline excludenl matchgroup=vimCommand start="\<exe\%[cute]\>" skip="\(\\\\\)*\\|" end="$\||\|<[cC][rR]>" contains=vimIsCommand,vimString,vimOper,vimVar,vimNotation
syn match   vimEchoHL	"echohl\="	skipwhite nextgroup=vimGroup,vimHLGroup,vimEchoHLNone
syn case ignore
syn keyword vimEchoHLNone	none
syn case match

" Maps
" ====
syn cluster vimMapGroup	contains=vimMapBang,vimMapLhs,vimMapMod
syn keyword vimMap	cm[ap] cno[remap] im[ap] ino[remap] map nm[ap] nn[oremap] no[remap] om[ap] ono[remap] vm[ap] vn[oremap] skipwhite nextgroup=@vimMapGroup
syn match   vimMapLhs    contained	"\S\+"	contains=vimNotation,vimCtrlChar
syn match   vimMapBang   contained	"!"	skipwhite nextgroup=vimMapLhs
syn match   vimMapMod    contained	"\c<\(buffer\|\(local\)\=leader\|plug\|script\|sid\|unique\|silent\)\+>" skipwhite contains=vimMapModKey,vimMapModErr nextgroup=@vimMapGroup
syn case ignore
syn keyword vimMapModKey contained	buffer	leader	localleader	plug	script	sid	silent	unique
syn case match

" Menus
" =====
syn keyword vimCommand	am[enu] an[oremenu] aun[menu] cme[nu] cnoreme[nu] cunme[nu] ime[nu] inoreme[nu] iunme[nu] me[nu] nme[nu] nnoreme[nu] noreme[nu] nunme[nu] ome[nu] onoreme[nu] ounme[nu] unme[nu] vme[nu] vnoreme[nu] vunme[nu] skipwhite nextgroup=vimMenuPriority,vimMenuName,vimMenuSilent
syn match   vimMenuName	"[^ \t\\<]\+"	contained nextgroup=vimMenuNameMore,vimMenuMap
syn match   vimMenuPriority	"\d\+\(\.\d\+\)*"	contained skipwhite nextgroup=vimMenuName
syn match   vimMenuNameMore	"\\\s\|<[tT][aA][bB]>\|\\\."	contained nextgroup=vimMenuName,vimMenuNameMore contains=vimNotation
syn match   vimMenuSilent	"<[sS][iI][lL][eE][nN][tT]>"	contained skipwhite nextgroup=vimMenuName,vimMenuPriority
syn match   vimMenuMap	"\t"	contained skipwhite nextgroup=@vimMapGroup

" Angle-Bracket Notation (tnx to Michael Geddes)
" ======================
syn case ignore
syn match vimNotation	"\(\\\|<lt>\)\=<\([scam]-\)\{0,4}x\=\(f\d\{1,2}\|[^ \t:]\|cr\|lf\|linefeed\|return\|k\=del\%[ete]\|bs\|backspace\|tab\|esc\|right\|left\|help\|undo\|insert\|ins\|k\=home\|k\=end\|kplus\|kminus\|kdivide\|kmultiply\|kenter\|space\|k\=\(page\)\=\(\|down\|up\)\)>" contains=vimBracket
syn match vimNotation	"\(\\\|<lt>\)\=<\([scam2-4]-\)\{0,4}\(right\|left\|middle\)\(mouse\)\=\(drag\|release\)\=>"	contains=vimBracket
syn match vimNotation	"\(\\\|<lt>\)\=<\(bslash\|plug\|sid\|space\|bar\|nop\|nul\|lt\)>"	contains=vimBracket
syn match vimNotation	'\(\\\|<lt>\)\=<C-R>[0-9a-z"%#:.\-=]'he=e-1	contains=vimBracket
syn match vimNotation	'\(\\\|<lt>\)\=<\(line[12]\|count\|bang\|reg\|args\|lt\|[qf]-args\)>'	contains=vimBracket
syn match vimBracket contained	"[\\<>]"
syn case match

" Syntax
"=======
syn match   vimGroupList	contained	"@\=[^ \t,]*"	contains=vimGroupSpecial,vimPatSep
syn match   vimGroupList	contained	"@\=[^ \t,]*,"	nextgroup=vimGroupList contains=vimGroupSpecial,vimPatSep
syn keyword vimGroupSpecial	contained	ALL	ALLBUT
syn match   vimSynError	contained	"\i\+"
syn match   vimSynError	contained	"\i\+="	nextgroup=vimGroupList
syn match   vimSynContains	contained	"\<contain\(s\|edin\)="	nextgroup=vimGroupList
syn match   vimSynKeyContainedin	contained	"\<containedin="	nextgroup=vimGroupList
syn match   vimSynNextgroup	contained	"nextgroup="	nextgroup=vimGroupList

syn match   vimSyntax	"\<sy\%[ntax]\>"	contains=vimCommand skipwhite nextgroup=vimSynType,vimComment
syn match   vimAuSyntax	contained	"\s+sy\%[ntax]"	contains=vimCommand skipwhite nextgroup=vimSynType,vimComment

" Syntax: case
syn keyword vimSynType	contained	case	skipwhite nextgroup=vimSynCase,vimSynCaseError
syn match   vimSynCaseError	contained	"\i\+"
syn keyword vimSynCase	contained	ignore	match

" Syntax: clear
syn keyword vimSynType	contained	clear	skipwhite nextgroup=vimGroupList

" Syntax: cluster
syn keyword vimSynType	contained	cluster	skipwhite nextgroup=vimClusterName
syn region  vimClusterName	contained	matchgroup=vimGroupName start="\k\+" skip="\\\\\|\\|" matchgroup=vimSep end="$\||" contains=vimGroupAdd,vimGroupRem,vimSynContains,vimSynError
syn match   vimGroupAdd	contained	"add="	nextgroup=vimGroupList
syn match   vimGroupRem	contained	"remove="	nextgroup=vimGroupList

" Syntax: include
syn keyword vimSynType	contained	include	skipwhite nextgroup=vimGroupList

" Syntax: keyword
syn cluster vimSynKeyGroup	contains=vimSynNextgroup,vimSynKeyOpt,vimSynKeyContainedin
syn keyword vimSynType	contained	keyword	skipwhite nextgroup=vimSynKeyRegion
syn region  vimSynKeyRegion	contained keepend	matchgroup=vimGroupName start="\k\+" skip="\\\\\|\\|" matchgroup=vimSep end="|\|$" contains=@vimSynKeyGroup
syn match   vimSynKeyOpt	contained	"\<\(contained\|transparent\|skipempty\|skipwhite\|skipnl\)\>"

" Syntax: match
syn cluster vimSynMtchGroup	contains=vimMtchComment,vimSynContains,vimSynError,vimSynMtchOpt,vimSynNextgroup,vimSynRegPat
syn keyword vimSynType	contained	match	skipwhite nextgroup=vimSynMatchRegion
syn region  vimSynMatchRegion	contained keepend	matchgroup=vimGroupName start="\k\+" matchgroup=vimSep end="|\|$" contains=@vimSynMtchGroup
syn match   vimSynMtchOpt	contained	"\<\(transparent\|contained\|excludenl\|skipempty\|skipwhite\|display\|extend\|skipnl\|fold\)\>"

" Syntax: off and on
syn keyword vimSynType	contained	enable	list	manual	off	on	reset

" Syntax: region
syn cluster vimSynRegPatGroup	contains=vimPatSep,vimNotPatSep,vimSynPatRange,vimSynNotPatRange,vimSubstSubstr,vimPatRegion,vimPatSepErr
syn cluster vimSynRegGroup	contains=vimSynContains,vimSynNextgroup,vimSynRegOpt,vimSynReg,vimSynMtchGrp
syn keyword vimSynType	contained	region	skipwhite nextgroup=vimSynRegion
syn region  vimSynRegion	contained keepend	matchgroup=vimGroupName start="\k\+" skip="\\\\\|\\|" end="|\|$" contains=@vimSynRegGroup
syn match   vimSynRegOpt	contained	"\<\(transparent\|contained\|excludenl\|skipempty\|skipwhite\|display\|keepend\|oneline\|extend\|skipnl\|fold\)\>"
syn match   vimSynReg	contained	"\(start\|skip\|end\)="he=e-1	nextgroup=vimSynRegPat
syn match   vimSynMtchGrp	contained	"matchgroup="	nextgroup=vimGroup,vimHLGroup
syn region  vimSynRegPat	contained extend	start="\z([[:punct:]]\)"  skip="\\\\\|\\\z1"  end="\z1"  contains=@vimSynRegPatGroup skipwhite nextgroup=vimSynPatMod,vimSynReg
syn match   vimSynPatMod	contained	"\(hs\|ms\|me\|hs\|he\|rs\|re\)=[se]\([-+]\d\+\)\="
syn match   vimSynPatMod	contained	"\(hs\|ms\|me\|hs\|he\|rs\|re\)=[se]\([-+]\d\+\)\=," nextgroup=vimSynPatMod
syn match   vimSynPatMod	contained	"lc=\d\+"
syn match   vimSynPatMod	contained	"lc=\d\+," nextgroup=vimSynPatMod
syn region  vimSynPatRange	contained	start="\["	skip="\\\\\|\\]"   end="]"
syn match   vimSynNotPatRange	contained	"\\\\\|\\\["
syn match   vimMtchComment	contained	'"[^"]\+$'

" Syntax: sync
" ============
syn keyword vimSynType	contained	sync	skipwhite	nextgroup=vimSyncC,vimSyncLines,vimSyncMatch,vimSyncError,vimSyncLinecont,vimSyncRegion
syn match   vimSyncError	contained	"\i\+"
syn keyword vimSyncC	contained	ccomment	clear	fromstart
syn keyword vimSyncMatch	contained	match	skipwhite	nextgroup=vimSyncGroupName
syn keyword vimSyncRegion	contained	region	skipwhite	nextgroup=vimSynReg
syn keyword vimSyncLinecont	contained	linecont	skipwhite	nextgroup=vimSynRegPat
syn match   vimSyncLines	contained	"\(min\|max\)\=lines="	nextgroup=vimNumber
syn match   vimSyncGroupName	contained	"\k\+"	skipwhite	nextgroup=vimSyncKey
syn match   vimSyncKey	contained	"\<groupthere\|grouphere\>"	skipwhite nextgroup=vimSyncGroup
syn match   vimSyncGroup	contained	"\k\+"	skipwhite	nextgroup=vimSynRegPat,vimSyncNone
syn keyword vimSyncNone	contained	NONE

" Additional IsCommand, here by reasons of precedence
" ====================
syn match vimIsCommand	"<Bar>\s*\a\+"	transparent contains=vimCommand,vimNotation

" Highlighting
" ============
syn cluster vimHighlightCluster	contains=vimHiLink,vimHiClear,vimHiKeyList,vimComment
syn match   vimHighlight	"\<hi\%[ghlight]\>" skipwhite nextgroup=vimHiBang,@vimHighlightCluster
syn match   vimHiBang	contained	"!"	  skipwhite nextgroup=@vimHighlightCluster

syn match   vimHiGroup	contained	"\i\+"
syn case ignore
syn keyword vimHiAttrib	contained	none bold inverse italic reverse standout underline
syn keyword vimFgBgAttrib	contained	none bg background fg foreground
syn case match
syn match   vimHiAttribList	contained	"\i\+"	contains=vimHiAttrib
syn match   vimHiAttribList	contained	"\i\+,"he=e-1	contains=vimHiAttrib nextgroup=vimHiAttribList,vimHiAttrib
syn case ignore
syn keyword vimHiCtermColor	contained	black blue brown cyan darkBlue darkcyan darkgray darkgreen darkgrey darkmagenta darkred darkyellow gray green grey lightblue lightcyan lightgray lightgreen lightgrey lightmagenta lightred magenta red white yellow

syn case match
syn match   vimHiFontname	contained	"[a-zA-Z\-*]\+"
syn match   vimHiGuiFontname	contained	"'[a-zA-Z\-* ]\+'"
syn match   vimHiGuiRgb	contained	"#\x\{6}"
syn match   vimHiCtermError	contained	"[^0-9]\i*"

" Highlighting: hi group key=arg ...
syn cluster vimHiCluster contains=vimHiGroup,vimHiTerm,vimHiCTerm,vimHiStartStop,vimHiCtermFgBg,vimHiGui,vimHiGuiFont,vimHiGuiFgBg,vimHiKeyError,vimNotation
syn region vimHiKeyList	contained oneline start="\i\+" skip="\\\\\|\\|" end="$\||"	contains=@vimHiCluster
syn match  vimHiKeyError	contained	"\i\+="he=e-1
syn match  vimHiTerm	contained	"[tT][eE][rR][mM]="he=e-1	nextgroup=vimHiAttribList
syn match  vimHiStartStop	contained	"\([sS][tT][aA][rR][tT]\|[sS][tT][oO][pP]\)="he=e-1	nextgroup=vimHiTermcap,vimOption
syn match  vimHiCTerm	contained	"[cC][tT][eE][rR][mM]="he=e-1	nextgroup=vimHiAttribList
syn match  vimHiCtermFgBg	contained	"[cC][tT][eE][rR][mM][fFbB][gG]="he=e-1	nextgroup=vimNumber,vimHiCtermColor,vimFgBgAttrib,vimHiCtermError
syn match  vimHiGui	contained	"[gG][uU][iI]="he=e-1	nextgroup=vimHiAttribList
syn match  vimHiGuiFont	contained	"[fF][oO][nN][tT]="he=e-1	nextgroup=vimHiFontname
syn match  vimHiGuiFgBg	contained	"[gG][uU][iI][fFbB][gG]="he=e-1	nextgroup=vimHiGroup,vimHiGuiFontname,vimHiGuiRgb,vimFgBgAttrib
syn match  vimHiTermcap	contained	"\S\+"	contains=vimNotation

" Highlight: clear
syn keyword vimHiClear	contained	clear	nextgroup=vimHiGroup

" Highlight: link
syn region vimHiLink	contained oneline matchgroup=vimCommand start="\<\(def\s\+\)\=link\>\|\<def\>" end="$"	contains=vimHiGroup,vimGroup,vimHLGroup,vimNotation

" Control Characters
" ==================
syn match vimCtrlChar	"[--]"

" Beginners - Patterns that involve ^
" =========
syn match  vimLineComment	+^[ \t:]*".*$+	contains=@vimCommentGroup,vimCommentString,vimCommentTitle
syn match  vimCommentTitle	'"\s*\u\w*\(\s\+\u\w*\)*:'hs=s+1	contained contains=vimCommentTitleLeader,vimTodo,@vimCommentGroup
syn match  vimContinue	"^\s*\\"
syn region vimString	start="^\s*\\\z(['"]\)" skip='\\\\\|\\\z1' end="\z1" oneline keepend contains=@vimStringGroup,vimContinue
syn match  vimCommentTitleLeader	'"\s\+'ms=s+1	contained

" Scripts  : perl,ruby : Benoit Cerrina
" =======    python,tcl: Johannes Zellner

" allow users to prevent embedded script syntax highlighting
" when vim doesn't have perl/python/ruby/tcl support.  Do
" so by setting g:vimembedscript= 0 in the user's <.vimrc>.
if !exists("g:vimembedscript")
 let g:vimembedscript= 1
endif

" [-- perl --]
if (has("perl") || g:vimembedscript) && filereadable(expand("<sfile>:p:h")."/perl.vim")
 unlet! b:current_syntax
 syn include @vimPerlScript <sfile>:p:h/perl.vim
 syn region vimPerlRegion matchgroup=vimScriptDelim start=+pe\%[rl]\s*<<\s*\z(.*\)$+ end=+^\z1$+ contains=@vimPerlScript
 syn region vimPerlRegion matchgroup=vimScriptDelim start=+pe\%[rl]\s*<<\s*$+ end=+\.$+ contains=@vimPerlScript
endif

" [-- ruby --]
if (has("ruby") || g:vimembedscript) && filereadable(expand("<sfile>:p:h")."/ruby.vim")
 unlet! b:current_syntax
 syn include @vimRubyScript <sfile>:p:h/ruby.vim
 syn region vimRubyRegion matchgroup=vimScriptDelim start=+rub[y]\s*<<\s*\z(.*\)$+ end=+^\z1$+ contains=@vimRubyScript
 syn region vimRubyRegion matchgroup=vimScriptDelim start=+rub[y]\s*<<\s*$+ end=+\.$+ contains=@vimRubyScript
endif

" [-- python --]
if (has("python") || g:vimembedscript) && filereadable(expand("<sfile>:p:h")."/python.vim")
 unlet! b:current_syntax
 syn include @vimPythonScript <sfile>:p:h/python.vim
 syn region vimPythonRegion matchgroup=vimScriptDelim start=+py\%[thon]\s*<<\s*\z(.*\)$+ end=+^\z1$+ contains=@vimPythonScript
 syn region vimPythonRegion matchgroup=vimScriptDelim start=+py\%[thon]\s*<<\s*$+ end=+\.$+ contains=@vimPythonScript
endif

" [-- tcl --]
if (has("tcl") || g:vimembedscript) && filereadable(expand("<sfile>:p:h")."/tcl.vim")
 unlet! b:current_syntax
 syn include @vimTclScript <sfile>:p:h/tcl.vim
 syn region vimTclRegion matchgroup=vimScriptDelim start=+tc[l]\=\s*<<\s*\z(.*\)$+ end=+^\z1$+ contains=@vimTclScript
 syn region vimTclRegion matchgroup=vimScriptDelim start=+tc[l]\=\s*<<\s*$+ end=+\.$+ contains=@vimTclScript
endif

" Synchronize (speed)
"============
if exists("b:vim_minlines")
 exe "syn sync minlines=".b:vim_minlines
endif
if exists("b:vim_maxlines")
 exe "syn sync maxlines=".b:vim_maxlines
else
 syn sync maxlines=60
endif
syn sync linecont	"^\s\+\\"
syn sync match vimAugroupSyncA	groupthere NONE	"\<aug\%[roup]\>\s\+[eE][nN][dD]"

" Highlighting Settings
" ====================

" The default highlighting.
hi def link vimAuHighlight	vimHighlight
hi def link vimSubst1	vimSubst
hi def link vimBehaveModel	vimBehave

hi def link vimAddress	vimMark
hi def link vimAugroupKey	vimCommand
"  hi def link vimAugroupError	vimError
hi def link vimAutoCmd	vimCommand
hi def link vimAutoCmdOpt	vimOption
hi def link vimAutoSet	vimCommand
hi def link vimBehave	vimCommand
hi def link vimBehaveError	vimError
hi def link vimCollClassErr	vimError
hi def link vimCommentString	vimString
hi def link vimCondHL	vimCommand
hi def link vimEchoHL	vimCommand
hi def link vimEchoHLNone	vimGroup
hi def link vimElseif	vimCondHL
hi def link vimErrSetting	vimError
hi def link vimFgBgAttrib	vimHiAttrib
hi def link vimFTCmd	vimCommand
hi def link vimFTOption	vimSynType
hi def link vimFTError	vimError
hi def link vimFunctionError	vimError
hi def link vimFuncKey	vimCommand
hi def link vimGroupAdd	vimSynOption
hi def link vimGroupRem	vimSynOption
hi def link vimHLGroup	vimGroup
hi def link vimHiAttribList	vimError
hi def link vimHiCTerm	vimHiTerm
hi def link vimHiCtermError	vimError
hi def link vimHiCtermFgBg	vimHiTerm
hi def link vimHiGroup	vimGroupName
hi def link vimHiGui	vimHiTerm
hi def link vimHiGuiFgBg	vimHiTerm
hi def link vimHiGuiFont	vimHiTerm
hi def link vimHiGuiRgb	vimNumber
hi def link vimHiKeyError	vimError
hi def link vimHiStartStop	vimHiTerm
hi def link vimHighlight	vimCommand
hi def link vimInsert	vimString
hi def link vimKeyCode	vimSpecFile
hi def link vimKeyCodeError	vimError
hi def link vimLet	vimCommand
hi def link vimLineComment	vimComment
hi def link vimMap	vimCommand
hi def link vimMapMod	vimBracket
hi def link vimMapModErr	vimError
hi def link vimMapModKey	vimFuncSID
hi def link vimMapBang	vimCommand
hi def link vimMenuNameMore	vimMenuName
hi def link vimMtchComment	vimComment
hi def link vimNotFunc	vimCommand
hi def link vimNotPatSep	vimString
hi def link vimPatSepErr	vimPatSep
hi def link vimPlainMark	vimMark
hi def link vimPlainRegister	vimRegister
hi def link vimSetString	vimString
hi def link vimSpecFileMod	vimSpecFile
hi def link vimStringCont	vimString
hi def link vimSubst	vimCommand
hi def link vimSubstTwoBS	vimString
hi def link vimSubstFlagErr	vimError
hi def link vimSynCaseError	vimError
hi def link vimSynContains	vimSynOption
hi def link vimSynKeyContainedin	vimSynContains
hi def link vimSynKeyOpt	vimSynOption
hi def link vimSynMtchGrp	vimSynOption
hi def link vimSynMtchOpt	vimSynOption
hi def link vimSynNextgroup	vimSynOption
hi def link vimSynNotPatRange	vimSynRegPat
hi def link vimSynPatRange	vimString
hi def link vimSynRegOpt	vimSynOption
hi def link vimSynRegPat	vimString
hi def link vimSyntax	vimCommand
hi def link vimSynType	vimSpecial
hi def link vimSyncGroup	vimGroupName
hi def link vimSyncGroupName	vimGroupName
hi def link vimUserAttrb	vimSpecial
hi def link vimUserAttrbCmplt	vimSpecial
hi def link vimUserAttrbKey	vimOption
hi def link vimUserCommand	vimCommand

hi def link vimAutoEvent	Type
hi def link vimBracket	Delimiter
hi def link vimCmplxRepeat	SpecialChar
hi def link vimCommand	Statement
hi def link vimComment	Comment
hi def link vimCommentTitle	PreProc
hi def link vimContinue	Special
hi def link vimCtrlChar	SpecialChar
hi def link vimElseIfErr	Error
hi def link vimEnvvar	PreProc
hi def link vimError	Error
hi def link vimFuncName	Function
hi def link vimFuncSID	Special
hi def link vimFuncVar	Identifier
hi def link vimGroup	Type
hi def link vimGroupSpecial	Special
hi def link vimHLMod	PreProc
hi def link vimHiAttrib	PreProc
hi def link vimHiTerm	Type
hi def link vimKeyword	Statement
hi def link vimMark	Number
hi def link vimMenuName	PreProc
hi def link vimNotation	Special
hi def link vimNumber	Number
hi def link vimOper	Operator
hi def link vimOption	PreProc
hi def link vimPatSep	SpecialChar
hi def link vimPattern	Type
hi def link vimRegister	SpecialChar
hi def link vimScriptDelim	Comment
hi def link vimSep	Delimiter
hi def link vimSetSep	Statement
hi def link vimSpecFile	Identifier
hi def link vimSpecial	Type
hi def link vimStatement	Statement
hi def link vimString	String
hi def link vimSubstDelim	Delimiter
hi def link vimSubstFlags	Special
hi def link vimSubstSubstr	SpecialChar
hi def link vimSynCase	Type
hi def link vimSynCaseError	Error
hi def link vimSynError	Error
hi def link vimSynOption	Special
hi def link vimSynReg	Type
hi def link vimSyncC	Type
hi def link vimSyncError	Error
hi def link vimSyncKey	Type
hi def link vimSyncNone	Type
hi def link vimTodo	Todo
hi def link vimUserCmdError	Error

let b:current_syntax = "vim"
