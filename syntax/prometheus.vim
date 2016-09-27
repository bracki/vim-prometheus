" See http://prometheus.io/docs/querying/rules/#alerting-rules
if exists("b:current_syntax")
	finish
endif

syn case ignore
" Strings
syn region promString start=/"/ skip=/\\"/ end=/"/
syn region promString start=/'/ skip=/\\'/ end=/'/

" Comments
syn region promComment start="//" end="\n"
syn region promComment start="#" end="\n"

" Variable/expressions
syn match promIdentifier "[a-zA-Z][a-zA-Z0-9_:]\+" containedin=ALLBUT,promComment,promVars
syn region promLabelList start=/(/ end=/)/ contained
syn region promqlSelector start=/{[^{]/ end=/[^}]}/ containedin=ALLBUT,promComment,promVars

syn region promVars start=/{{-\?/ end=/-\?}}/ containedin=promString

" Literals
syn match promFloat '[-+]\?\d\+\.\d*'
syn match promFloat '[-+]\?\d\+'
syn match promDuration '\d\+[smh]'

" Keywords
syn keyword promAlertKeywords ALERT IF FOR LABELS ANNOTATIONS

" PromQL Keywords
syn keyword promqlFunc scalar vector absent
syn keyword promqlFunc sort sort_desc
syn keyword promqlFunc drop_common_labels label_replace
syn keyword promqlFunc histogram_quantile
syn keyword promqlFunc clamp_min clamp_max
syn keyword promqlFunc exp sqrt ln log2 log10
syn keyword promqlFunc abs round floor ceil
syn keyword promqlFunc rate irate delta idelta deriv increase changes resets
syn keyword promqlFunc holt_winters predict_linear
syn keyword promqlFunc time hour day_of_week day_of_month days_in_month month
syn keyword promqlFunc stddev_over_time quantile_over_time max_over_time sum_over_time min_over_time avg_over_time count_over_time stdvar_over_time

syn keyword promqlMods offset bool
syn keyword promqlMods group_left group_right nextgroup=promLabelList skipwhite

syn keyword promqlCond and or unless

syn match promqlAssign "\v\="

syn match promqlCond "\v\=\=" skipwhite nextgroup=promqlBinaryRestrict
syn match promqlCond "\v!\=" skipwhite nextgroup=promqlBinaryRestrict
syn match promqlCond "\v\>" skipwhite nextgroup=promqlBinaryRestrict
syn match promqlCond "\v\<" skipwhite nextgroup=promqlBinaryRestrict
syn match promqlCond "\v\>\=" skipwhite nextgroup=promqlBinaryRestrict
syn match promqlCond "\v\<\=" skipwhite nextgroup=promqlBinaryRestrict

syn match promqlOp "\v\+" skipwhite nextgroup=promqlBinaryRestrict
syn match promqlOp "\v-" skipwhite nextgroup=promqlBinaryRestrict
syn match promqlOp "\v\*" skipwhite nextgroup=promqlBinaryRestrict
syn match promqlOp "\v/" skipwhite nextgroup=promqlBinaryRestrict
syn match promqlOp "\v\%" skipwhite nextgroup=promqlBinaryRestrict
syn match promqlOp "\v\^" skipwhite nextgroup=promqlBinaryRestrict

syn keyword promqlBinaryRestrict ignoring on skipwhite contained nextgroup=promLabelList

syn keyword promqlAgg sum min max avg stddev stdvar count count_values bottomk topk quantile skipwhite nextgroup=promqlAggArgs
syn region  promqlAggArgs start=/(/ end=/)/ skipwhite contained nextgroup=promqlRestrict
syn keyword promqlRestrict by without nextgroup=promLabelList skipwhite contained nextgroup=promqlLabelList

" Highlighting
hi link promString           String
hi link promComment          Comment
hi link promIdentifier       Identifier
hi link promFloat            Constant
hi link promDuration         Constant
hi link promVars             PreProc
hi link promAlertKeywords    Keyword
hi link promqlSelector       PreProc
hi link promqlFunc           Function
hi link promqlMods           Operator
hi link promqlAgg            Repeat
hi link promqlAssign         Operator
hi link promqlOp             Operator
hi link promqlLabelList      PreProc
hi link promqlCond           Conditional
hi link promqlRestrict       Conditional
hi link promqlBinaryRestrict Conditional
"
let b:current_syntax = "prometheus"
"
set commentstring=//\ %s
