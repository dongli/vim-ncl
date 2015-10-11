#!/usr/bin/env ruby -wU
#==========================================================
# Author: fanghuan - fanghuan_nju@163.com
# Filename: generate_func-and-res_help-online.rb
# Creat time: 2015-10-04 20:45:05
# {{{ comment flod start-----------------------
# Description: generate ncl files for function and resources 
# for https://www.ncl.ucar.edu
# Last modified: 2015-10-04 20:45:05
# }}} comment flod end
#==========================================================
def recreat_file(file_path)
  if File.exist? file_path
    print "[Warning]: #{file_path} exists, update it!\n"
  end

  file_name = File.new file_path, 'w+'
  return file_name
end

def del_text(file_path,line_num=113)
  end_line_del =line_num.to_s
  `sed -i "" "3,#{end_line_del}  d" #{file_path}`
   sed_flag=$?.to_i
   if sed_flag ==0 then
     print "[Notice]: Generating plain text document for #{file_path}\n"
   end
end

def shtml2text(url_dl,dl_file_path)
  `lynx -dump -crawl -width=130 #{url_dl} 2>/dev/null > #{dl_file_path}`
  lynx_flag=$?.to_i
  if lynx_flag == 0 then
    #puts "[Done] Converted html to plain text with lynx\n"

    line_num  = `grep -n "NCL Home" #{dl_file_path} 2>/dev/null |awk -F : '{print $1}' `
    line_num  = line_num.to_i

    if line_num == 0 then
      del_text(dl_file_path)
    else
      del_text(dl_file_path,line_num)
    end

    open(dl_file_path,'a'){|res_file|
      res_file << Time.new.inspect+"\n"
      res_file << "# vim:set fdm=indent foldlevel=0:\n"
    }
  end
end

url_prefix = 'https://www.ncl.ucar.edu'

#print "[Notice]: Grabing function simple list from NCL website.\n"
#url_dl_func_list="#{url_prefix}/Document/Functions/list_alpha.shtml"
#
#func_path = "../doc/ncl_list_alpha.ncl"
#
#recreat_file(func_path)
#shtml2text(url_dl_func_list,func_path)
#--------------------------------------------------------------------
print "[Notice]: Grabing function definitions from NCL website.\n"
page1 = `curl -s #{url_prefix}/Document/Functions/list_alpha.shtml`

categories = [
  'Functions/Built-in',
  'Functions/Contributed',
  'Functions/Diagnostics',
  'Functions/ESMF',
  'Functions/Pop_remap',
  'Functions/Skewt_func',
  'Functions/User_contributed',
  'Functions/WRF_arw',
  'Functions/WRF_contributed',
  'Functions/Wind_rose',
  'Graphics/Interfaces'
]
categories.each do |category|
  page1.scan(/^\s*<a href="\/Document\/#{category}\/\w*\.shtml/).each do |x|
    func = x.match(/(\w+)(\.shtml)/)[1] # get the name of function

    func_path   = "../func/#{func}-help.ncl"
    url_dl_func = url_prefix+"/Document/"+category+"/"+func+".shtml"

    recreat_file(func_path)

    shtml2text(url_dl_func,func_path)
    #`lynx -dump -crawl -width=130 #{url_prefix}/Document/#{category}/#{func}.shtml 2>/dev/null > #{func_path}`
  end
end

print "[Notice]: Grabing graphics resources from NCL website.\n"
res_path = "../res/Res_help_list.ncl"
url_dl_res=url_prefix+"/Document/Graphics/Resources/list_alpha_res.shtml"

shtml2text(url_dl_res,res_path)
# vim:set fdm=indent foldlevel=0:
