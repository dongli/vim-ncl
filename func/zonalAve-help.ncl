THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/zonalAve.shtml
THE_TITLE:zonalAve

zonalAve

   Computes a zonal average of the input array.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function zonalAve (
                x  : numeric
        )

        return_val  :  typeof(x)

Arguments

   x

   An array of any size and type.

Return value

   The results are returned in an array of the same type and one dimension smaller than x. Metadata are preserved.

Description

   This function computes a zonal average of the input array x. If the input array has a "long_name" or "short_name"
   attribute, it will be updated.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:55 +0800
# vim:set fdm=indent foldlevel=0:
