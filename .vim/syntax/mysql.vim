" Vim syntax file
" Language:     mysql
" Maintainer:   Kenneth J. Pronovici <pronovic@ieee.org>
" Modified By:	Eric Wald <eswald@brainshell.org>
" Last Change:  29-Nov-2007
" Filenames:    *.mysql
" URL:		ftp://cedar-solutions.com/software/mysql.vim
" Note:		The definitions below are for version 5.2

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Always ignore case
syn case ignore

" General keywords which don't fall into other categories
syn keyword mysqlKeyword	 action add after aggregate all as asc auto_increment avg avg_row_length
syn keyword mysqlKeyword	 both by
syn keyword mysqlKeyword	 cascade change character column columns comment constraint cross
syn keyword mysqlKeyword	 current_date current_time current_timestamp
syn keyword mysqlKeyword	 data database databases day day_hour day_minute day_second
syn keyword mysqlKeyword	 default delayed delay_key_write desc distinct distinctrow
syn keyword mysqlKeyword	 enclosed escape escaped
syn keyword mysqlKeyword	 fields file first for foreign from full function
syn keyword mysqlKeyword	 global grants group
syn keyword mysqlKeyword	 having heap high_priority hosts hour hour_minute hour_second
syn keyword mysqlKeyword	 identified ignore index infile inner insert_id into isam
syn keyword mysqlKeyword	 join
syn keyword mysqlKeyword	 key keys 
syn keyword mysqlKeyword	 last_insert_id leading left limit lines local logs long low_priority
syn keyword mysqlKeyword	 match max_rows middleint min_rows minute minute_second modify month myisam
syn keyword mysqlKeyword	 natural no
syn keyword mysqlKeyword	 on option optionally order outer outfile
syn keyword mysqlKeyword	 pack_keys partial password primary privileges procedure process processlist
syn keyword mysqlKeyword	 read references reload restrict returns row rows
syn keyword mysqlKeyword	 second shutdown soname sql_big_result sql_big_selects sql_big_tables sql_log_off
syn keyword mysqlKeyword	 sql_log_update sql_low_priority_updates sql_select_limit sql_small_result sql_warnings starting
syn keyword mysqlKeyword	 status straight_join string
syn keyword mysqlKeyword	 table tables temporary terminated to trailing type
syn keyword mysqlKeyword	 unique unsigned usage using
syn keyword mysqlKeyword	 values varbinary variables varying
syn keyword mysqlKeyword	 where with write
syn keyword mysqlKeyword	 year_month
syn keyword mysqlKeyword	 zerofill

" Statement openers
syn keyword mysqlStatement	 alter analyze
syn keyword mysqlStatement	 backup begin
syn keyword mysqlStatement	 cache call check checksum close commit create
syn keyword mysqlStatement	 deallocate delete describe drop
syn keyword mysqlStatement	 execute explain
syn keyword mysqlStatement	 fetch flush
syn keyword mysqlStatement	 grant
syn keyword mysqlStatement	 handler
syn keyword mysqlStatement	 insert iterate
syn keyword mysqlStatement	 kill
syn keyword mysqlStatement	 leave load lock
syn keyword mysqlStatement	 open optimize
syn keyword mysqlStatement	 prepare
syn keyword mysqlStatement	 rename repair replace reset restore revoke rollback
syn keyword mysqlStatement	 savepoint select set show start
syn keyword mysqlStatement	 truncate
syn keyword mysqlStatement	 union unlock update usage use
syn keyword mysqlStatement	 xa

" Special values
syn keyword mysqlSpecial	 false null true

" Strings (single- and double-quote)
syn region mysqlString		 start=+"+  skip=+\\\\\|\\"+  end=+"+
syn region mysqlString		 start=+'+  skip=+\\\\\|\\'+  end=+'+

" Quoted identifiers
syn region mysqlIdentifier	 start=+`+  skip=+\\\\\|\\`+  end=+`+

" Numbers and hexidecimal values
syn match mysqlNumber		 "-\=\<[0-9]*\>"
syn match mysqlNumber		 "-\=\<[0-9]*\.[0-9]*\>"
syn match mysqlNumber		 "-\=\<[0-9]*e[+-]\=[0-9]*\>"
syn match mysqlNumber		 "-\=\<[0-9]*\.[0-9]*e[+-]\=[0-9]*\>"
syn match mysqlNumber		 "\<0x[abcdefABCDEF0-9]*\>"

" User variables
syn match mysqlVariable		 "@\a*\w*\.\?\w*"

" Comments (c-style, mysql-style and modified sql-style)
syn region mysqlComment		 start="/\*"  end="\*/"
syn region mysqlComment		 start="/\*!"  end="\*/"  contains=ALLBUT,mysqlComment
syn match mysqlComment		 "#.*"
syn match mysqlComment		 "-- .*"
syn sync ccomment mysqlComment

" Column types
syn keyword mysqlType		 tinyint smallint mediumint int integer bigint
syn keyword mysqlType		 date datetime time timestamp year
syn keyword mysqlType		 tinytext mediumtext longtext text
syn keyword mysqlType		 tinyblob mediumblob longblob blob
syn keyword mysqlType		 char binary varchar varbinary
syn keyword mysqlType		 bool boolean bit set enum

" Logical, string and  numeric operators
syn keyword mysqlOperator	 between not and or is in like regexp rlike exists
syn region mysqlOperator	 start="isnull(" end=")" contains=ALL
syn region mysqlOperator	 start="coalesce(" end=")" contains=ALL
syn region mysqlOperator	 start="interval(" end=")" contains=ALL

" Control flow functions
syn keyword mysqlFlow		 while do loop repeat until case when if then else end
syn region mysqlFlow		 start="ifnull("   end=")"  contains=ALL
syn region mysqlFlow		 start="nullif("   end=")"  contains=ALL
syn region mysqlFlow		 start="if("	   end=")"  contains=ALL

" General Functions
"
" I'm leery of just defining keywords for functions, since according to the MySQL manual:
"
"     Function names do not clash with table or column names. For example, ABS is a
"     valid column name. The only restriction is that for a function call, no spaces
"     are allowed between the function name and the `(' that follows it.
"
" This means that if I want to highlight function names properly, I have to use a
" region to define them, not just a keyword.  This will probably cause the syntax file
" to load more slowly, but at least it will be 'correct'.

syn region mysqlFunction	 start="abs(" end=")" contains=ALL
syn region mysqlFunction	 start="acos(" end=")" contains=ALL
syn region mysqlFunction	 start="adddate(" end=")" contains=ALL
syn region mysqlFunction	 start="ascii(" end=")" contains=ALL
syn region mysqlFunction	 start="asin(" end=")" contains=ALL
syn region mysqlFunction	 start="atan(" end=")" contains=ALL
syn region mysqlFunction	 start="atan2(" end=")" contains=ALL
syn region mysqlFunction	 start="benchmark(" end=")" contains=ALL
syn region mysqlFunction	 start="bin(" end=")" contains=ALL
syn region mysqlFunction	 start="bit_and(" end=")" contains=ALL
syn region mysqlFunction	 start="bit_count(" end=")" contains=ALL
syn region mysqlFunction	 start="bit_or(" end=")" contains=ALL
syn region mysqlFunction	 start="ceiling(" end=")" contains=ALL
syn region mysqlFunction	 start="character_length(" end=")" contains=ALL
syn region mysqlFunction	 start="char_length(" end=")" contains=ALL
syn region mysqlFunction	 start="concat(" end=")" contains=ALL
syn region mysqlFunction	 start="concat_ws(" end=")" contains=ALL
syn region mysqlFunction	 start="connection_id(" end=")" contains=ALL
syn region mysqlFunction	 start="conv(" end=")" contains=ALL
syn region mysqlFunction	 start="cos(" end=")" contains=ALL
syn region mysqlFunction	 start="cot(" end=")" contains=ALL
syn region mysqlFunction	 start="count(" end=")" contains=ALL
syn region mysqlFunction	 start="curdate(" end=")" contains=ALL
syn region mysqlFunction	 start="curtime(" end=")" contains=ALL
syn region mysqlFunction	 start="date_add(" end=")" contains=ALL
syn region mysqlFunction	 start="date_format(" end=")" contains=ALL
syn region mysqlFunction	 start="date_sub(" end=")" contains=ALL
syn region mysqlFunction	 start="dayname(" end=")" contains=ALL
syn region mysqlFunction	 start="dayofmonth(" end=")" contains=ALL
syn region mysqlFunction	 start="dayofweek(" end=")" contains=ALL
syn region mysqlFunction	 start="dayofyear(" end=")" contains=ALL
syn region mysqlFunction	 start="decode(" end=")" contains=ALL
syn region mysqlFunction	 start="degrees(" end=")" contains=ALL
syn region mysqlFunction	 start="elt(" end=")" contains=ALL
syn region mysqlFunction	 start="encode(" end=")" contains=ALL
syn region mysqlFunction	 start="encrypt(" end=")" contains=ALL
syn region mysqlFunction	 start="exp(" end=")" contains=ALL
syn region mysqlFunction	 start="export_set(" end=")" contains=ALL
syn region mysqlFunction	 start="extract(" end=")" contains=ALL
syn region mysqlFunction	 start="field(" end=")" contains=ALL
syn region mysqlFunction	 start="find_in_set(" end=")" contains=ALL
syn region mysqlFunction	 start="floor(" end=")" contains=ALL
syn region mysqlFunction	 start="format(" end=")" contains=ALL
syn region mysqlFunction	 start="from_days(" end=")" contains=ALL
syn region mysqlFunction	 start="from_unixtime(" end=")" contains=ALL
syn region mysqlFunction	 start="get_lock(" end=")" contains=ALL
syn region mysqlFunction	 start="greatest(" end=")" contains=ALL
syn region mysqlFunction	 start="group_unique_users(" end=")" contains=ALL
syn region mysqlFunction	 start="hex(" end=")" contains=ALL
syn region mysqlFunction	 start="inet_aton(" end=")" contains=ALL
syn region mysqlFunction	 start="inet_ntoa(" end=")" contains=ALL
syn region mysqlFunction	 start="instr(" end=")" contains=ALL
syn region mysqlFunction	 start="lcase(" end=")" contains=ALL
syn region mysqlFunction	 start="least(" end=")" contains=ALL
syn region mysqlFunction	 start="length(" end=")" contains=ALL
syn region mysqlFunction	 start="load_file(" end=")" contains=ALL
syn region mysqlFunction	 start="locate(" end=")" contains=ALL
syn region mysqlFunction	 start="log(" end=")" contains=ALL
syn region mysqlFunction	 start="log10(" end=")" contains=ALL
syn region mysqlFunction	 start="lower(" end=")" contains=ALL
syn region mysqlFunction	 start="lpad(" end=")" contains=ALL
syn region mysqlFunction	 start="ltrim(" end=")" contains=ALL
syn region mysqlFunction	 start="make_set(" end=")" contains=ALL
syn region mysqlFunction	 start="master_pos_wait(" end=")" contains=ALL
syn region mysqlFunction	 start="max(" end=")" contains=ALL
syn region mysqlFunction	 start="md5(" end=")" contains=ALL
syn region mysqlFunction	 start="mid(" end=")" contains=ALL
syn region mysqlFunction	 start="min(" end=")" contains=ALL
syn region mysqlFunction	 start="mod(" end=")" contains=ALL
syn region mysqlFunction	 start="monthname(" end=")" contains=ALL
syn region mysqlFunction	 start="now(" end=")" contains=ALL
syn region mysqlFunction	 start="oct(" end=")" contains=ALL
syn region mysqlFunction	 start="octet_length(" end=")" contains=ALL
syn region mysqlFunction	 start="ord(" end=")" contains=ALL
syn region mysqlFunction	 start="period_add(" end=")" contains=ALL
syn region mysqlFunction	 start="period_diff(" end=")" contains=ALL
syn region mysqlFunction	 start="pi(" end=")" contains=ALL
syn region mysqlFunction	 start="position(" end=")" contains=ALL
syn region mysqlFunction	 start="pow(" end=")" contains=ALL
syn region mysqlFunction	 start="power(" end=")" contains=ALL
syn region mysqlFunction	 start="quarter(" end=")" contains=ALL
syn region mysqlFunction	 start="radians(" end=")" contains=ALL
syn region mysqlFunction	 start="rand(" end=")" contains=ALL
syn region mysqlFunction	 start="release_lock(" end=")" contains=ALL
syn region mysqlFunction	 start="repeat(" end=")" contains=ALL
syn region mysqlFunction	 start="reverse(" end=")" contains=ALL
syn region mysqlFunction	 start="round(" end=")" contains=ALL
syn region mysqlFunction	 start="rpad(" end=")" contains=ALL
syn region mysqlFunction	 start="rtrim(" end=")" contains=ALL
syn region mysqlFunction	 start="sec_to_time(" end=")" contains=ALL
syn region mysqlFunction	 start="session_user(" end=")" contains=ALL
syn region mysqlFunction	 start="sign(" end=")" contains=ALL
syn region mysqlFunction	 start="sin(" end=")" contains=ALL
syn region mysqlFunction	 start="soundex(" end=")" contains=ALL
syn region mysqlFunction	 start="space(" end=")" contains=ALL
syn region mysqlFunction	 start="sqrt(" end=")" contains=ALL
syn region mysqlFunction	 start="std(" end=")" contains=ALL
syn region mysqlFunction	 start="stddev(" end=")" contains=ALL
syn region mysqlFunction	 start="strcmp(" end=")" contains=ALL
syn region mysqlFunction	 start="subdate(" end=")" contains=ALL
syn region mysqlFunction	 start="substring(" end=")" contains=ALL
syn region mysqlFunction	 start="substring_index(" end=")" contains=ALL
syn region mysqlFunction	 start="sum(" end=")" contains=ALL
syn region mysqlFunction	 start="sysdate(" end=")" contains=ALL
syn region mysqlFunction	 start="system_user(" end=")" contains=ALL
syn region mysqlFunction	 start="tan(" end=")" contains=ALL
syn region mysqlFunction	 start="time_format(" end=")" contains=ALL
syn region mysqlFunction	 start="time_to_sec(" end=")" contains=ALL
syn region mysqlFunction	 start="to_days(" end=")" contains=ALL
syn region mysqlFunction	 start="trim(" end=")" contains=ALL
syn region mysqlFunction	 start="ucase(" end=")" contains=ALL
syn region mysqlFunction	 start="unique_users(" end=")" contains=ALL
syn region mysqlFunction	 start="unix_timestamp(" end=")" contains=ALL
syn region mysqlFunction	 start="upper(" end=")" contains=ALL
syn region mysqlFunction	 start="user(" end=")" contains=ALL
syn region mysqlFunction	 start="version(" end=")" contains=ALL
syn region mysqlFunction	 start="week(" end=")" contains=ALL
syn region mysqlFunction	 start="weekday(" end=")" contains=ALL
syn region mysqlFunction	 start="yearweek(" end=")" contains=ALL

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_mysql_syn_inits")
  if version < 508
    let did_mysql_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink mysqlStatement		 Statement
  HiLink mysqlKeyword		 Keyword
  HiLink mysqlSpecial		 Special
  HiLink mysqlString		 String
  HiLink mysqlNumber		 Number
  HiLink mysqlIdentifier	 Identifier
  HiLink mysqlVariable		 Identifier
  HiLink mysqlComment		 Comment
  HiLink mysqlType		 Type
  HiLink mysqlOperator		 Operator
  HiLink mysqlFlow		 Conditional
  HiLink mysqlFunction		 Function

  delcommand HiLink
endif

let b:current_syntax = "mysql"

