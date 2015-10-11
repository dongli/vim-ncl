THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/pslhyp.shtml
THE_TITLE:pslhyp

pslhyp

   Computes sea level pressure using the hypsometric equation.

Prototype

        function pslhyp (
                pres  : numeric,
                z     : numeric,
                tv    : numeric
        )

        return_val [dimsizes(pres)] :  numeric

Arguments

   pres

   A multi-dimensional array or scalar value equal to the pressure in Pa. Should correspond to the lowest vertical level.
   Must be at least two dimensions. The rightmost two dimensions must be lat and lon.
   tv

   A multi-dimensional array or scalar value equal to the virtual temperature in K. Must be the same size as pres.
   z

   A multi-dimensional array or scalar value equal to the geopotential height. Must be the same size as pres.

Return value

   A multi-dimensional array of the same size as pres. Double if any of the input arguments is double, float otherwise.
   Contains three attributes, long_name, short_name, and units. You access attributes through the @ operator.
print(return_val@long_name)

Description

   Computes sea level pressure using the hypsometric equation.

See Also

   pslec, pslhor

Examples

   Example 1

   Assume the input arrays are four-dimensional with dimensions time, level, lat, lon, and the 0-index being the lowest
   level.

  PSL = pslhyp(pres(:,0,:,:),z(:,0,:,:),tv(:,0,:,:))
; PSL is dimensioned time, lat, lon.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:10:09 +0800
# vim:set fdm=indent foldlevel=0:
