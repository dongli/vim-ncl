THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/ilapsf.shtml
THE_TITLE:ilapsf

ilapsf

   Inverts the Laplacian (on a fixed grid) using spherical harmonics.

Prototype

        procedure ilapsf (
                zlap    : numeric,
                zlmbda  : numeric,
                z       : float or double
        )

Arguments

   zlap

   the Laplacian array to invert (input, two or more dimensions, last two dimensions must be nlat x nlon)
     * input values must be in ascending latitude order
     * input array must be on a global grid

   zlmbda

   If zlap is a two dimensional array then zlmbda may be a constant. If zlap has 3 or more dimensions then zlmbda must be an
   array with the same dimensions as zlap (minus the rightmost two dimensions). If zlmbda is identically zero, the poisson
   equation is solved. Otherwise, the Helmholtz equation is solved.
   z

   the inverted Laplacian array (output, same dimensions as zlap, values will be in ascending latitude order)

Description

   ilapsf inverts the Laplacian zlap and returns it in the array z. ilapsf operates on a fixed grid.

   This procedure does not handle missing values (defined by the _FillValue attribute). If any missing values are
   encountered in a particular 2D input grid, then all of the values in the corresponding output grid will be set to the
   default missing value appropriate to the type of the output.

   Note: For the arrays whose last two dimensions are nlat x nlon, the rest of the dimensions (if any) are collectively
   referred to as N. If the input/output arrays are just two dimensions, then N can either be considered equal to 1 or
   nothing at all.

   Arrays which have dimensions N x nlat x nlon should not include the cyclic (wraparound) points when invoking the
   procedures and functions which use spherical harmonics (Spherepack).

   For example, if an array x has dimensions nlat = 64 and nlon = 129, where the "129" represents the cyclic points, then
   the user should pass the data to the procedure/function via:
    z = sample ( x([...],:,0:nlon-2) )  ; does not include cyclic points

   If the input array zlap is on a gaussian grid, ilapsg should be used. Also, note that ilapsf is the procedural version of
   ilapsF.

See Also

   ilapsg, ilapsF, ilapsG, lapsG, lapsF, ilapvf, ilapvg

Examples

   Example 1

   Read Z (on a fixed grid) from a netCDF file and compute the inverse laplacian, solving the Poisson equation (k=0):
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
begin
   a = addfile("/cgd/cas/shea/MURPHYS/ATMOS/80.fixed.nc","r")
   z200 = a->Z(0,{189.},:,:)                    ; z200 is dimensioned nlat x nlon
   printVarSummary(z200)
   ilapl = z200                 ; preallocate space for return array
   ilapsf(z200,0,ilapl)
end

Errors

   If jer or ker is equal to:

     1 : error in the specification of nlat
     2 : error in the specification of nlon
     4 : error in the specification of N (jer only)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:05:50 +0800
# vim:set fdm=indent foldlevel=0:
