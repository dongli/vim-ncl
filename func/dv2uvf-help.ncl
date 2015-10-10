THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/dv2uvf.shtml
THE_TITLE:dv2uvf

dv2uvf

   Computes the divergent (irrotational) wind components for a fixed grid via spherical harmonics.

Prototype

        procedure dv2uvf (
                dv  : numeric,
                ud  : float or double,
                vd  : float or double
        )

Arguments

   dv

   Divergence array (input, two or more dimensions, where the rightmost two dimensions must be lat x lon)
     * input values must be in ascending latitude order
     * input array must be on a global grid

   ud

   Divergent zonal wind component (output, same dimensions as dv). The values will be in ascending latitude order.
   vd

   Divergent meridional wind component (output, same dimensions as dv). The values will be in ascending latitude order.

Description

   dv2uvf computes the divergent (irrotational) wind components given an array, dv, that contains divergence and is on a
   fixed grid. The results are returned in the arrays ud and vd.

   This procedure does not handle missing values (defined by the _FillValue attribute). If any missing values are
   encountered in a particular 2D input grid, then all of the values in the corresponding output grids will be set to the
   missing value defined by the output grids' _FillValue attribute.

   Note: For the arrays whose rightmost two dimensions are nlat x nlon, the rest of the dimensions (if any) are collectively
   referred to as N. If the input/output arrays are just two dimensions, then N can either be considered equal to 1 or
   nothing at all.

   Arrays which have dimensions N x nlat x nlon should not include the cyclic (wraparound) points when invoking the
   procedures and functions which use spherical harmonics (Spherepack).

   If the input array dv is on a gaussian grid, dv2uvg should be used. Also, note that dv2uvf is the procedural version of
   dv2uvF.

See Also

   dv2uvg, dv2uvG, dv2uvF, uv2dvF, uv2dvG

Examples

   Example 1

   dv is an array (on a fixed grid) dimensioned ntim x nlat x nlon, containing the divergence.
  ud    = new ( dimsizes(dv), typeof(dv))       ; zonal divergent wind
  vd    = new ( dimsizes(dv), typeof(dv))       ; meridional divergent wind
  dv2uvf   (dv,ud,vd)        ; dv  ==> divergent wind components

   Example 2

   Read u/v from a netCDF file, compute divergence, and then compute the divergent (irrotational) wind components:
  a = addfile("UV300.nc","r")

  u = a->U      ;U is on a fixed grid, dimensioned nlat x nlon

  v = a->V      ;V is on a fixed grid, dimensioned nlat x nlon

  dv    = new ( dimsizes(u), typeof(u))         ; divergence
  ud    = new ( dimsizes(dv),typeof(dv))        ; zonal divergent wind
  vd    = new ( dimsizes(dv),typeof(dv))        ; meridional divergent wind

  uv2dvf   (u,v,dv)          ; u,v ==> divergence
  dv2uvf   (dv,ud,vd)        ; dv  ==> divergent wind components

Errors

   If jer or ker is equal to:

     1 : error in the specification of nlat
     2 : error in the specification of nlon
     4 : error in the specification of nt (jer only)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:02:59 +0800
# vim:set fdm=indent foldlevel=0:
