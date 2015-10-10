THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/wrf_omega.shtml
THE_TITLE:wrf_omega

wrf_omega

   Calculates approximate omega in C, given vertical velocity, water vapor mixing ratio, temperature, and pressure from WRF
   model output.

   [new.gif] Available in version 6.2.0 and later.

Prototype

        function wrf_omega (
                qv  : numeric,
                t   : numeric,
                v   : numeric,
                p   : numeric
        )

        return_val  :  float or double

Arguments

   qv

   Water vapor mixing ratio in [kg/kg]. The rightmost dimensions are bottom_top x south_north x west_east.
   t

   Temperature in [K]. An array with the same dimensionality as qv.
   v

   Vertical velocity in [m/s]. An array with the same dimensionality as qv.
   p

   Pressure in [mb]. An array with the same dimensionality as qv.

Return value

   Approximate omega [dp/dt]. The rightmost three dimensions will be bottom_top x south_north x west_east, and the leftmost
   dimensions, if any, will be the same as qv's. The array will contain the same named dimensions as qv; otherwise, the
   rightmost two dimensions will be named "south_north" and "west_east". The type will be double if any of the input is
   double, and float otherwise.

Description

   This function calculates approximate omega in C, given vertical velocity, water vapor mixing ratio, temperature, and
   pressure from WRF model output.

   You can use wrf_user_getvar with an argument of "omg" to calculate this diagnostic.

   The return variable will contain two attributes:

     return_val@description = "Omega"
     return_val@units = "Pa/s"

   Questions on this function should be sent to wrfhelp@ucar.edu.

See Also

   wrf_virtual_temp, wrf_wetbulb, wrf_user_getvar

   See the full list of WRF functions.

Examples

   Note: for WRF variable names and their definitions, you can easily check them by using "ncl_filedump":
  ncl_filedump wrfout_d01_2000-01-24_12:00:00.nc

   Example 1


   You can see some other example scripts and their resultant images at:

     http://www2.mmm.ucar.edu/wrf/OnLineTutorial/Graphics/NCL/


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:15:51 +0800
# vim:set fdm=indent foldlevel=0:
