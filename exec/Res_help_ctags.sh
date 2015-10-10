#!/bin/bash
#==========================================================
# Author: fanghuan - fanghuan_nju@163.com
# Filename: Res_help_ctags.sh
# Creat time: 2015-10-04 13:20:06
# {{{ comment flod start-----------------------
# Description: update the tags for win
# Last modified: 2015-10-04 13:20:06
# }}} comment flod end
#==========================================================
export tags_path=$(cd $PWD/../tags && pwd )
export res_path=$(cd $PWD/../res  && pwd )

if [[ ! -d "$tags_path" ]];then
    echo "[Warring]: $tags_path dosen.t exsit, auto creat it"
    mkdir -p $tags_path
fi

if [[ -z "$tags_name" ]];then
    tags_name="ncl_res_help_inx.tags"
    tags_win_name="ncl_res_help_win.tags"
    tags_name="$tags_path/$tags_name"
    rm -rf $tags_name
    tags_win_name="$tags_path/$tags_win_name"
fi

function_pattern='/^[[:space:]]{3}([a-zA-Z0-9_]+)[[:space:]]?\(?[a-zA-Z0-9_]*\)?$/\1/r,resources/'
#procedure_pattern='/^[[:space:]]+procedure[[:space:]]+([a-zA-Z0-9_]+)[[:space:]]\($/\1/p,procedure/'
ctags  -a --verbose=yes -f $tags_name --langdef=ncl --langmap=ncl:.ncl  \
--regex-ncl=$function_pattern \
`find $res_path -type f \! -path "*UCAS*" -name "*.ncl" 2>/dev/null`
#   --regex-ncl=$procedure_pattern \
sed -i ""  "s#$HOME#\$HOME#g" $tags_name # replace the $HOME path
##for vim in win
#/bin/cp -f $tags_name $tags_win_name
#sed -i "" "s#\$HOME/.vim#\$VIM/vimfiles#g" $tags_win_name
