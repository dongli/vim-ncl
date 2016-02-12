THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/rhomb_trunc.shtml
THE_TITLE:rhomb_trunc

rhomb_trunc

   Performs rhomboidal truncation on spherical harmonic coefficients.

Prototype

        procedure rhomb_trunc (
                a  : float or double,
                b  : float or double,
                T  : integer
        )

Arguments

   a
   b

   Spherical harmonic coefficients returned to user by NCL procedures shagc/shaec.

   T

   Rhomboidal truncation parameter. T is the constant number of total wave numbers to keep.

Description

   rhomb_trunc performs rhomboidal truncation on coefficients returned by the Spherepack analysis routines shagc or shaec.
   The results are returned in the a and b variables.

   rhomb_trunc is the procedural version of rhomb_trunC.

See Also

   rhomb_trunC, tri_trunc, tri_trunC, shaec, shsec, shagc, shsgc

Examples

   Example 1

   g(nlat,nlon)

   Array space for a and b must be preallocated by the user prior to calling NCL procedures shagc/shaec.

  a  = new ( dimsizes(g), typeof(g))
  b  = new ( dimsizes(g), typeof(g))

  T  = 19
  shaec(g,a,b)
  rhomb_trunc (a,b,T)
  shsec(a,b,g)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:10:42 +0800
# vim:set fdm=indent foldlevel=0:
