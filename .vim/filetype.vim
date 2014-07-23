" Avoid autocommand duplication
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  " Unfortunately capitalized short names
  au BufNewFile,BufRead *.CPP			setf cpp
  au BufNewFile,BufRead *.H			setf cpp
  " Wiki Back-Naur Formulae
  au BufNewFile,BufRead *.bnf			setf bnf
  " Wiki buffers
  au BufNewFile,BufRead *.wiki			setf wiki
  " Wierd Up source files
  au BufNewFile,BufRead *.wup			setf wierd
  " PyDip map
  au BufNewFile,BufRead *.tty			setf pymap
  " Dvorak Deck Description
  au BufRead,BufNewFile *.ddd			setf dvorak
  " Zillions Rules File
  au BufRead,BufNewFile *.zrf			setf zrf
  " Lilypond Music Notation
  au BufRead,BufNewFile *.ly			setf lilypond
  " CakePHP template files
  au BufRead,BufNewFile *.thtml,*.ctp		setf php
  " Flash source files
  au BufRead,BufNewFile *.as,*.mxml		setf actionscript
  " Log files
  au BufRead,BufNewFile *.log			setf log
  " Example files
  au BufRead,BufNewFile ?\+.example		exe "doau filetypedetect BufRead " . expand("<afile>:r")
  " Web Proxy Auto-Detect
  au BufNewFile,BufRead *wpad.dat		setf javascript
augroup END
