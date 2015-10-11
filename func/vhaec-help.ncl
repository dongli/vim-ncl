THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/vhaec.shtml
THE_TITLE:vhaec

vhaec

   Computes vector spherical harmonic analysis of vector fields on a fixed grid via spherical harmonics.

Prototype

        procedure vhaec (
                u   : numeric,
                v   : numeric,
                br  : float or double,
                bi  : float or double,
                cr  : float or double,
                ci  : float or double
        )

Arguments

   u
   v

   vector function to be analyzed (input, array with two or more dimensions). The two rightmost dimensions must be nlat x
   nlon.
     * input values must be in ascending latitude order
     * input arrays must be on a global grid

   br
   bi
   cr
   ci

   vector spherical harmonic coefficients. The user must allocate arrays of the appropriate size prior to use. If the last
   two dimensions are nlat x nlon, then the second-to-the-last dimension is nlat. The last dimension (N) is a function of
   the comparative size of nlat and nlon. It may be determined as follows:

     N = minimum[nlat, (nlon )/2] if nlon is even
     N = minimum[nlat, (nlon+1)/2] if nlon is odd

   Note: The coefficients contained in br, bi, cr, and ci are in mathematical coordinates. The br,bi coefficients are
   associated with v (north-south, meridional component), and cr,ci are associated with u (east-west, zonal component).
   Please read the documentation:

     http://www.scd.ucar.edu/css/software/spherepack/vhaec.txt

   This is tricky and care must be taken to handle the coefficients correctly.

Description

   vhaec performs the vector spherical harmonic analysis on the arrays u and v, and stores the results in the arrays br, bi,
   cr, and ci. In general, vhaec (performs vector spherical harmonic analysis) is used in conjunction with vhsec (performs
   vector spherical harmonic synthesis). Note that both vhaec and vhsec operate on a fixed grid.

   NOTE: This procedure does not allow for missing data (defined by the _FillValue attribute) to be present. The input
   arrays should not include the cyclic (wraparound) points, as this procedure uses spherical harmonics. (NCL
   procedures/functions that use spherical harmonics should never be passed input arrays that include cyclic points.)

   If the input arrays u and v are on a gaussian grid, vhagc should be used. Also, note that vhaec is the procedural version
   of vhaeC.

See Also

   vhaeC, vhsec, vhseC, vhagc, vhagC, vhsgC, vhsgc

Examples

   In the examples below, u and v are on a fixed grid.

   Example 1

   u(nlat,nlon), v(nlat,nlon)

N = nlat
if (nlon%2 .eq.0) then    ; note % is NCL's modulus operator
   if (nlat.gt. (nlon+2)/2) then
      N = (nlon+2)/2
   end if
else                      ; nlon must be odd
   if (nlat.gt. (nlon+1)/2) then
      N = (nlon+1)/2
   end if
end if

br = new ( (/nlat,N/), float)
bi = new ( (/nlat,N/), float)
cr = new ( (/nlat,N/), float)
ci = new ( (/nlat,N/), float)

vhaec (u,v,br,bi,cr,ci)
      [do something with the coefficients]
vhsec (br,bi,cr,ci,u,v)

   Example 2

   u(nt,nlat,nlon), v(nt,nlat,nlon)

[same if test as in Example 1]

br = new ( (/nt,nlat,N/), float)
bi = new ( (/nt,nlat,N/), float)
cr = new ( (/nt,nlat,N/), float)
ci = new ( (/nt,nlat,N/), float)

vhaec (u,v,br,bi,cr,ci)
     [do something with the coefficients]
vhsec (br,bi,cr,ci,u,v)

   Example 3

   g(nt,nlvl,nlat,nlon)

[same if test as in Example 1]

br = new ( (/nt,nlvl,nlat,N/), float)
bi = new ( (/nt,nlvl,nlat,N/), float)
cr = new ( (/nt,nlvl,nlat,N/), float)
ci = new ( (/nt,nlvl,nlat,N/), float)

vhaec (u,v,br,bi,cr,ci)
    [do something with the coefficients]
vhsec (br,bi,cr,ci,u,v)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:14:41 +0800
# vim:set fdm=indent foldlevel=0:
