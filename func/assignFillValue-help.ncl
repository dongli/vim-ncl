THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/assignFillValue.shtml
THE_TITLE:assignFillValue

assignFillValue

   Transfers the _FillValue attribute from one variable to another.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        procedure assignFillValue (
                var_from  : numeric,
                var_to    : numeric
        )

Arguments

   var_from

   A numeric array of any dimensionality. Should contain a _FillValue attribute, otherwise this procedure has no effect.
   var_to

   ( category ="output")
   A numeric array of any dimensionality.

Description

   If var_from has a _FillValue attribute set, then this procedure sets both var_to@_FillValue and var_to@missing_value to
   this value.

See Also

   There are many other metadata tools available for handling metadata.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:24 +0800
# vim:set fdm=indent foldlevel=0:
