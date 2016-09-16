if exists("current_compiler")
    finish
endif
let current_compiler = "promtool"
setlocal makeprg=promtool\ check-rules\ %
setlocal efm=%-PChecking\ %f,%*\\sFAILED:\ parse\ error\ at\ line\ %l\\,\ char\ %c:\ %m,%-G%*\\sSUCCESS:\ %m,%-Q
