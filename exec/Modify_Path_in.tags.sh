#!/bin/bash
#==========================================================
# Author: fanghuan - fanghuan_nju@163.com
# Filename: Modify_Path_in.tags.sh
# Creat time: 2016-06-03 23:22:08
# {{{ comment flod start-----------------------
# Description: to change $HOME/.vim ===> $HOME/$vimpath if
# the plugin is not put in default folder ($HOME/.vim), 
# the value of $HOME/$vimpath
# will be set automatically according the path of this shell script
# ***************************
# if this plugin is not in the default vim folder
# please MUST run the shell script to update the path for *_inx.tags
# file in tags for ONCE
# ***************************
# Last modified: 2016-06-03 23:22:08
# }}} comment flod end
#==========================================================
export LC_ALL=C
pwd_path=$(cd $(dirname $BASH_SOURCE) && pwd)
vim_path=${pwd_path%%/bundle/vim-ncl/exec}
vim_path=${vim_path/$HOME/\$HOME}

tags_path="$pwd_path/../tags"
tags_exit=0
# {{{ 
if [[ ! -d "$tags_path" ]];then
    echo "[Warring]: $tags_path dosen't exsit"
    tags_exit=1
else
    export tags_path=$(cd $tags_path && pwd )
fi # }}}
#==================================================================
# {{{  fold start Tags_name
Tags_name=(                  \
    "ncl_func_help_inx.tags" \
    "ncl_res_help_inx.tags"  \
    "ncl_code_std_inx.tags"  \
    "ncl_code_geo_inx.tags"  \
    ) # }}}  fold end

Array_length=${#Tags_name[@]}

for (( index = 0 ; index <=$[Array_length-1];index++));
do
        # condition for Filename_error is yes {{{  fold start 
        Filename=${Tags_name[$[index]]}
        #---------------------------------------------------
        #------For func-help.ncl in ../func/  {{{ 
        if [[ $tags_exit -eq 1 ]];then
            echo "[Warring]: Skiping modify path of *.tags"
        else
            # {{{  tags_exit=0 
            name_tags="$tags_path"/"$Filename"

            if [[ -e "$name_tags" ]];then
                LC_CTYPE=C sed -i "" "/\$HOME\/.vim\//{s#\$HOME/.vim#$vim_path#g;}" $name_tags
                if [[  !  $? -eq 0 ]];then
                    echo "[Warring] : modify path(\$HOME/.vim) in $name_tags Failed"
                fi
            else
                echo "[Warring] : $name_tags dosen't exsit!"
            fi
            # }}}
        fi # }}}
        #---------------------------------------------------
        # }}}  fold end
done
# vim:set fdm=marker foldlevel=0 :
