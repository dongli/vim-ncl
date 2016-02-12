THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/igradsf.shtml
THE_TITLE:igradsf

igradsf

   Computes a scalar array from its gradient components on a fixed grid using spherical harmonics.

Prototype

        procedure igradsf (
                gzx  : numeric,
                gzy  : numeric,
                z    : float     ; or double
        )

Arguments

   gzx
   gzy

   gradient arrays (input, two or more dimensions, last two dimensions must be nlat x nlon)
     * input values must be in ascending latitude order
     * input arrays must be on a global grid

   z

   scalar array (output, same dimensions as gzx, gzy, values will be in ascending latitude order)

Description

   igradsf computes a scalar array given gradient gzx and gzy and returns it in the array z. igradsf operates on a fixed
   grid.

   This procedure does not handle missing values (defined by the _FillValue attribute). If any missing values are
   encountered in a particular 2D input grid, then all of the values in the corresponding output grid will be set to the
   default missing value appropriate to the type of the output.

   This procedure computes a scalar function whose gradient is the irrotational component of the input vector. The gradient
   is equal to the input vector only if its rotational component is zero.

   Note: For the arrays whose last two dimensions are nlat x nlon, the rest of the dimensions (if any) are collectively
   referred to as N. If the input/output arrays are just two dimensions, then N can either be considered equal to 1 or
   nothing at all.

   Arrays which have dimensions N x nlat x nlon should not include the cyclic (wraparound) points when invoking the
   procedures and functions which use spherical harmonics (Spherepack).

   For example, if an array x has dimensions nlat = 64 and nlon = 129, where the "129" represents the cyclic points, then
   the user should pass the data to the procedure/function via:
    z = sample ( x([...],:,0:nlon-2) )  ; does not include cyclic points

   If the input arrays gzx and gzy are on a gaussian grid, igradsg should be used. Also, note that igradsf is the procedural
   version of igradsF.

See Also

   igradsF, igradsg, igradsG, gradsf, gradsg, lderuvf, lderuvg

Examples

   Example 1

   Given arrays T_grad_lat(time,lev,lat,lon) and T_grad_lon(time,lev,lat,lon) containing the gradient (latitudinal and
   longitudinal derivatives), compute the scalar array. The gradient arrays are on a fixed grid.

  T = T_grad_lat                ; create array to hold output, same type and size as input
  igradsf (T_grad_lon, T_grad_lat, T)

   Example 2

   Given a scalar array T, compute the latitudinal and longitudinal derivatives, and then recompute T. T is on a fixed grid.
  T_grad_lon = T                ; create arrays to hold output, same size and type as input
  T_grad_lat = T
                                ; this procedure will overwrite
                                ; values in T_grad_lon and T_grad_lat

  gradsf (T, T_grad_lon, T_grad_lat)
  T_grad_lon@long_name = "longitudinal gradient (derivative)"
  T_grad_lat@long_name = "latitudinal gradient (derivative)"
  igradsf (T_grad_lon, T_grad_lat, T)

Errors

   If jer or ker is equal to:

     1 : error in the specification of nlat
     2 : error in the specification of nlon
     4 : error in the specification of N (jer only)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:05:48 +0800
# vim:set fdm=indent foldlevel=0:
