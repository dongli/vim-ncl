THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/wind_speed.shtml
THE_TITLE:wind_speed

wind_speed

   Calculate wind speed from zonal and meridional wind components.

   [new.gif] Available in version 6.3.1 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function wind_speed (
                u  : numeric,
                v  : numeric
        )

        return_val [dimsizes(u)] :  float or double

Arguments

   u

   A variable of any dimensionality containing the zonal wind component, Array size and shape must match v.
   v

   A variable of any dimensionality containing the meridional wind component, Array size and shape must match u.

Return value

   A multi-dimensional array of the same sizes as u. The output will be double if u or v is of type double. All appropriate
   meta data will be returned.

Description

   Calculates wind speed via sqrt(u^2+v^2).

See Also

   atan2, wind_direction, wind_component

Examples

   Example 1
   u    = ...        ; (time, lat,lon)    ; (2,64,128)
   v    = ...
   wspd = wind_speed(u,v)
   printVarSummary(wdpd)

   The output is:

   Variable: wspd
   Type: float
   Total Size: 65536 bytes
               16384 values
   Number of Dimensions: 3
   Dimensions and sizes:        [time | 2] x [lat | 64] x [lon | 128]
   Coordinates:
               time: [1..7]
               lat: [-87.8638..87.8638]
               lon: [-180..177.1875]
   Number Of Attributes: 3
     _FillValue :       -999
     long_name :        wind speed
     units :    m/s


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:44 +0800
# vim:set fdm=indent foldlevel=0:
