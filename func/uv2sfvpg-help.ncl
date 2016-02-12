THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/uv2sfvpg.shtml
THE_TITLE:uv2sfvpg

uv2sfvpg

   Computes the stream function and velocity potential via spherical harmonics given u and v on a gaussian grid.

Prototype

        procedure uv2sfvpg (
                u   : numeric,
                v   : numeric,
                sf  : float or double,
                vp  : float or double
        )

Arguments

   u
   v

   wind components (input, arrays with two or more dimensions, rightmost two dimensions must be nlat x nlon)
     * input values must be in ascending latitude order
     * input array must be on a global grid

   sf

   stream function (output, same dimensions as u and v, values will be in ascending latitude order)
   vp

   velocity potential (output, same dimensions as u and v, values will be in ascending latitude order)

Description

   Given wind components u and v, uv2sfvpg computes the stream function and the velocity potential and returns the results
   in the arrays sf and vp. uv2sfvpg operates on a gaussian grid.

   This procedure does not handle missing values (defined by the _FillValue attribute). If any missing values are
   encountered in a particular 2D input grid, then all of the values in the corresponding output grids will be set to the
   missing value defined by the output grids' _FillValue attributes.

   Note: For the arrays whose last two dimensions are nlat x nlon, the rest of the dimensions (if any) are collectively
   referred to as N. If the input/output arrays are just two dimensions, then N can either be considered equal to 1 or
   nothing at all.

   Arrays which have dimensions N x nlat x nlon should not include the cyclic (wraparound) points when invoking the
   procedures and functions which use spherical harmonics (Spherepack).

   If the input arrays u and v are on a fixed grid, uv2sfvpf should be used. Also, note that uv2sfvpg is the procedural
   version of uv2sfvpG.

See Also

   uv2sfvpG, uv2sfvpf, uv2sfvpF, uv2vrg

Examples

   Example 1

   Compute the stream function and velocity potential, given the u and v wind components on a gaussian grid.

begin
  nlat  =  128                                       ; dimensions
  mlon  =  256
  mlon1 = mlon+1
  fbfile = "uv300.hs"

  nrec  = fbinnumrec(fbfile)           ; total number of records in the file
  ntim  = nrec/2                       ; number of time steps in dataset

  uvmsg = 1e+36

  sf    = new ( (/nlat,mlon /), float, uvmsg )  ; stream function
  vp    = new ( (/nlat,mlon /), float, uvmsg )  ; velocity potential

  do i = 0,nrec-1,2
   month = 1                         ; January
   if (i .ge. 2) then
       month = 7                     ; July
   end if

   work = fbinrecread(fbfile,i  ,(/nlat,mlon1/),"float")
   u    = work(:,0:mlon-1)
   work = fbinrecread(fbfile,i+1,(/nlat,mlon1/),"float")
   v    = work(:,0:mlon-1)

   uv2sfvpg (u,v, sf,vp)             ; u,v ==> stream function + velocity pot
  end do
end

Errors

   If jer or ker is equal to:

     1 : error in the specification of nlat
     2 : error in the specification of nlon
     4 : error in the specification of N (jer only)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:14:24 +0800
# vim:set fdm=indent foldlevel=0:
