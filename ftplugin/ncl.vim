let s:path=resolve(expand('<sfile>:p:h'))
execute "setlocal dictionary=".s:path."/../dict/ncl.dict"
execute "setlocal tags+=".s:path."/../tags/ncl_func_help_inx.tags"
execute "setlocal tags+=".s:path."/../tags/ncl_res_help_inx.tags"
execute "setlocal tags+=".s:path."/../tags/ncl_code_std_inx.tags"
execute "setlocal tags+=".s:path."/../tags/ncl_code_geo_inx.tags"

let g:neosnippet#snippets_directory = s:path."/../snippet"

setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
