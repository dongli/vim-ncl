"=============================================================================
" FILE: ncl.vim
" AUTHOR:  Li Dong <dongli.init at gmail.com>
" License: MIT license
"=============================================================================

let root = expand('<sfile>:p:h:h')
execute 'set complete+=k'.root.'/dict/*'
let g:neosnippet#enable_snipmate_compatibility=1
let g:neosnippet#snippets_directory=root.'/snippets'

set tabstop=2
set softtabstop=2
set shiftwidth=2
