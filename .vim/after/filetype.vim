" Just in case nothing else matched
augroup filetypedetect
  au BufNewFile,BufRead *rc	setf cfg
  au BufRead,BufNewFile *
	\ if !did_filetype() && expand("<amatch>") !~ g:ft_ignore_pat |
	\   if getline(1) =~ 'wrote:' || getline(3) =~ 'wrote:' |
	\     setf mail |
	\   elseif getline(1) =~ '^DOCTYPE' || getline(1) =~ 'HTML' |
	\     setf html |
	\   elseif getline(1) =~ '<VirtualHost' |
	\     setf apache |
	\   else |
	\     setf text |
	\   endif |
	\ endif
augroup END
