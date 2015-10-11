THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/csgetp.shtml
THE_TITLE:csgetp

csgetp

   Retrieves control parameters for Cssgrid routines.

Prototype

        function csgetp (
                pnam [1] : string
        )

        return_val [1]

Arguments

   pnam

   Name of the parameter you want to retrieve. Choose one from this list.

Return value

   A value of a type appropriate to the parameter being retrieved.

Description

   The function csgetp retrieves the current value of a named parameter of Cssgrid.

Examples

   .
   .
   .

;
;  Get the value for the tension factor sigma.
;
   value = csgetp("sig")

   .
   .
   .


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:01:08 +0800
# vim:set fdm=indent foldlevel=0:
