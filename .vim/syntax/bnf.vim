" Vim syntax file
" Language:	ToothyWiki .bnf file
" Maintainer:	Eric Wald <breadman@users.sourceforge.net
" Last Change:	Today

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

syn clear
syn case ignore
syn match bnfError	'::='
syn match bnfError	contained '\S'
syn match bnfOperator	contained '|'
syn match bnfName	contained '\w\+' nextgroup=bnfConcat,bnfLookup
syn match bnfRule	'^\s*\w\+\s*::=.*$' contains=bnfRuleStart,@bnfExpression
syn match bnfRuleStart	contained '^\s*\w\+\s*::=' contains=bnfName,bnfOperator
syn match bnfConcat	contained '##\w\+' contains=bnfName nextgroup=bnfConcat,bnfLookup

syn match bnfAssign	contained '<\w\(\w\|[{}#]\)*::=\w\(\w\|[{}#]\)*>' contains=bnfName,bnfError,bnfAssignOperator
syn match bnfAssignOperator	'<\ze[^:=<>]*::=[^:=<>]*>'
syn match bnfAssignOperator	'\(<[^:=<>]*\)\@<=::=\ze[^:=<>]*>'
syn match bnfAssignOperator	'\(<[^:=<>]*::=[^:=<>]*\)\@<=>'

syn cluster bnfExpression	contains=bnfName,bnfError,bnfOperator,bnfList,bnfOptional,bnfString,bnfAssign
syn region bnfList	contained oneline matchgroup=bnfOperator start='('  end=')' contains=bnfName,@bnfExpression
syn region bnfOptional	contained oneline matchgroup=bnfOperator start='\[' end=']' contains=bnfName,@bnfExpression
syn region bnfString	contained oneline matchgroup=bnfOperator start='"'  end='"'
syn region bnfLookup	contained oneline matchgroup=bnfOperator start='{' end='}' contains=bnfName,bnfError nextgroup=bnfLookup
syn region bnfComment	start="//" end="$"
"syn region bnfAssign	contained oneline matchgroup=bnfOperator start='<' end='>' contains=bnfAssignName,bnfAssignError,bnfError
"syn match bnfAssignError	'\s'
"syn match bnfAssignOperator	'::='

hi def link bnfComment	Comment
hi def link bnfError	Error
hi def link bnfString	String
hi def link bnfName	Identifier
hi def link bnfOperator	Operator
hi def link bnfRuleStart	bnfOperator
hi def link bnfConcat	bnfOperator
hi def link bnfAssignOperator	bnfOperator

let b:current_syntax = "wiki"
