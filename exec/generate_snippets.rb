#!/usr/bin/env ruby -wU

def snippet title, abbr, content
  <<-EOT
snippet #{title}
abbr #{abbr}

  EOT
end

file_path = '../snippet/ncl.snip'
if File.exist? file_path
  print "[Warning]: #{file_path} exists, delete it!\n"
  File.delete file_path
end

snip_file = File.new file_path, 'w+'

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
    puts "[Notice]: Generating completion for #{func}."
    func_url = "#{url_prefix}#{x.match(/<a href="(.*)/)[1]}"
    page2 = `curl -s #{func_url}`
    begin
      prototype = page2.match(/(function|procedure) \w+ \(([^\)]*)\)$/m)[2].strip
    rescue
      print page2.match(/(function|procedure) \w+ \(([^\)]*)\)$/m)[0]+"\n"
      print "[Error]: Failed to extract prototype for #{func}!\n"
      exit
    end
    snip_file << "snippet #{func}\n"
    snip_file << "  #{func}("
    i = 1
    prototype.each_line do |line|
      arg = line.split(' ')[0].strip
      snip_file << "${#{i}:#{arg}}"
      snip_file << ', ' if i != prototype.lines.count
      i += 1
    end
    snip_file << ")\n\n"
  end
end


