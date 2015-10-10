THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/calcMonAnomTLLL.shtml
THE_TITLE:calcMonAnomTLLL

calcMonAnomTLLL

   Calculates monthly anomalies by subtracting the long term mean from each point: (time,lev,lat,lon) version.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function calcMonAnomTLLL (
                x     [*][*][*][*] : float or double,
                xAve [12][*][*][*] : numeric
        )

        return_val [dimsizes(x)] :  numeric

Arguments

   x

   A four-dimensional array of type float or double. Dimensions must be time,lev,lat,lon The time dimension must be a
   multiple of 12.
   xAve

   A four-dimensional array equal to the monthly averages of x. The leftmost dimension must be of size 12. the three
   rightmost dimensions must matc the rightmost dimensions of x.

Return value

   An array of the same size and type as x.

Description

   Calculates climatological anomalies by subtracting the long term mean from each point. Assumes monthly data. If the input
   data contains metadata (e.g. coordinate variables and attributes), these will be retained.

See Also

   calcMonAnomTLL, calcMonAnomLLLT, calcMonAnomLLT, clmMonLLT, clmMonLLLT, clmMonTLL, clmMonTLLL

Examples

   No examples are currently available for this function. See the example for the similar function calcMonAnomTLL.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:33 +0800
# vim:set fdm=indent foldlevel=0:
