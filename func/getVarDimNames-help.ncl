THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/getVarDimNames.shtml
THE_TITLE:getVarDimNames

getVarDimNames

   Retrieves dimension names for a variable in memory (deprecated version).

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        procedure getVarDimNames (
                x  : numeric
        )

        return_val [*] :  string

Arguments

   x

   An numeric array of any dimensionality.

Description

   Retrieves dimension names for a variable in memory just as getfilevardims does for file variables.
   Deprecated, please use getvardims.

See Also

   Deprecated, please use getvardims.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:18:20 +0800
# vim:set fdm=indent foldlevel=0:
