THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/str_concat.shtml
THE_TITLE:str_concat

str_concat

   Concatenates all strings into a single string.

   [new.gif] Available in version 5.1.1 and later.

Prototype

        function str_concat (
                string_val  : string
        )

        return_val [1] :  string

Arguments

   string_val

   A string array of any dimensionality.

Description

   This function concatenates all the input strings into a single string.

   If any of the strings are missing, then the missing value string will be included in the concatenation. It's up to the
   user to remove missing strings if this behavior is not desired (see example below).

See Also

   str_join, oneDtostring

Examples

   Example 1

  strs = (/"NCL","has","many","features","common","to","modern","programming","languages."/)
  new_str = str_concat(strs)
  print(new_str)

   Output

(0)     NCLhasmanyfeaturescommontomodernprogramminglanguages.

   Example 2

   See what happens when you have missing value strings:
  strs = (/"NCL","has","many","features","missing","common","to", \
           "missing","modern","programming","languages.","missing"/)
  strs@_FillValue = "missing"

  new_str = str_concat(strs)
  print(new_str)

   Output

(0)     NCLhasmanyfeaturesmissingcommontomissingmodernprogramminglanguages.missing

   If this behavior is not desired, then replace the missing strings with "":
  strs = where(ismissing(strs),"",strs)
  new_str = str_concat(strs)
  print(new_str)

   Output

(0)     NCLhasmanyfeaturescommontomodernprogramminglanguages.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:11:56 +0800
# vim:set fdm=indent foldlevel=0:
