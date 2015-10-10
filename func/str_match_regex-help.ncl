THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/str_match_regex.shtml
THE_TITLE:str_match_regex

str_match_regex

   Returns a list of strings that contain the given substring (case sensitive), allowing for regular expressions.

   [new.gif] Available in version 6.3.0 and later.

Prototype

        function str_match_regex (
                string_array [*] : string,
                expression   [1] : string
        )

        return_val [*] :  string

Arguments

   string_array

   A string array of any dimensionality.
   expression

   The string expression to be matched, with possible regex ("regular expressions") syntax included.

Description

   This function returns an array of strings with every occurrence of expression matched in string_array. Unlike str_match,
   regular expressions are allowed.

   If there is no expression matched in string_array, the default string missing value ("missing") will be returned.

   Note that str_match_regex is case SENSITIVE. Use str_match_ic_regex if you need case insensitivity.

   A full description of the syntax and capabilities of regular expressions is beyond the scope of this document. See the
   Unix/POSIX man page for REGEX (7) or similar documentation for a complete explanation, noting that NCL's implementation
   uses the "modern" form of regular expressions. In reality only a very small subset of the full functionality will be
   needed for the purposes of this function.

   For those not familiar with the topic one basic point is that unlike the use in a directory listing of the asterisk ('*')
   as a wildcard standing for any number of arbitrary characters, the equivalent operator in a regular expression consists
   of the two character sequence: '.*'.

See Also

   str_match_ic_regex, str_match_ind_regex, str_match_ind_ic_regex, str_index_of_substr, str_sub_str, str_match_ic,
   str_match_ind, str_match_ind_ic

Examples

   Example 1

   Assume you have a mix of date strings with the format "YYYY-MM" or "YYYY-MM-DD" and you want to return only the ones with
   "YYYY-MM-DD".

  dates  = (/"1965-01","1965-01-15","1966-01","1966-01-15","1967-01","1967-01-15"/)

  yyyymm = str_match_regex(dates,"[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]")
  print(yyyymm)

   Output:

(0)     1965-01-15
(1)     1966-01-15
(2)     1967-01-15

   Example 2

   Get all contour resources ending with "Font" from the list of contour resources:

 class_out = NhlGetClassResources("contourPlotClass", "")

 cn_strs = str_match_regex(class_out, "Font$")

 print(cn_strs)

   Output:

(0)     cnConstFLabelFont
(1)     cnHighLabelFont
(2)     cnInfoLabelFont
(3)     cnLineLabelFont
(4)     cnLowLabelFont
(5)     lbLabelFont
(6)     lbTitleFont
(7)     lgLabelFont
(8)     lgLineLabelFont
(9)     lgTitleFont
(10)    tiMainFont
(11)    tiXAxisFont
(12)    tiYAxisFont
(13)    tmXBLabelFont
(14)    tmXTLabelFont
(15)    tmYLLabelFont
(16)    tmYRLabelFont

   Example 3

   To further narrow the list of resources, get all contour resources starting with "cn" and ending with "Font":

 class_out = NhlGetClassResources("contourPlotClass", "")

 cn_strs = str_match_regex(class_out, "^cn.*Font$")

 print(cn_strs)


   Output:

(0)     cnConstFLabelFont
(1)     cnHighLabelFont
(2)     cnInfoLabelFont
(3)     cnLineLabelFont
(4)     cnLowLabelFont

   Note: the NhlGetClassResources function actually allows for regular expressions too, so you really don't need to use
   str_match_regex:
 cn_strs = NhlGetClassResources("contourPlotClass", "^cn.*Font$")


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:12:21 +0800
# vim:set fdm=indent foldlevel=0:
