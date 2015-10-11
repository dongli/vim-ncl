THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/wind_direction.shtml
THE_TITLE:wind_direction

wind_direction

   Calculate meteorological wind direction from zonal and meridional wind components.

   [new.gif] Available in version 6.1.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function wind_direction (
                u    : numeric,  ; float, double, integer only
                v    : numeric,
                opt  : integer
        )

        return_val [dimsizes(u)] :  float or double

Arguments

   u

   A variable of any dimensionality containing the zonal wind component, Array size and shape must match v.
   v

   A variable of any dimensionality containing the meridional wind component, Array size and shape must match u.
   opt

   A scalar which indicates how 'calm' (u=v=0) wind direction is returned.
    1. opt=0: the returned wind direction will be 0.0
    2. opt=1: the returned wind direction will be set to missing (_FillValue).
    3. opt set to a float, double or integer (other than 0 or 1), the returned wind direction will be set to this value.

Return value

   A multi-dimensional array of the same sizes as u. The output will be double if u or v is of type double.

Description

   Calculates meteorological wind direction.

See Also

   atan2, wind_component, wind_speed

Examples

   Example 1
   u = (/ 10,   0,   0, -10,  10,  10, -10, -10, 0/)
   v = (/  0,  10, -10,   0,  10, -10,  10, -10, 0/)
   wdir = wind_direction(u,v,0)
   print(u+"  "+v+"  "+wdir)

         U     V    dir
(0)     10     0    270    (west)
(1)      0    10    180    (south)
(2)      0   -10      0    (north)
(3)    -10     0     90    (east)

(4)     10    10    225    (southwest)
(5)     10   -10    315    (northwest)
(6)    -10    10    135    (northeast)
(7)    -10   -10     45    (southeast)

(8)      0     0      0    (calm;   opt=0)
         0     0   1e20    (calm;   opt=1)
         0     0   -999    (calm;   opt=-999)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:42 +0800
# vim:set fdm=indent foldlevel=0:
