THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/lapsg.shtml
THE_TITLE:lapsg

lapsg

   Computes the Laplacian using spherical harmonics, given a scalar z on a gaussian grid.

Prototype

        procedure lapsg (
                z     : numeric,
                zlap  : float or double
        )

Arguments

   z

   scalar function array (input, two or more dimensions, last two dimensions must be nlat x nlon)
     * input values must be in ascending latitude order
     * input array must be on a global grid

   zlap

   Laplacian array (output, same dimensions as z, values will be in ascending latitude order)

Description

   lapsg computes the Laplacian z and returns it in the array zlap. lapsg operates on a gaussian grid.

   This procedure does not handle missing values. If any missing values are encountered in a particular 2D input grid, then
   all of the values in the corresponding output grid will be set to the missing value defined by the output grid's
   _FillValue attribute.

   Note: For the arrays whose last two dimensions are nlat x nlon, the rest of the dimensions (if any) are collectively
   referred to as N. If the input/output arrays are just two dimensions, then N can either be considered equal to 1 or
   nothing at all.

   Arrays which have dimensions N x nlat x nlon should not include the cyclic (wraparound) points when invoking the
   procedures and functions which use spherical harmonics (Spherepack).

   For example, if an array x has dimensions nlat = 64 and nlon = 129, where the "129" represents the cyclic points, then
   the user should pass the data to the procedure/function via:
    z = sample ( x([...],:,0:nlon-2) )  ; does not include cyclic points

   If the input array z is on a fixed grid, lapsf should be used. Also, note that lapsg is the procedural version of lapsG.

See Also

   lapsf, lapsG, lapsF, ilapsG, ilapsF, ilapsg, ilapsf

Examples

   Example 1

   Read Z (on a gaussian grid) from a netCDF file and compute the Laplacian:
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
begin
   a = addfile("/cgd/cas/shea/MURPHYS/ATMOS/80.nc","r")
   z200 = a->Z(0,{189.},:,:)                    ; z200 is dimensioned nlat x nlon
   printVarSummary(z200)
   lapl = z200                                  ; preallocate space for the returned array
   lapsg(z200,lapl)
end

Errors

   If jer or ker is equal to:

     1 : error in the specification of nlat
     2 : error in the specification of nlon
     4 : error in the specification of N (jer only)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:07:03 +0800
# vim:set fdm=indent foldlevel=0:
