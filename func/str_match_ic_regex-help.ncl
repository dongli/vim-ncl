THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/str_match_ic_regex.shtml
THE_TITLE:str_match_ic_regex

str_match_ic_regex

   Returns a list of strings that contain the given substring (case insensitive), allowing for regular expressions.

   [new.gif] Available in version 6.3.0 and later.

Prototype

        function str_match_ic_regex (
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

   This function returns an array of strings with every occurrence of expression matched in string_array. Unlike
   str_match_ic, regular expressions are allowed.

   If there is no expression matched in string_array, the default string missing value ("missing") will be returned.

   Note that str_match_ic_regex is case INSENSITIVE. Use str_match_regex if you need case sensitivity.

   A full description of the syntax and capabilities of regular expressions is beyond the scope of this document. See the
   Unix/POSIX man page for REGEX (7) or similar documentation for a complete explanation, noting that NCL's implementation
   uses the "modern" form of regular expressions. In reality only a very small subset of the full functionality will be
   needed for the purposes of this function.

   For those not familiar with the topic one basic point is that unlike the use in a directory listing of the asterisk ('*')
   as a wildcard standing for any number of arbitrary characters, the equivalent operator in a regular expression consists
   of the two character sequence: '.*'.

See Also

   str_match_regex, str_match_ind_ic_regex, str_match_ind_regex, str_index_of_substr, str_sub_str, str_match, str_match_ic,
   str_match_ind, str_match_ind_ic

Examples

   Example 1

   Assume you have a mix of abbreviated month names with the form "mmm" and "MMM", and you want to return all occurrences of
   "jan" and "JAN"

  months  = (/"jan","feb","MAR","JAN","FEB","MAR","jan","feb","mar"/)

  jan_ic = str_match_ic_regex(months,"jan")   ; (/"jan","JAN","jan"/)

  jan_sc = str_match_regex(months,"jan")      ; (/"jan","jan"/)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:12:15 +0800
# vim:set fdm=indent foldlevel=0:
