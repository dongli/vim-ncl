THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/lonGlobeFo.shtml
THE_TITLE:lonGlobeFo

lonGlobeFo

   Generates longitudes and associated metadata for a global fixed offset grid.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function lonGlobeFo (
                nlon     [1] : integer or long,
                name     [1] : string,
                longname [1] : string,
                units    [1] : string
        )

        return_val [*] :  float

Arguments

   nlon

   A scalar equal to the number of longitudes desired.

   As of version 6.0.0, this can be of type integer or long.
   name

   A string that will become the named dimension of the output (e.g. "lon").
   longname

   A string that will become the long_name of the output (e.g. "longitude").
   units

   A string that will become the units of the output (e.g. "degrees_north").

Return value

   A one-dimensional array of size nlon. Default type float.

Description

   Generates longitudes and associated metadata for a global fixed offset grid.

See Also

   lonGlobeF, latGlobeF, latGlobeFo, latGau, latGauWgt, gaus

Examples

   The following require that contributed.ncl be loaded prior to invoking the function.
       load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

   Create a one-dimensional array of longitudes (coordinate array) offset from the Greenwich Meridian.
      mlon = 144
      lon  = lonGlobeFo(mlon, "lon", "longitude", "degrees_east")
      print(lon)

   The above returns a 1D array of length mlon values.
Variable: lon
Type: float
Total Size: 576 bytes
            144 values
Number of Dimensions: 1
Dimensions and sizes:   [lon | 144]
Coordinates:
            lon: [1.25..358.75]
Number Of Attributes: 2
  long_name :   longitude
  units :       degrees_east
(0)       1.25
(1)       3.75
(2)       6.25
(3)       8.75
(4)      11.25
[snip]
(139)   348.75
(140)   351.25
(141)   353.75
(142)   356.25
(143)   358.75

   Note 1: if starting at the International Date Line is desired,
      lon = (/ lon - 180. /)  ; subtract 180 from all values
      lon&lon = lon           ; update coordinates
      print(lon)

   The result:
Variable: lon
Type: float
Total Size: 576 bytes
            144 values
Number of Dimensions: 1
Dimensions and sizes:   [lon | 144]
Coordinates:
Variable: lon
Type: float
Total Size: 576 bytes
            144 values
Number of Dimensions: 1
Dimensions and sizes:   [lon | 144]
Coordinates:
            lon: [-178.75..178.75]
Number Of Attributes: 2
  long_name :   longitude
  units :       degrees_east
(0)     -178.75
(1)     -176.25
(2)     -173.75
(3)     -171.25
(4)     -168.75
[snip]
(139)    168.75
(140)    171.25
(141)    173.75
(142)    176.25
(143)    178.75

   Note 2: If double precision is desired, set
     mlon@double = True


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:18:51 +0800
# vim:set fdm=indent foldlevel=0:
