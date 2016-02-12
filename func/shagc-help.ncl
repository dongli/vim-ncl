THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/shagc.shtml
THE_TITLE:shagc

shagc

   Computes spherical harmonic analysis of a scalar field on a gaussian grid via spherical harmonics.

Prototype

        procedure shagc (
                g  : numeric,
                a  : float or double,
                b  : float or double
        )

Arguments

   g

   discrete function to be analyzed (input, array with two or more dimensions). The last two dimensions must be nlat x nlon.
   Note:
     * input values must be in ascending latitude order
     * input arrays must be on a global grid

   a
   b

   spherical harmonic coefficients (output, last two dimensions must be nlat x N). The user must allocate arrays of the
   appropriate size prior to use. The last dimension (N) is a function of the comparative size of nlat and nlon, and may be
   determined as follows:

     N = minimum(nlat, (nlon+2)/2) if nlon is even
     N = minimum(nlat, (nlon+1)/2) if nlon is odd

Description

   shagc performs the spherical harmonic analysis on the array g and stores the results in the arrays a and b. In general,
   shagc (performs spherical harmonic analysis) is used in conjunction with shsgc (performs spherical harmonic synthesis).
   Note that both shagc and shsgc operate on a gaussian grid.

   NOTE: This procedure does not allow for missing data (defined by the _FillValue attribute) to be present. g should not
   include the cyclic (wraparound) points, as this procedure uses spherical harmonics. (NCL procedures/functions that use
   spherical harmonics should never be passed input arrays that include cyclic points.)

   Normalization: Let m be the Fourier wave number (rightmost dimension) and let n be the Legendre index (next-to-last
   dimension). Then ab = 0 for n < m. The Legendre index, n, is sometimes referred to as the total wave number.

   The associated Legendre functions are normalized such that:
    sum_lat sum_lon { [ Pmn(lat,lon)e^im lon ]^2 w(lat)/mlon } = 0.25  (m=0)

    sum_lat sum_lon {
          { [ Pmn(lat,lon)e^im lon ]^2
          + [ Pmn(lat,lon)e^i-m lon ]^2 } w(lat)/mlon } = 0.5  (m /= 0)

   where w represents the Gaussian weights:
  sum_lat { w(lat) } = 2.

   If the input array g is on a fixed grid, shaec should be used. Also, note that shagc is the procedural version of shagC.

See Also

   shagC, shsgc, shsgC, shaec, shaeC, shseC, shsec, rhomb_trunc, tri_trunc

Examples

   In the following, assume g is on a gaussian grid, and no cyclic points are included.

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
   shagc (g,a,b)
   tri_trunc (a,b,T)
   shsgc (a,b,g)

   Example 2

   g(nt,nlat,nlon):
   [same "if" test as in example 1]

   a = new ( (/nt,nlat,N/), float)
   b = new ( (/nt,nlat,N/), float)
   shagc (g,a,b)
      [do something with the coefficients]
   shsgc (a,b,g)

   Example 3

   g(nt,nlvl,nlat,nlon):
   [same "if" test as in example 1]

   T = 19
   a = new ( (/nt,nlvl,nlat,N/), float)
   b = new ( (/nt,nlvl,nlat,N/), float)
   shagc (g,a,b)
   rhomb_trunc (a,b,T)
   shsgc (a,b,g)

   Note: if g has dimensions, say, nlat = 64 and nlon = 129, where the "129" represents the cyclic points, then the user
   should pass the data to the procedure such that the cyclic points are not included. In the following examples, g is a
   gaussian grid that contains cyclic points. (Remember NCL subscripts start at zero.)

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
   shagc (g(:,0:M-1), ,a,b)    ; only use the non-cyclic data
        [do something with the coefficients]
   shsgc (a,b, g(:,0:M-1))
   g(:,M) = g(:,0)         ; add new cyclic pt

   Example 5

   g(nt,nlat,nlon) where nlat=64 and nlon=129 and the "129" represents the cyclic points:
   [same "if" test as in example 4]

   a = new ( (/nt,nlat,N/), float)
   b = new ( (/nt,nlat,N/), float)
   shagc (g(:,:,0:nlon-2), a,b)
      [do something with the coefficients]
   shsgc (a,b, g(:,:,0:nlon-2))
   g(:,:,nlon-1) = g(:,:,0)         ; add new cyclic pt

   Example 6

   g(nt,nlvl,nlat,nlon) where nlat=64 and nlon=129 and the "129" represents the cyclic points:
   [same "if" test as in example 4]

   a = new ( (/nt,nlvl,nlat,N/), float)
   b = new ( (/nt,nlvl,nlat,N/), float)
   shagc (g(:,:,:,0:nlon-2), a,b)
        [do something with the coefficients]
   shsgc (a,b, g(:,:,:,0:nlon-2))
   g(:,:,:,nlon-1) = g(:,:,:,0)         ; add new cyclic pt

   Example 7

   Given the spherical harmonic coefficients, to get the (amplitude^2)/2 to plot a spatial spectrum normalized by 0.25 for m
   = 0 and 0.5 for m ne 0.

   Let g(nlat,nlon) and "ntr" be the maximum truncation (or as big as nlat) since spec is 0 beyond "ntr":
   ...
   shagc (g,cr,ci)

   pwr = (cr^2 + ci^2)/2.        ; (nlat,nlat)  array

   spc = new ( nlat, typeof(cr) )
   delete(spc@_FillValue)
                                ; for clarity use do loops
   do n=1,ntr
     spc(n) = pwr(n,0)
     do m=1,n
       spc(n) = spc(n) + 2.*pwr(n,m)
     end do
     spc(n) = 0.25*spc(n)
   end do

   Or, using array syntax and the built-in function sum:
   do n=1,ntr
      spc(n) = 0.25*(pwr(n,0) + 2.*sum( pwr(n,1:n) ) )
   end do

Errors

   If jer or ker is equal to:

     1 : error in the specification of nlat
     2 : error in the specification of nlon
     4 : error in the specification of nt (jer only)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:10:58 +0800
# vim:set fdm=indent foldlevel=0:
