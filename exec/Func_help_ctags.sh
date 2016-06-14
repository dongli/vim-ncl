#!/bin/bash
#==========================================================
# Author: fanghuan - fanghuan_nju@163.com
# Filename: Func_help_ctags.sh
# Creat time: 2015-10-04 14:09:59
# {{{ comment flod start-----------------------
# Description: Update function tags for win
# Last modified: 2015-10-04 14:09:59
# ---------------------------------------------
# Description: use a new method to get the shell location 
# Last modified: 2016-06-03 23:54:03
# }}} comment flod end
#==========================================================
pwd_path=$(cd $(dirname $BASH_SOURCE) && pwd)
export tags_path=$(cd $pwd_path/../tags && pwd )
export func_path=$(cd $pwd_path/../func  && pwd )

if [[ ! -d "$tags_path" ]];then
    echo "[Warring]: $tags_path dosen.t exsit, auto creat it"
    mkdir -p $tags_path
fi

if [[ -z "$tags_name" ]];then
    tags_name="ncl_func_help_inx.tags"
    tags_win_name="ncl_func_help_win.tags"
    tags_name="$tags_path/$tags_name"
    rm -rf $tags_name
    tags_win_name="$tags_path/$tags_win_name"
fi

function_pattern='/^[[:space:]]+function[[:space:]]+([a-zA-Z0-9_]+)[[:space:]]\($/\1/f,function/'
procedure_pattern='/^[[:space:]]+procedure[[:space:]]+([a-zA-Z0-9_]+)[[:space:]]\($/\1/p,procedure/'
ctags  -a --verbose=yes  -f $tags_name --langdef=ncl --langmap=ncl:.ncl  \
--regex-ncl=$function_pattern  --regex-ncl=$procedure_pattern \
`find -L $func_path -type f -name "*.ncl" 2>/dev/null`

sed -i ""  "s#$HOME#\$HOME#g" $tags_name # replace the $HOME path
##for vim in win
#/bin/cp -f $tags_name $tags_win_name
#sed -i "" "s#\$HOME/.vim#\$VIM/vimfiles#g" $tags_win_name
