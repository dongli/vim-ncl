THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/str_get_sq.shtml
THE_TITLE:str_get_sq

str_get_sq

   Returns the single quote (') character as a string.

   [new.gif] Available in version 6.1.0 and later.

Prototype

        function str_get_sq (
        )

        return_val [1] :  string

Description

   This function returns a one-character string containing the single quote (').

   NCL cannot generate a single quote string using normal string assignment. This function gives a quick/direct way to get a
   single quote string.

   The result of str_get_sq() is same as tostring(tochar(39)).

See Also

   show_ascii, str_get_dq, str_get_tab, str_get_nl

Examples

   Example

 sq = str_get_sq()
 print("<" + sq + ">")
 print("sq = <" + tostring(tochar(39)) + ">")

   Output:
(0)     <'>
(0)     sq = <'>


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:12:04 +0800
# vim:set fdm=indent foldlevel=0:
