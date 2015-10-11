THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/relhum_water.shtml
THE_TITLE:relhum_water

relhum_water

   Calculates relative humidity with respect to water, given temperature, mixing ratio, and pressure.

   [new.gif] Available in version 6.3.1 and later.

Prototype

        function relhum_water (
                t  : numeric,
                w  : numeric,
                p  : numeric
        )

        return_val [dimsizes(t)] :  numeric

Arguments

   t

   A scalar or multi-dimensional array containing the temperature in K.
   w

   A scalar or multi-dimensional array containing the mixing ratio in kg/kg. Must be the same size and shape as t.
   p

   A scalar or multi-dimensional array equal to the pressure in hPa. Must be the same size and shape as t.

Return value

   A multi-dimensional array of the same sizes as t. The output will be double if any of the input is double, and float
   otherwise.

   The return missing value, if any, will be the default missing value for the type being returned.

Description

   Calculates relative humidity with respect to water, given temperature, mixing ratio, and pressure.

See Also

   relhum, relhum_ice, relhum_ttd, dewtemp_trh, mixhum_ptrh

Examples

   Example 1

  p  =  100.            ; hPa
  t  =   18.+273.15     ; C    ==> K
  q  =    6./1000.      ; g/kg ==> kg/kg

  rh = relhum_water (t, q, p)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:10:32 +0800
# vim:set fdm=indent foldlevel=0:
