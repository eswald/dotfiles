if b:current_syntax == "python"
  syn keyword pythonTodo	Todo
  syn keyword pythonException	PendingDeprecationWarning UnicodeDecodeError
  syn keyword pythonException	UnicodeEncodeError UnicodeTranslateError
  syn keyword pythonBuiltin	basestring bool enumerate frozenset
  syn keyword pythonBuiltin	reversed set sorted sum
  syn keyword pythonBoolean	True False None
  hi def link pythonBoolean	Boolean
endif
