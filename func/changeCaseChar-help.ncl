THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/changeCaseChar.shtml
THE_TITLE:changeCaseChar

changeCaseChar

   Changes the case of each character in a string. (Deprecated: see str_switch.)

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function changeCaseChar (
                x  : string
        )

        return_val  :  string

Arguments

   x

   A string.

Return value

   A string of the same size as x.

Description

   This function has been deprecated in version 5.1.1; use str_switch instead.

   Changes the case of each character in a string. Treats each one separately and changes it to the opposite case. (e.g.
   apple => APPLE, aPPle => AppLE)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:38 +0800
# vim:set fdm=indent foldlevel=0:
