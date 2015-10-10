THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/str_match_ind_regex.shtml
THE_TITLE:str_match_ind_regex

str_match_ind_regex

   Returns a list of indexes into an array of strings that contain the given substring (case sensitive), allowing for
   regular expressions.

   [new.gif] Available in version 6.3.0 and later.

Prototype

        function str_match_ind_regex (
                string_array [*] : string,
                expression   [1] : string
        )

        return_val [*] :  integer

Arguments

   string_array

   A string array of any dimensionality.
   expression

   The string expression to be matched, with possible regex ("regular expressions") syntax included.

Description

   This function returns an array of indexes where every occurrence of expression is matched in string_array. The matching
   is case sensitive.

   Unlike str_match_ind, regular expressions are allowed.

   If there is no expression matched in string_array, the default missing value for an integer will be returned.

   Note that str_match_ind_regex is case sensitive. Use str_match_ind_ic_regex if you need case insensitivity.

   A full description of the syntax and capabilities of regular expressions is beyond the scope of this document. See the
   Unix/POSIX man page for REGEX (7) or similar documentation for a complete explanation, noting that NCL's implementation
   uses the "modern" form of regular expressions. In reality only a very small subset of the full functionality will be
   needed for the purposes of this function.

   For those not familiar with the topic one basic point is that unlike the use in a directory listing of the asterisk ('*')
   as a wildcard standing for any number of arbitrary characters, the equivalent operator in a regular expression consists
   of the two character sequence: '.*'.

See Also

   str_match_regex, str_match_ic_regex, str_match_ind_ic_regex, str_match, str_match_ic, str_match_ind_ic,
   str_index_of_substr, str_sub_str

Examples

   Example 1

   Get the indexes of all the strings containing xxLine from the list of strings:

  strings = (/"cnLineColor","mpFillColor","xyLineThicknessF",\
              "txString","polyline"/)
  smatch = str_match_regex(strings,"[a-z][a-z]Line")
  imatch = str_match_ind_regex(strings,"[a-z][a-z]Line")

  print(smatch)
  print(imatch)

   Output:

Variable: smatch
Type: string
Total Size: 16 bytes
            2 values
Number of Dimensions: 1
Dimensions and sizes:   [2]
Coordinates:
(0)     cnLineColor
(1)     xyLineThicknessF

Variable: imatch
Type: integer
Total Size: 8 bytes
            2 values
Number of Dimensions: 1
Dimensions and sizes:   [2]
Coordinates:
(0)     0
(1)     2


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:12:20 +0800
# vim:set fdm=indent foldlevel=0:
