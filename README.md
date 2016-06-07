# Introduction #

This is another VIM configuation plugin for NCL (NCAR Command Language). It is better to work with [Neocomplete](https://github.com/Shougo/neocomplete.vim)([Neocomplcache](https://github.com/Shougo/neocomplcache.vim)) and [Neosnippet](https://github.com/Shougo/neosnippet.vim).

# Main feature #

This configure is specified for [NCL](http://www.ncl.ucar.edu/) users, which provide:

 - NCL syntax highlight(as discribed in the [official editor enhancement](http://www.ncl.ucar.edu/Applications/editor.shtml) pages)
 -  View the official [**function**](http://www.ncl.ucar.edu/Document/Functions/list_alpha.shtml), [**precedure**](http://www.ncl.ucar.edu/Document/Functions/list_alpha.shtml), [**resource**](http://www.ncl.ucar.edu/Document/Graphics/Resources/list_alpha_res.shtml) manual through tags jump(Shortcut: **g]**)!
 
 - Expand snippets for ncl languages.
 
 - It can work in Uinx-Like System, I test it in mac OS X and Linux.The compatibility in Windows(Gvim) is unkonwn.

# Screen-Shot #

 ![alt total-review][1]

# Installtion #
### Method.1 Vundle ###
If you use [Vundle](https://github.com/gmarik/Vundle.vim) to manager your vim plugins, Please add the **`Plugin 'dongli/vim-ncl'`** in **`~/.vimrc`**, and your **`~/.vimrc`** looks like

```vim
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
" ---> Add you favorate vundle plugins here.
if has('lua')
    Plugin 'Shougo/neocomplete.vim'
else
    Plugin 'Shougo/neocomplcache.vim'
    Plugin 'vim-scripts/AutoComplPop'
endif

Plugin 'ervandew/supertab'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'Shougo/context_filetype.vim'
Plugin 'dongli/vim-ncl'

"" ---> Add you favorate vundle plugins here.
call vundle#end()
filetype plugin on

```
then Install Plugins:

Launch `vim` and run `:PluginInstall`

To install from command line: `vim +PluginInstall +qall`


### Method.2 Git ###
```shell 
git clone https://github.com/Shougo/neocomplete.vim ~/.vim/bundle/neocomplete.vim
git clone https://github.com/Shougo/neocomplcache.vim ~/.vim/bundle/neocomplcache.vim
git clone https://github.com/vim-scripts/AutoComplPop ~/.vim/bundle/AutoComplPop
git clone https://github.com/ervandew/supertab ~/.vim/bundle/supertab
git clone https://github.com/Shougo/neosnippet.vim ~/.vim/bundle/neosnippet.vim
git clone https://github.com/Shougo/neosnippet-snippets ~/.vim/bundle/neosnippet-snippets
git clone https://github.com/Shougo/context_filetype.vim ~/.vim/bundle/context_filetype.vim
git clone https://github.com/dongli/vim-ncl ~/.vim/bundle/vim-ncl
```


### Method.3 Manual ###
 Download all packages listed in Method.2 and unzip it into **`$HOME/.vim/bundle`**. After that, the directory tree is **`$HOME/.vim/bundle/`**
 
|─ `AutoComplPop`

|─ `Vundle.vim`

|─ `context_filetype.vim`

|─`neocomplcache.vim`

|─`neocomplete.vim`

|─ `neosnippet-snippets`

|─ `neosnippet.vim`

|─ `supertab`

|─ `vim-ncl`

# Set ~/.vimrc #

Add those command lines in your **`.vimrc`** when you finished installtion.

```vim
" ###################################################
" Vundle settings.
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle')

Plugin 'gmarik/Vundle.vim'
" ---> Add you favorate vundle plugins here.
if has('lua')
    Plugin 'Shougo/neocomplete.vim' " the plugin need lua feature support
else 
    Plugin 'Shougo/neocomplcache.vim' "if no lua, use neocomplcache.vim instead"
    Plugin 'vim-scripts/AutoComplPop'
endif

Plugin 'ervandew/supertab'
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'Shougo/context_filetype.vim'
Plugin 'dongli/vim-ncl'

call vundle#end()
filetype plugin on

" Good defaults.
set smarttab
set expandtab
set autoindent
set smartindent
set backspace=indent,eol,start
set hlsearch
set number rnu
syntax on

" Jump to last edit location.
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Status bar.
set laststatus=2
set statusline=%F%m\ [type=%Y]\ [line=%l,column=%c,%p%%]

" echofunc 
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {}<ESC>i
":inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap < <><ESC>i
:inoremap > <c-r>=ClosePair('>')<CR>

function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

" use mouse 
if has('mouse') "
    set mouse=a "
    set selection=exclusive
    set selectmode=mouse,key
endif

let g:SuperTabDefaultCompletionType     = "<c-x><c-k>"

if has('lua')
    " NeoComplete settings
    " NeoComplete conflict with AutoComplPop"
    " Disable AutoComplPop.
    let g:acp_enableAtStartup              = 0
    let g:neocomplete#enable_at_startup    = 1
    let g:neocomplete#enable_smart_case    = 1
    let g:neocomplete#enable_cursor_hold_i = 1

    " neosnippet mapping setting "
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()
else
    "NeoComplCache
    let g:NeoComplCache_EnableAtStartup     = 1
    let g:neocomplcache_enable_auto_select  = 0
    let g:acp_enableAtStartup               = 1
    let g:NeoComplCache_DisableAutoComplete = 0
endif

" For conceal markers.neosnippet settings
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    "return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" use ; to expand the snippets, use other key to replace, change the ; to other key,Here is a detail explaination "
imap <expr>; neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: pumvisible() ? "\<C-p>" : "\;"
		 "  \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr>; neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)"
            \: "\<TAB>"
" ###################################################
```
 

# Useage #
#### 1.Complete the key words ####
When typing [NCL functions,precedures](http://www.ncl.ucar.edu/Document/Functions/list_alpha.shtml),[resources](http://www.ncl.ucar.edu/Document/Graphics/Resources/list_alpha_res.shtml),press **`Ctrl + n `** or **`Ctrl + p `** will complete the word. Example: 
	![complete][2]

#### 2.Tags jump ####

 when the cursor is on **`NCL functions(precedures)`** or **`NCL resources`** text, press **`g]`** in **normal model**, the cursor will jump to the document of the functions or resources. If the function (precedure) has more than **one tag**, you need to select it by typing the number of tags. Press **`Ctrl + t`** in **normal model**, the cursor returns to the original file. 
 **Example:**
 
![alt text][3]

  press **`g]`** , then get this 
  
![alt text][4]
  	
  Press **`1`** to enter the first tag file
  	
 ![alt text][5]
 
  Press **`Ctrl + t`** to return the original file
  	
#### 3. Snippets expand ####
Enter a keyword such as **`gsn_csm_y`**, move cursor bebind the keyword, then   press **`;`** to expand the snippets. And **`;`**  can also mv cursor from the **one argeument** to **the next argeument**. In order to expand snippets successfully, ensure there is **`at least a blank before the keyword`**.
  	![alt text][6]

# Authors #

- Li Dong <dongli@lasg.iap.ac.cn>

 [1]: http://ww4.sinaimg.cn/large/9ae304aajw1f4mfwz817zg20gv0a1e81.gif
 [2]: http://ww2.sinaimg.cn/large/9ae304aajw1f4mi0muk92j20ef08n76w.jpg
 [3]: http://ww2.sinaimg.cn/large/9ae304aajw1f4miopeni6j20hz01tdfp.jpg
 [4]: http://ww3.sinaimg.cn/large/9ae304aajw1f4mi0spupyj20kr06ewgv.jpg
 [5]: http://ww1.sinaimg.cn/large/9ae304aajw1f4mip3qavtj20n80drn0l.jpg
 [6]: http://ww1.sinaimg.cn/large/9ae304aajw1f4mgbgak6zg20gv0a1n78.gif
