THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/str_get_nl.shtml
THE_TITLE:str_get_nl

str_get_nl

   Returns the newline (\n) character as a string.

   [new.gif] Available in version 5.1.1 and later.

Prototype

        function str_get_nl (
        )

        return_val [1] :  string

Description

   This function returns a one-character string containing a newline (\n).

   NCL cannot generate a newline string using normal string assignment. This function gives a quick/direct way to get a
   newline.

See Also

   str_get_dq

Examples

   Example

 nl = str_get_nl()
 print("<" + nl + ">")

   Output:
(0)     <
>


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:12:02 +0800
# vim:set fdm=indent foldlevel=0:
