THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/isMonotonic.shtml
THE_TITLE:isMonotonic

isMonotonic

   Check a one dimensional array to see if it is monotonic.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function isMonotonic (
                x [*] : numeric
        )

Arguments

   x

   A one-dimensional numeric array.

Return value

   Returns
        0 if the array is not monotonic.
        1 if the array is monotonically increasing.
       -1 if the array is monotonically decreasing.

Description

   Applies a simple test for monotonicity. An array is monotonically increasing if each value increases and monotonically
   decreasing if each value decreases.

Examples

   Example 1
      load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

      x = ispan(1,10,1)
      y = -x
      z = (/-5.2,-4.3,-2.2, 0, 1.7, -4.1, 9.9/)

      i = isMonotonic(x)     ; i= 1
      i = isMonotonic(y)     ; i=-1
      i = isMonotonic(z)     ; i= 0


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:18:34 +0800
# vim:set fdm=indent foldlevel=0:
