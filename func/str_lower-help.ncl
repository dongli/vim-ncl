THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/str_lower.shtml
THE_TITLE:str_lower

str_lower

   Converts all input strings to lowercase.

   [new.gif] Available in version 5.1.1 and later.

Prototype

        function str_lower (
                string_val  : string
        )

        return_val [dimsizes(string_val)] :  string

Arguments

   string_val

   A string array of any dimensionality.

Description

   This function converts all the characters in string_val to lowercase.

See Also

   str_upper, str_switch, str_capital

Examples

   Example

 str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ_......_ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 new_string = str_lower(str)
 print(new_string)      ; new_string = "abcdefghijklmnopqrstuvwxyz_......_abcdefghijklmnopqrstuvwxyz"

   Output:
(0)     <abcdefghijklmnopqrstuvwxyz_......_abcdefghijklmnopqrstuvwxyz>


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:12:11 +0800
# vim:set fdm=indent foldlevel=0:
