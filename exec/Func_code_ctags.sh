#!/bin/bash
#==========================================================
# Author: fanghuan - fanghuan_nju@163.com
# Filename: Func_code_ctags.sh
# Creat time: 2015-10-04 14:09:59
# {{{ comment flod start-----------------------
# Description: Update function tags for win
# Last modified: 2015-10-04 14:09:59
# ---------------------------------------------
# Description: generate tags file for ncl file in $NCARG_ROOT and $GEODIAG_ROOT
# Last modified: 2016-06-04 00:10:09
# ---------------------------------------------
# Description: use a new method to get the shell location 
# Last modified: 2016-06-03 23:54:03
# }}} comment flod end
#==========================================================
pwd_path=$(cd $(dirname $BASH_SOURCE) && pwd)
export tags_path=$(cd $pwd_path/../tags && pwd )
#----------------------------------------------------------
export code_path=${NCARG_ROOT}

if [[ ! -d "$tags_path" ]];then
    echo "[Warring]: $tags_path dosen.t exsit, auto creat it"
    mkdir -p $tags_path
fi

tags_name="ncl_code_std_inx.tags"
tags_win_name="ncl_code_std_win.tags"
tags_name="$tags_path/$tags_name"
rm -rf $tags_name
tags_win_name="$tags_path/$tags_win_name"

function_pattern='/^[[:space:]]*function[[:space:]]+([a-zA-Z0-9_]+)[:blank:]*.*/\1/f,function/'
procedure_pattern='/^[[:space:]]*procedure[[:space:]]+([a-zA-Z0-9_]+)[:blank:]*.*/\1/p,procedure/'
ctags -a --verbose=yes  -f $tags_name --langdef=ncl --langmap=ncl:.ncl  \
--regex-ncl=$function_pattern  --regex-ncl=$procedure_pattern \
`find -L $code_path -type f -name "*.ncl" 2>/dev/null`

sed -i ""  "s#${NCARG_ROOT}#\$NCARG_ROOT#g" $tags_name # replace the $HOME path
#----------------------------------------------------------
export code_path=${GEODIAG_ROOT}

tags_name="ncl_code_geo_inx.tags"
tags_win_name="ncl_code_geo_win.tags"
tags_name="$tags_path/$tags_name"
rm -rf $tags_name
tags_win_name="$tags_path/$tags_win_name"

ctags -a --verbose=yes  -f $tags_name --langdef=ncl --langmap=ncl:.ncl  \
--regex-ncl=$function_pattern  --regex-ncl=$procedure_pattern \
`find -L $code_path -type f -name "*.ncl" 2>/dev/null`

sed -i ""  "s#${GEODIAG_ROOT}#\$GEODIAG_ROOT#g" $tags_name # replace the $HOME path

##for vim in win
#/bin/cp -f $tags_name $tags_win_name
#sed -i "" "s#\$HOME/.vim#\$VIM/vimfiles#g" $tags_win_name
