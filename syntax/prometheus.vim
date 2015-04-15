" See http://prometheus.io/docs/querying/rules/#alerting-rules
if exists("b:current_syntax")
	finish
endif

" Keywords
syn keyword prometheusKeywords ALERT IF FOR WITH SUMMARY DESCRIPTION

" Strings
syn region prometheusString start=/"/ skip=/\\"/ end=/"/

" Comments
syn region prometheusComment start="//" end="\n"

" Variable/expressions
syn region prometheusVars start=/{{-\?/ end=/-\?}}/ containedin=ALLBUT,prometheusComment


" Highlighting
hi link prometheusKeywords  Keyword
hi link prometheusString    String
hi link prometheusComment   Comment
hi link prometheusVars      PreProc
"
let b:current_syntax = "prometheus"
"
set commentstring=//\ %s
