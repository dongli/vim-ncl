#!/usr/bin/env ruby -wU

file_path = '../dict/ncl.dict'
if File.exist? file_path
  print "[Warning]: #{file_path} exists, delete it!\n"
  File.delete file_path
end

dict_file = File.new file_path, 'w+'

url_prefix = 'https://www.ncl.ucar.edu'

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
    func = x.match(/(\w+)(\.shtml)/)[1]
    dict_file << "#{func}\n"
  end
end

print "[Notice]: Grabing graphics resources from NCL website.\n"
page1 = `curl -s #{url_prefix}/Document/Graphics/Resources/list_alpha_res.shtml`

resources = [] # There may be duplicate links in NCL graphics resources webpage.
page1.scan(/^<a name="\w+"><\/a><strong>/).each do |x|
  res = x.match(/"(\w+)"></)[1]
  # Also remove the trailing '_*' stuff.
  res.gsub!(/_\w+/, '')
  if not resources.include? res
    dict_file << "#{res}\n"
    resources << res
  end
end

print "[Notice]: Grabing resource codes from NCL website.\n"
codes = []
page1.scan(/<code>\w+<\/code>/).each do |x|
  code = x.match(/>(\w+)</)[1]
  if not codes.include? code
    dict_file << "#{code}\n"
    codes << code
  end
end

print "[Notice]: Grabing color tables from NCL website.\n"
page1 = `curl -s #{url_prefix}/Document/Graphics/color_table_gallery.shtml`

color_tables = []
page1.scan(/^<td>\w+<br>$/).each do |x|
  color_table = x.match(/>(\w+)</)[1]
  if not color_tables.include? color_table
    dict_file << "#{color_table}\n"
    color_tables << color_table
  end
end
