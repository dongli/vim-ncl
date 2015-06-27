#!/usr/bin/env ruby -wU

file_path = 'syntax/ncl.vim'
if File.exist? file_path
  print "[Warning]: #{file_path} exists, delete it!\n"
  File.delete file_path
end

syntax_file = File.new file_path, 'w+'

url_prefix = 'http://www.ncl.ucar.edu'

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
  name = category.gsub('-', '').gsub('/', '')
  page1.scan(/^\s*<a href="\/Document\/#{category}\/\w*\.shtml/).each do |x|
    func = x.match(/(\w+)(\.shtml)/)[1]
    syntax_file << "syntax keyword ncl#{name} #{func}\n"
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
    syntax_file << "syntax keyword nclResource #{res}\n"
    resources << res
  end
end

['begin', 'break', 'byte', 'character', 'continue', 'create', 'defaultapp',
 'do', 'double', 'else', 'end', 'enumeric', 'external', 'file', 'float',
 'function', 'getvalues', 'graphic', 'group', 'if', 'integer', 'int64',
 'list', 'load', 'local', 'logical', 'long', 'new', '_missing', 'missing',
 'new', 'noparent', 'numeric', 'procedure', 'quit', 'quit', 'quit', 'record',
 'return', 'setvalues', 'short', 'snumeric', 'stop', 'string', 'then',
 'ubyte', 'uint', 'uint64', 'ulong', 'ushort', 'while'].each do |keyword|
  syntax_file << "syntax keyword nclKeyword #{keyword}\n"
end

["(/", "\/)", "\\\\", "{", "\}", "\.eq\.", "\.ne\.", "\.lt\.", "\.le\.",
 "\.gt\.", "\.ge\.", "\.and\.", "\.or\.", "\.not\.", "\.xor\."].each do |op|
  syntax_file << "syntax match nclOperator \"#{op}\"\n"
end

["\<\\d\\+\\(_\\a\\w*\\)\\=\\>",
 "\\<\\d\\+[deq][-+]\\=\\d\\+\\(_\\a\\w*\\)\\=\\>",
 "\\.\\d\\+\\([deq][-+]\\=\\d\\+\\)\\=\\(_\\a\\w*\\)\\=\\>",
 "\\<\\d\\+\\.\\([deq][-+]\\=\\d\\+\\)\\=\\(_\\a\\w*\\)\\=\\>",
 "\\<\\d\\+\\.\\d\\+\\([dq][-+]\\=\\d\\+\\)\\=\\(_\\a\\w*\\)\\=\\>",
 "\\<\\d\\+\\.\\d\\+\\(e[-+]\\=\\d\\+\\)\\=\\(_\\a\\w*\\)\\=\\>"].each do |num|
  syntax_file << "syntax match nclNumber display \"#{num}\"\n"
end

syntax_file << "syntax match nclBoolean True False\n"
syntax_file << "syntax match nclComment \"^\\ *;.*$\"\n"
syntax_file << "syntax match nclComment \";.*\"\n"
syntax_file << "syntax region nclString start=+\"+ end=+\"+\n"

syntax_file << "highlight link nclFunctionsBuiltin Function\n"
syntax_file << "highlight link nclFunctionsContributed Special\n"
syntax_file << "highlight link nclFunctionsDiagnostics Special\n"
syntax_file << "highlight link nclFunctionsESMF Special\n"
syntax_file << "highlight link nclFunctionsPop_remap Special\n"
syntax_file << "highlight link nclFunctionsSkewt_func Special\n"
syntax_file << "highlight link nclFunctionsUser_contributed Special\n"
syntax_file << "highlight link nclFunctionsWRF_arw\n"
syntax_file << "highlight link nclFunctionsWRF_contributed Special\n"
syntax_file << "highlight link nclFunctionsWind_rose Special\n"
syntax_file << "highlight link nclGraphicsInterfaces Special\n"
syntax_file << "highlight link nclResource Type\n"
syntax_file << "highlight link nclKeyword Keyword\n"
syntax_file << "highlight link nclOperator Operator\n"
syntax_file << "highlight link nclNumber Number\n"
syntax_file << "highlight link nclBoolean Boolean\n"
syntax_file << "highlight link nclComment Comment\n"
syntax_file << "highlight link nclString String\n"

syntax_file << "let b:current_syntax = \"ncl\""
