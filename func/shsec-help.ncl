THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/shsec.shtml
THE_TITLE:shsec

shsec

   Computes spherical harmonic synthesis of a scalar quantity on a fixed grid via spherical harmonics.

Prototype

        procedure shsec (
                a  : numeric,
                b  : numeric,
                g  : float or double
        )

Arguments

   a
   b

   Spherical harmonic coefficients (input, array with two or more dimensions). If the last two dimensions of g are nlat x
   nlon, then the last two dimensions of a and b must be nlat x N, where N is determined as follows:

     N = minimum(nlat, (nlon+2)/2) if nlon is even
     N = minimum(nlat, (nlon+1)/2) if nlon is odd

   In general, a and b were created in the process of doing spherical harmonic analysis via shaec. Note:
     * input arrays must be global

   g

   The result of spherical harmonic synthesis of a and b (output, last two dimensions must be nlat x nlon). This must be the
   same size as the array(s) upon which the spherical harmonic analysis was performed. The space for g must be created prior
   to invoking the above procedures.

Description

   shsec performs the spherical harmonic synthesis on the arrays a and b and stores the results in the array g.

   In general, shaec (performs spherical harmonic analysis) will have to be invoked prior to calling shsec (performs
   spherical harmonic synthesis). Note that both shaec and shsec operate on a fixed grid.

   NOTE: This procedure does not allow for missing data (defined by the _FillValue attribute) to be present. g should not
   include the cyclic (wraparound) points, as this procedure uses spherical harmonics. (NCL procedures/functions that use
   spherical harmonics should never be passed input arrays that include cyclic points.)

   Normalization: Let m be the Fourier wave number (rightmost dimension) and let n be the Legendre index (next-to-last
   dimension). Then ab = 0 for n < m.

   The associated Legendre functions are normalized such that:
    sum_lat sum_lon { [ Pmn(lat,lon)e^im lon ]^2 w(lat)/mlon } = 0.25  (m=0)

    sum_lat sum_lon {
          { [ Pmn(lat,lon)e^im lon ]^2
          + [ Pmn(lat,lon)e^i-m lon ]^2 } w(lat)/mlon } = 0.5  (m /= 0)

   where w represents the Gaussian weights:
  sum_lat { w(lat) } = 2.

   If the original input array is on a gaussian grid, shsgc should be used. Also, note that shsec is the procedural version
   of shseC.

See Also

   shseC, shaec, shaeC, shsgc, shsgC, shagC, shagc, rhomb_trunc, tri_trunc

Examples

   In the following, assume g is on a fixed grid, and no cyclic points are included.

   Example 1

   g(nlat,nlon):
   N = nlat
   if (nlon%2 .eq.0) then    ; note % is NCL's modulus operator
     N = min((/ nlat, (nlon+2)/2 /))
   else                      ; nlon must be odd
     N = min((/ nlat, (nlon+1)/2 /))
   end if

   T = 19
   a = new ( (/nlat,N/), float)
   b = new ( (/nlat,N/), float)
   shaec (g,a,b)
   tri_trunc (a,b,T)
   shsec (a,b,g)

   Example 2

   g(nt,nlat,nlon):
   [same "if" test as in example 1]

   a = new ( (/nt,nlat,N/), float)
   b = new ( (/nt,nlat,N/), float)
   shaec (g,a,b)
      [do something with the coefficients]
   shsec (a,b,g)

   Example 3

   g(nt,nlvl,nlat,nlon):
   [same "if" test as in example 1]

   T = 19
   a = new ( (/nt,nlvl,nlat,N/), float)
   b = new ( (/nt,nlvl,nlat,N/), float)
   shaec (g,a,b)
   rhomb_trunc (a,b,T)
   shsec (a,b,g)

   Note: if g has dimensions, say, nlat = 73 and nlon = 145, where the "145" represents the cyclic points, then the user
   should pass the data to the procedure such that the cyclic points are not included. In the following examples, g is on a
   fixed grid that contains cyclic points. (Remember NCL subscripts start at zero.)

   Example 4

   g(nlat,nlon):
   N = nlat
   M = nlon-1             ; test using the dimension without cyclic pt
   if (M%2 .eq.0) then    ; use M to determine appropriate dimension
     N = min((/ nlat,(M+2)/2 /))
   else                      ; nlon must be odd
     N = min((/ nlat,(M+1)/2 /))
   end if

   a = new ( (/nlat,N/), float)
   b = new ( (/nlat,N/), float)
   shaec (g(:,0:M-1), ,a,b)    ; only use the non-cyclic data
        [do something with the coefficients]
   shsec (a,b, g(:,0:M-1))
   g(:,M) = g(:,0)         ; add new cyclic point

   Example 5

   g(nt,nlat,nlon) where nlat=73 and nlon=145 and the "145" represents the cyclic points:
   [same "if" test as in example 4]

   a = new ( (/nt,nlat,N/), float)
   b = new ( (/nt,nlat,N/), float)
   shaec (g(:,:,0:nlon-2), a,b)
      [do something with the coefficients]
   shsec (a,b, g(:,:,0:nlon-2))
   g(:,:,nlon-1) = g(:,:,0)         ; add new cyclic point

   Example 6

   g(nt,nlvl,nlat,nlon) where nlat=73 and nlon=145 and the "145" represents the cyclic points:
   [same "if" test as in example 4]

   a = new ( (/nt,nlvl,nlat,N/), float)
   b = new ( (/nt,nlvl,nlat,N/), float)
   shaec (g(:,:,:,0:nlon-2), a,b)
        [do something with the coefficients]
   shsec (a,b, g(:,:,:,0:nlon-2))
   g(:,:,:,nlon-1) = g(:,:,:,0)         ; add new cyclic point

Errors

   If jer or ker is equal to:

     1 : error in the specification of nlat
     2 : error in the specification of nlon
     4 : error in the specification of N (jer only)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:11:07 +0800
# vim:set fdm=indent foldlevel=0:
