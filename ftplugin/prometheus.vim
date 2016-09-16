compiler promtool

if !exists('g:prometheus_check_rules_on_save') || g:prometheus_check_rules_on_save
  au BufWritePost * make
endif

