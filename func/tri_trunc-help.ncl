THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/tri_trunc.shtml
THE_TITLE:tri_trunc

tri_trunc

   Performs triangular truncation on spherical harmonic coefficients.

Prototype

        procedure tri_trunc (
                a  : float or double,
                b  : float or double,
                T  : integer
        )

Arguments

   a
   b

   Spherical harmonic coefficients returned to user by NCL procedures shagc/shaec.

   T

   Triangular truncation parameter. T is the constant number of total wave numbers to keep.

Description

   tri_trunc performs triangular truncation on coefficients returned by the Spherepack analysis routines shagc or shaec. The
   results are returned in the a and b variables.

See Also

   tri_trunC, rhomb_trunc, rhomb_trunC, shaec, shsec, shagc, shsgc

Examples

   Example 1

   g(nlat,nlon)

   Array space for a and b must be preallocated by the user prior to calling NCL procedures shagc/shaec.

  a  = new ( dimsizes(g), typeof(g))
  b  = new ( dimsizes(g), typeof(g))

  T  = 19
  shaec(g,a,b)
  tri_trunc (a,b,T)
  shsec(a,b,g)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:14:03 +0800
# vim:set fdm=indent foldlevel=0:
