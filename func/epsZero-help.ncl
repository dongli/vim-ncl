THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/epsZero.shtml
THE_TITLE:epsZero

epsZero

   Sets all values in input array to zero that are +/- a user supplied epsilon about zero.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        procedure epsZero (
                x    : numeric,
                eps  : numeric
        )

        return_val  :  numeric

Arguments

   x

   (output)
   An array of any dimensionality.
   eps

   The epsilon value about zero. Must be the same type as x.

Description

   Sets all values in input array to zero that are +/- a user supplied epsilon about zero.

Examples

   Example 1
     X        = (/ 1,-2, -999., 1.e-05, -1.e-07, 10/)
     X@_FillValue = -999.
     eps          = 1.e-04
     epsZero (X, eps)
     print(X)
       X(0) 1
       X(1) -2
       X(2) -999.
       X(3) 0
       X(4) 0
       X(5) 10


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:17:45 +0800
# vim:set fdm=indent foldlevel=0:
