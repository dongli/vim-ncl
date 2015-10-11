THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/wind_component.shtml
THE_TITLE:wind_component

wind_component

   Calculate zonal and meridional wind components from wind speed and wind direction.

   [new.gif] Available in version 6.1.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function wind_component (
                wspd  : numeric,  ; float, double, integer only
                wdir  : numeric,
                opt   : integer
        )

Arguments

   wspd

   A variable of any dimensionality containing the wind speed, Array size and shape must match wdir.
   wdir

   A variable of any dimensionality containing the meteorological wind direction, Array size and shape must match wspd.
   opt

   Currently, not used. Set to zero (0).

Return value

   A double array is returned if wspd is double, otherwise a float array is returned.

   The returned array will have an extra dimension of size 2 as the leftmost dimension:
  2 x dimsizes(wspd)

Description

   Calculates meteorological wind direction.

See Also

   wind_direction, wind_speed

Examples

   Example 1
   u = (/ 10,   0,   0, -10, 10, 10, -10, -10, 0/)
   v = (/  0,  10, -10,   0, 10,-10,  10, -10, 0/)
   wdir = wind_direction(u,v,0)
   print(u+"  "+v+"  "+wdir)

   print("=====================")

   wspd = sqrt(u^2 + v^2)

   uv   = wind_component(wspd,wdir,0)

   printVarSummary(uv)
   print(uv(0,:)+"  "+uv(1,:))

   Output from wind_direction
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

   Output from wind_component
Variable: uv
Type: float
Total Size: 72 bytes
            18 values
Number of Dimensions: 2
Dimensions and sizes:   [uv | 2] x [9]   ; Note the left most dimension
Coordinates:
Number Of Attributes: 2
  _FillValue :  1e+20
  long_name :   zonal and meridional wind components



         U     V
(0)     10     0
(1)      0    10
(2)      0   -10
(3)    -10     0
(4)     10    10
(5)     10   -10
(6)    -10    10
(7)    -10   -10
(8)      0     0



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:41 +0800
# vim:set fdm=indent foldlevel=0:
