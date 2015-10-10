THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/str_match_ic.shtml
THE_TITLE:str_match_ic

str_match_ic

   Returns a list of strings that contain the given substring (case insensitive).

   [new.gif] Available in version 6.0.0 and later.

Prototype

        function str_match_ic (
                string_array [*] : string,
                sub_string   [1] : string
        )

        return_val [*] :  string

Arguments

   string_array

   A string array of any dimensionality.
   sub_string

   The substring to be matched.

Description

   This function returns an array of strings with every occurrence of sub_string matched in string_array.

   If there is no sub_string matched in string_array, the default string missing value ("missing") will be returned.

   Note that str_match_ic is case INSENSITIVE. Use str_match if you need case sensitivity.

See Also

   str_index_of_substr, str_sub_str, str_match, str_match_regex, str_match_ic_regex, str_match_ind_regex,
   str_match_ind_ic_regex, str_match_ind, str_match_ind_ic

Examples

   Example 1

 s = (/"Linux","LINUX","linux"/)

 dq = str_get_dq()

 print("str_match(s," + dq + "linux" + dq + ") = " + str_match(s,"linux"))

;print out:
;(0)     str_match(s,"linux") = linux

 print("str_match_ic(s," + dq + "linux" + dq + ") = " + str_match_ic(s,"linux"))

;print out:
;(0)     str_match_ic(s,"linux") = Linux
;(1)     str_match_ic(s,"linux") = LINUX
;(2)     str_match_ic(s,"linux") = linux


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:12:14 +0800
# vim:set fdm=indent foldlevel=0:
