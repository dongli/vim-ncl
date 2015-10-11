THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/stdMonLLLT.shtml
THE_TITLE:stdMonLLLT

stdMonLLLT

   Calculates standard deviations of monthly means.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function stdMonLLLT (
                x [*][*][*][*] : numeric
        )

        return_val [*][*][*][12] :  typeof(x)

Arguments

   x

   A four-dimensional array of monthly means, dimensioned lev x lat x lon x time. The time dimension must be a multiple of
   12.

Return value

   The results are returned in an array of the same type and dimensionality as x, except the time dimension will be length
   12. If the input data contains metadata, these will be retained.

Description

   This function calculates standard deviations of monthly means.

See Also

   stdMonLLT, stdMonTLL, stdMonLLLT, stdMonTLLL

Examples

   For an application example, see:
     * "hybrid_1.ncl"


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:11 +0800
# vim:set fdm=indent foldlevel=0:
