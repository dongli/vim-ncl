autocmd Bufread,BufNewfile *.ncl set dictionary=$HOME/.vim/bundle/vim-ncl/dict/ncl.dic
autocmd Bufread,BufNewfile *.ncl set tags+=$HOME/.vim/bundle/vim-ncl/tags/ncl_func_help_inx.tags
autocmd Bufread,BufNewfile *.ncl set tags+=$HOME/.vim/bundle/vim-ncl/tags/ncl_res_help_inx.tags
let g:neosnippet#snippets_directory = "~/.vim/bundle/vim-ncl/snippet"

set tabstop=2
set softtabstop=2
set shiftwidth=2
