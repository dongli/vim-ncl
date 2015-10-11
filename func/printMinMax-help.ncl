THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/printMinMax.shtml
THE_TITLE:printMinMax

printMinMax

   Prints the minimum and maximum values of a variable.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        procedure printMinMax (
                data  : numeric,
                opt   : logical
        )

Arguments

   data

   A variable of any dimensionality.
   opt

   Provided for backward compatibility; not yet used. Set to 0 or True.

Description

   The printMinMax procedure prints a numeric variable's minimum and maximum values.

   It does not allow for any format control. For limited format control, use the sprintf function for floating point
   numbers, and sprinti for integers. To "pretty print" 2D arrays, use the write_matrix procedure.

   printMinMax is often used with printVarSummary.

See Also

   print, printVarSummary, printFileVarSummary, sprinti, sprintf, write_matrix

Examples

   Example 1

   Print an overview of a variable's contents and the minimum and maximum values.
  f = addfile ("T2m.nc", "r")
  T = f->T
  printVarSummary (T)
  printMinMax (T, 0)

   The above yields:
   Variable: T
   Type: float
   Total Size: 72192 bytes
               18048 values
   Number of Dimensions: 3
   Dimensions and sizes:   [time | 1] x [lat | 94] x [lon | 192]
   Coordinates:
               time: [197901..197901]
               lat: [-88.54195..88.54195]
               lon: [ 0..358.125]
   Number Of Attributes: 4
     units :       K
     short_name :  T2m
     long_name :   Temperature (2m)
     _FillValue :  1e+36

   Temperature (2m)    Minimum=224.89    Maximum=308.2


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:19:32 +0800
# vim:set fdm=indent foldlevel=0:
