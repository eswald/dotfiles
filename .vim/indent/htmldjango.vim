if exists('b:django_blocks')
  unlet b:django_blocks
endif

" Helper function to assemble tag list
fun! <SID>TagPush(tag)
  if exists('b:django_blocks')
    let b:django_blocks = b:django_blocks.'\|'.a:tag
  else
    let b:django_blocks = a:tag
  endif
endfun

" Django tags that open an indentable block.
call <SID>TagPush('autoescape')
call <SID>TagPush('block')
call <SID>TagPush('comment')
call <SID>TagPush('filter')
call <SID>TagPush('for')
call <SID>TagPush('if')
call <SID>TagPush('ifchanged')
call <SID>TagPush('ifequal')
call <SID>TagPush('ifnotequal')
call <SID>TagPush('spaceless')
call <SID>TagPush('verbatim')
call <SID>TagPush('with')

" Django tags that both close and open a block.
call <SID>TagPush('empty')
call <SID>TagPush('elif')
call <SID>TagPush('else')

delfun <SID>TagPush
