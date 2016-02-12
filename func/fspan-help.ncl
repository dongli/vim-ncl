THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/fspan.shtml
THE_TITLE:fspan

fspan

   Creates an array of evenly-spaced floating point numbers.

Prototype

        function fspan (
                start  [1] : numeric,
                finish [1] : numeric,
                npts   [1] : integral type
        )

        return_val [npts] :  float

Arguments

   start

   Value at which to start.
   finish

   Value at which to end.
   npts

   Number of equally-spaced points desired between start and finish. This value must be >= 2.

   See note below about a bug if npts=1.

   In version 6.0.0, this function will be upgraded to allow npts to be of any signed integral type (byte, short, int, long,
   int64).

Description

   fspan returns a 1D array with npts equally-spaced points from start to finish, inclusive.

   If start or finish are of type double, both start and finish are promoted to type double. If start or finish are of any
   other numeric type, both start and finish are promoted to type float.

   Bug note: In NCL V6.2.0 and earlier, if you set npts = 1, you will get back a value of zero and no warning or error. This
   is considered a bug, and in V6.2.1 this will produce an appropriate error.

See Also

   ispan, random_uniform

Examples

   Example 1

   The integers 0 and 100 will be coerced to the type float, as required by the fspan function.

   x = fspan(0, 100, 11)   ; x = (/0., 10., ... , 90., 100./) (11 values)

   mlon = 128
   dlon = 360. / mlon
   lon  = fspan (0, (mlon - 1) * dlon, mlon)    ; lon = (/0, 2.8125, ... , 357.1875/)


   Example 2

   You can swap the first two arguments to get a descending array:
   mlon = 128
   dlon = 360. / mlon
   lon  = fspan ((mlon - 1) * dlon, 0, mlon)   ; lon = (/357.1875, 354.375,...0/)


   Example 3

   With version 6.0.0 or later, you can input an npts that is greater than or equal to 2 gigabytes (GB), if you are on a
   64-bit system:
  npts = tolong(2^32)
  x = fspan (start, finish, npts)  ; array with 2^32 elements


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:04:30 +0800
# vim:set fdm=indent foldlevel=0:
