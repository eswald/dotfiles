" Description:	html indenter
" Author:	Johannes Zellner <johannes@zellner.org>
" Updated By:	Bram Moolenaar
" Modified By:	Eric Wald
" URL:		http://www.brainshell.org/vim/indent/html.vim
" Last Change:	21-Mar-2006
" Globals:	g:html_indent_tags	-- tags that don't require indenting

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
    finish
endif
let b:did_indent = 1


" [-- local settings --]
setlocal indentexpr=HtmlIndentGet(v:lnum)
setlocal indentkeys=o,O,*<Return>,<>>,/,{,}


if exists('g:html_indent_tags')
    unlet g:html_indent_tags
endif

" [-- helper function to assemble tag list --]
fun! <SID>HtmlIndentPush(tag)
    if exists('g:html_indent_tags')
	let g:html_indent_tags = g:html_indent_tags.'\|'.a:tag
    else
	let g:html_indent_tags = a:tag
    endif
endfun


" [-- Empty elements --]
call <SID>HtmlIndentPush('hr')
call <SID>HtmlIndentPush('br')
call <SID>HtmlIndentPush('area')
call <SID>HtmlIndentPush('link')
call <SID>HtmlIndentPush('img')
call <SID>HtmlIndentPush('param')
call <SID>HtmlIndentPush('input')
call <SID>HtmlIndentPush('col')
call <SID>HtmlIndentPush('base')
call <SID>HtmlIndentPush('meta')
call <SID>HtmlIndentPush('basefont')
call <SID>HtmlIndentPush('frame')
call <SID>HtmlIndentPush('isindex')

delfun <SID>HtmlIndentPush

set cpo-=C

" [-- count indent-increasing tags in the text --]
fun! <SID>HtmlIndentOpen(text)
    let s = substitute(a:text, '<[/!?][^>]*>', '', 'g')
    let s = substitute(s, '<\w[^>]*/>', '', 'g')
    let s = substitute(s, '\c<\%('.g:html_indent_tags.'\)\>[^>]*>', '', 'g')
    let s = substitute(s, '\c<\%('.g:html_indent_tags.'\)\>[^>]*$', '<', 'g')
    let s = substitute(s, '<[^<>]\+$', '<<', 'g')
    if exists('b:django_blocks')
	" Django framework tags
	let s = substitute(s, '{%\s*\%('.b:django_blocks.'\)', '<', 'g')
    endif
    let s = substitute(s, '[^<]\+', '', 'g')
    return strlen(s)
endfun

" [-- count indent-decreasing tags in the text --]
fun! <SID>HtmlIndentClose(text)
    let s = substitute(a:text, '</\@![^>]*>', '', 'g')
    if exists('b:django_blocks')
	let s = substitute(s, '{%\s*\%(end\|else\|elif\|empty\)', '>', 'g')
    endif
    let s = substitute(s, '[^>]\+', '', 'g')
    "return (mode() == 'i' && col('.') == 1) ? 0 : strlen(s)
    return strlen(s)
endfun

" [-- count indent-increasing '{' of (java|css) text --]
fun! <SID>HtmlIndentOpenAlt(text)
    return strlen(substitute(a:text, '[^{]\+', '', 'g'))
endfun

" [-- count indent-decreasing '}' of (java|css) text --]
fun! <SID>HtmlIndentCloseAlt(text)
    return strlen(substitute(a:text, '[^}]\+', '', 'g'))
endfun

fun! <SID>HtmlIndentStrpart(text, pattern, state)
    let pattern = '^\%(\s*'.a:pattern.'\)*'.(a:state ? '\zs.*' : '')
    return substitute(a:text, pattern, '', '')
endfunction

" [-- return the sum of indents, respecting the syntax of a:lnum --]
fun! <SID>HtmlIndentSum(lnum, state)
    let text = getline(a:lnum)
    if '' != &syntax &&
	\ synIDattr(synID(a:lnum, 1, 1), 'name') =~ '\c\%(css\|java\).*' &&
	\ synIDattr(synID(a:lnum, strlen(text), 1), 'name')
	\ =~ '\c\%(css\|java\).*'
	let part = <SID>HtmlIndentStrpart(text, '}', a:state)
	return <SID>HtmlIndentOpenAlt(part) - <SID>HtmlIndentCloseAlt(part)
    else
	let pattern = '</[^>]*>'
	if exists('b:django_blocks')
	    let pattern = pattern . '\|\s*{%\s*end\w*\s*%}'
	    "let pattern = pattern . '\|\s*{%\s*\%(end\w*\|else\|elif\|empty\)\s*%}'
	endif
	let part = <SID>HtmlIndentStrpart(text, pattern, a:state)
	return <SID>HtmlIndentOpen(part) - <SID>HtmlIndentClose(part)
    endif
    return 0
endfun

fun! HtmlIndentGet(lnum)
    " Find a non-empty line above the current line.
    let lnum = prevnonblank(a:lnum - 1)

    " [-- special handling for <pre>: no indenting --]
    if getline(a:lnum) =~ '\c</pre>'
	  \ || 0 < searchpair('\c<pre>', '', '\c</pre>', 'nWb')
	  \ || 0 < searchpair('\c<pre>', '', '\c</pre>', 'nW')
	" we're in a line with </pre> or inside <pre> ... </pre>
	return -1
    endif

    if getline(lnum) =~ '\c</pre>'
	" line before the current line a:lnum contains
	" a closing </pre>. --> search for line before
	" starting <pre> to restore the indent.
	let lnum = prevnonblank(search('\c<pre>', 'bW') - 1)
    endif

    " At the start of the file, use zero indent.
    if lnum == 0
	return 0
    endif

    let ind = <SID>HtmlIndentSum(lnum, 0) + <SID>HtmlIndentSum(a:lnum, 1)

    return indent(lnum) + (&sw * ind)
endfun

" vim: ts=8 sts=4 sw=4
" [-- EOF <runtime>/indent/html.vim --]
