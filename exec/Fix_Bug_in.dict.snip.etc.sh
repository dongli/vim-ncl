#!/bin/bash
#==========================================================
# Author: fanghuan - fanghuan_nju@163.com
# Filename: Fix_Bug_in..func-help.ncl..ncl.dict..ncl.vim..ncl.snip-.sh
# Creat time: 2015-03-21 00:11:35
# {{{ comment flod start-----------------------
# Description: Fix some error in ../tags/ncl_func_help_inx.tags 
# of ../func/function-help.ncl
# Last modified: 2015-10-04 17:05:18
# ---------------------------------------------
# Description: Add Fix error in ../syntax/ncl.vim
#                               ../dict/ncl.dict
#                               ../snippet/ncl.snip
# Last modified: 2015-10-05 20:37:39
# ---------------------------------------------
# Description:Add Fix error in ../doc/ncl_list_alpha.ncl
# Last modified: 2015-10-05 20:29:10
# }}} comment flod end
#==========================================================
export LC_ALL=C
func_path="$PWD/../func"
func_exit=0
# {{{ 
if [[ ! -d "$func_path" ]];then
    echo "[Warring]: $func_path dosen't exsit"
    func_exit=1
else
    export func_path=$(cd $func_path && pwd )
fi # }}}
#---------------------------------------------------------------
doc_path="$PWD/../doc"
doc_exit=0
# {{{ 
if [[ ! -d "$doc_path" ]];then
    echo "[Warring]: $doc_path dosen't exsit"
    doc_exit=1
else
    export doc_path=$(cd $doc_path  && pwd )
    doc_file="$doc_path/ncl_list_alpha.ncl"
    if [[ ! -e "$doc_file" ]];then
        echo "[Warring]: $doc_file dosen't exsit"
        doc_exit=1
    fi
fi # }}}
#---------------------------------------------------------------
dict_path="$PWD/../dict"
dict_exit=0
# {{{ 
if [[ ! -d "$dict_path" ]];then
    echo "[Warring]: $dict_path dosen't exsit"
    dict_exit=1
else
    export dict_path=$(cd $dict_path  && pwd )
    dict_file="$dict_path/ncl.dict"
    if [[ ! -e "$dict_file" ]];then
        echo "[Warring]: $dict_file dosen't exsit"
        dict_exit=1
    fi
fi # }}}
#---------------------------------------------------------------
syntax_path="$PWD/../syntax"
syntax_exit=0
# {{{ 
if [[ ! -d "$syntax_path" ]];then
    echo "[Warring]: $syntax_path dosen't exsit"
    syntax_exit=1
else
    export syntax_path=$(cd $syntax_path  && pwd )
    syntax_file="$syntax_path/ncl.vim"
    if [[ ! -e "$syntax_file" ]];then
        echo "[Warring]: $syntax_file dosen't exsit"
        syntax_exit=1
    fi
fi # }}}
#---------------------------------------------------------------
snip_path="$PWD/../snippet"
snip_exit=0
# {{{ 
if [[ ! -d "$snip_path" ]];then
    echo "[Warring]: $snip_path dosen't exsit"
    snip_exit=1
else
    export snip_path=$(cd $snip_path && pwd )
    snip_file="$snip_path/ncl.snip"
    if [[ ! -e "$snip_file" ]];then
        echo "[Warring]: $snip_file dosen't exsit"
        snip_exit=1
    fi
fi # }}}
#==================================================================
# {{{  fold start Func_name_before
Func_name_before=(                \
    "decomposeSymAsym"            \
    "dsgrid3s"                    \
    "dspnt2"                      \
    "dspnt2"                      \
    "dspnt3"                      \
    "dspnt3"                      \
    "eofunc_ts"                   \
    "extract_globalatts_hdf5"     \
    "parse_globalatts_hdf5"       \
    "gsn_add_shapefile_polylines" \
    "gsn_csm_vector_scalar_polar" \
    "stdMonTLL"                   \
    "str_match_ind_ic"            \
    "ushortoint"                  \
    ) # }}}  fold end

# {{{  fold start Func_name_after
Func_name_after=(                     \
    "decompose2SymAsym"               \
    "dsgrid3d"                        \
    "dspnt2d"                         \
    "dspnt2s"                         \
    "dspnt3d"                         \
    "dspnt3s"                         \
    "eofunc_ts_Wrap"                  \
    "extract_filevaratts_hdf5"        \
    "getfilevaratts_hdf5"             \
    "gsn_add_shapefile_polygons"      \
    "gsn_csm_vector_scalar_map_polar" \
    "stdMonTLLL"                      \
    "str_match_ind_ic_regex"          \
    "ushorttoint"                     \
    ) # }}}  fold end

