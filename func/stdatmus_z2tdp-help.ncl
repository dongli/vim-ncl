THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/stdatmus_z2tdp.shtml
THE_TITLE:stdatmus_z2tdp

stdatmus_z2tdp

   Calculates the corresponding temperature, density, and pressure based on the 1976 U.S. standard atmosphere, given the
   height.

Prototype

        function stdatmus_z2tdp (
                z  : numeric
        )

        return_val  :  [3,[,...]]

Arguments

   z

   A scalar or multi-dimensional array specifying the height values (units: m).

Return value

   If z is a scalar, then a one-dimensional array of length 3 will be returned. Element (0) will contain the temperature
   [C]; (1) will contain the density [kg/m^3] and (2) will contain pressure [hPa (mb)]. If z is an array, then an array of
   the same size as p plus an additional leftmost dimension of length 3 is returned. The three elements are the same as just
   described. The type will be double if z is double, and float otherwise.

Description

   This function uses the software provided by NCAR's Data Support Section to compute temperature, density and height based
   on the 1976 U.S. standard atmosphere given height values. See the DSS's meteorological calculations link.

   NOTE: Values not valid above 84852 meters.

See Also

   stdatmus_p2tdz

Examples

   Example 1

   z   = 100   ; meters
   tdp = stdatmus_z2tdp(z)    ; ===> tdp(3) = (/ 14.35, 1.21328, 1001.29 /)

   Example 2

   z   = (/0, 100, 500, 7500, 25000, 84000 /)
   tdp = stdatmus_z2tdp(z)    ; ===> tdp(3,6)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:11:53 +0800
# vim:set fdm=indent foldlevel=0:
