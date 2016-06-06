if exists("b:did_ftplugin_ncl")
    finish
endif
let b:did_ftplugin_ncl = 1

" Add ncl dict for function,res,and res default value

if exists("b:loaded_ncl")
    finish
endif
let b:loaded_ncl = 1

setlocal tags=ncludef.tags tags+=./ncludef.tags
let s:path=resolve(expand('<sfile>:p:h'))
execute "setlocal dictionary=".s:path."/../dict/ncl.dict"
execute "setlocal tags+=".s:path."/../tags/ncl_func_help_inx.tags"
execute "setlocal tags+=".s:path."/../tags/ncl_res_help_inx.tags"
execute "setlocal tags+=".s:path."/../tags/ncl_code_std_inx.tags"
execute "setlocal tags+=".s:path."/../tags/ncl_code_geo_inx.tags"

let g:neosnippet#snippets_directory = s:path."/../snippet"

"show autocomplete menus.
setlocal complete-=k complete+=k
setlocal wildmode=list:full
"增强模式中的命令行自动完成操作
setlocal wildmenu

execute "au! Syntax newlang source ".s:path."/../syntax/ncl.vim"

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