# {{{  fold start Filename_error
Filename_error=( \
    1            \
    0            \
    0            \
    0            \
    0            \
    0            \
    0            \
    1            \
    1            \
    0            \
    0            \
    0            \
    0            \
    0            \
    ) # }}}  fold end

Array_length=${#Func_name_before[@]}

for (( index = 0 ; index <=$[Array_length-1];index++));
do
    FileStatus=${Filename_error[$[index]]}
    if [[ $FileStatus -eq 1 ]];then
        # condition for Filename_error is yes {{{  fold start 
        Filename=${Func_name_before[$[index]]}
        Funcname=${Func_name_after[$[index]]}
        #---------------------------------------------------
        #------For func-help.ncl in ../func/  {{{ 
        if [[ $func_exit -eq 1 ]];then
            echo "[Warring]: Skiping error fix of *func-help.ncl"
        else
            # {{{  func_exit=0 
            name_before="$func_path"/"$Filename"-help.ncl
            name_after="$func_path"/"$Funcname"-help.ncl

            #if [[ ! -e "$name_after" ]] ;then
            #   echo "[Warring] : $name_after dosen't exsit!"

                if [[ -e "$name_before" ]];then
                    /bin/mv $name_before $name_after
                else
                    echo "[Warring] : $name_before dosen't exsit!"
                fi
            #fi

            LC_CTYPE=C sed -i "" "s#$Filename#$Funcname#g" $name_after
            if [[  !  $? -eq 0 ]];then
                echo "[Warring] : Fixed error($Filename) in $name_after Failed"
            fi
            # }}}
        fi # }}}
        #---------------------------------------------------
        #------For ../doc/ncl_list_alpha.ncl  {{{ 
        if [[ $doc_exit -eq 1 ]];then
            echo "[Warring]: Skiping error fix for ../doc/ncl_list_alpha.ncl"
        else
            LC_CTYPE=C sed -i "" "s#$Filename#$Funcname#g" $doc_file
            if [[  !  $? -eq 0 ]];then
                echo "[Warring] : Fixed error($Filename) in $doc_file Failed"
            fi
        fi # }}}
        #---------------------------------------------------
        #------For ../dict/ncl.dict {{{ 
        if [[ $dict_exit -eq 1 ]];then
            echo "[Warring]: Skiping error fix for ../dict/ncl.dict"
        else
            LC_CTYPE=C sed -i "" "s#$Filename#$Funcname#g" $dict_file
            if [[  !  $? -eq 0 ]];then
                echo "[Warring] : Fixed error($Filename) in $dict_file Failed"
            fi
        fi # }}}
        #---------------------------------------------------
        #------For ../syntax/ncl.vim {{{ 
        if [[ $syntax_exit -eq 1 ]];then
            echo "[Warring]: Skiping error fix for ../syntax/ncl.vim"
        else
            LC_CTYPE=C sed -i "" "s#$Filename#$Funcname#g" $syntax_file
            if [[  !  $? -eq 0 ]];then
                echo "[Warring] : Fixed error($Filename) in $syntax_file Failed"
            fi
        fi # }}}
        #---------------------------------------------------
        #------For ../snippet/ncl.snip{{{ 
        if [[ $snip_exit -eq 1 ]];then
            echo "[Warring]: Skiping error fix for ../snippet/ncl.snip"
        else
            LC_CTYPE=C sed -i "" "s#$Filename#$Funcname#g" $snip_file
            if [[  !  $? -eq 0 ]];then
                echo "[Warring] : Fixed error($Filename) in $snip_file Failed"
            fi
        fi # }}}
        # }}}  fold end
    elif [[ $FileStatus -eq 0 ]];then
        # condition for Filename_error is no {{{  fold start 
        #---------------------------------------------------
        #------For func-help.ncl in ../func/  {{{ 
        if [[ $func_exit -eq 1 ]];then
            echo "[Warring]: Skiping error fix of *func-help.ncl"
        else
            Filename=${Func_name_after[$[index]]}
            Funcname=${Func_name_before[$[index]]}
            name_after="$func_path"/"$Filename"-help.ncl

            LC_CTYPE=C sed -i "" "s#$Funcname (#$Filename (#g" $name_after
            if [[  !  $? -eq 0 ]];then
                echo "[Warring] : Fixed error($Funcname) in $name_after Failed"
            fi
        fi # }}}
        # }}}  fold end 
    fi
done
# vim:set fdm=marker foldlevel=0 :
