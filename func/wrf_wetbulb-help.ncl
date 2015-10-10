THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/wrf_wetbulb.shtml
THE_TITLE:wrf_wetbulb

wrf_wetbulb

   Calculates wet bulb temperature in K, given pressure in temperature in K and mixing ratio in kg/kg from WRF model output.

   [new.gif] Available in version 6.2.0 and later.

Prototype

        function wrf_wetbulb (
                p   : numeric,
                t   : numeric,
                qv  : numeric
        )

        return_val  :  float or double

Arguments

   p

   Pressure in [mb]. The rightmost dimensions are bottom_top x south_north x west_east.
   t

   Temperature in [K]. An array with the same dimensionality as p.
   qv

   Water vapor mixing ratio in [kg/kg]. An array with the same dimensionality as p.

Return value

   Wet bulb temperature in [K]. The rightmost three dimensions will be bottom_top x south_north x west_east, and the
   leftmost dimensions, if any, will be the same as p's. The array will contain the same named dimensions as p; otherwise,
   the rightmost two dimensions will be named "south_north" and "west_east". The type will be double if any of the input is
   double, and float otherwise.

Description

   This function returns wet bulb temperature in K, given pressure in temperature in K and mixing ratio in kg/kg from WRF
   model output.

   You can use wrf_user_getvar with an argument of "tw" to calculate this diagnostic.

   The return variable will contain two attributes:

     return_val@description = "Wet Bulb Temperature"
     return_val@units = "K"

   Questions on this function should be sent to wrfhelp@ucar.edu.

See Also

   wrf_omega, wrf_virtual_temp, wrf_user_getvar

   See the full list of WRF functions.

Examples

   Note: for WRF variable names and their definitions, you can easily check them by using "ncl_filedump":
  ncl_filedump wrfout_d01_2008-09-29_20:00:00.nc

   Example 1

  filename = "wrfout_d01_2008-09-29_20:00:00.nc"
  a = addfile(filename,"r")

  t   = wrf_user_getvar(a,"tk",0)
  p   = wrf_user_getvar(a,"p",0)
  qv  = wrf_user_getvar(a,"QVAPOR",0)
  twb = wrf_wetbulb(p,t,qv)

   You can see some other example scripts and their resultant images at:

     http://www.mmm2.ucar.edu/wrf/OnLineTutorial/Graphics/NCL/


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:03 +0800
# vim:set fdm=indent foldlevel=0:
