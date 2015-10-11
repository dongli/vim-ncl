THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/bin_avg.shtml
THE_TITLE:bin_avg

bin_avg

   Calculates gridded binned averages and counts on a rectilinear grid using randomly spaced data.

Prototype

        function bin_avg (
                zlon [*] : numeric ,
                zlat [*] : numeric ,
                z    [*] : numeric ,
                glon [*] : numeric ,
                glat [*] : numeric ,
                opt  [1] : logical
        )

Arguments

   zlon

   Longitudes of the observations (z).
   zlat

   Latitudes of the observations (z).
   z

   Observation values.
   glon

   Longitudes of the output grid. These must be equally spaced.
   glat

   Latitudes of the output grid. These must be equally spaced but may have different spacing than used for glon.
   opt

   Option. Currently not used. Set to False.

Return value

   A rectilinear grid of the size defined by glon and glat. The leftmost dimension will be size two (2). (See Example 1).
   The grid spacing must be equally spaced: eg: 1x1, 2x4, etc. The output array will be of type double if any of the input
   is double, and of type float otherwise.

Description

   This function averages values z contained within the rectilinear array defined by the input grid glon, glat. This takes
   advantage of the fact the latitude and longitude grid spacing is required to be constant. As noted in the argument
   description, the spacing in the latitude and longitude directions need not be equal. The appropriate grid point
   subscripts are determined via a simple algorithm.

   Note: There was a bug in this routine in NCL versions 6.2.1 and earlier where the binning was done incorrectly if the
   observation locations were outside the region spanned by the user provided grid. This function wasn't explicitly checking
   for this situation.

See Also

   bin_sum, triple2grid, triple2grid2d, poisson_grid_fill

Examples

   Example 1

   Assume zlon, zlat and zVal are one-dimensional (1D) arrays. Let lon and lat be 1D arrays of length M and N which specify
   grid locations. Then:
   grid = bin_avg(zlon,zlat,zVal, lon,lat, False)   ; (2,N,M)

   will return a 3-dimensional array of size 2xNxM. The leftmost dimension is of size 2. The 0-th index is the binned
   variable; the 1-th contains the count.

   Sometimes there are gaps in the returned array. If none are desired, then one approach would be to use poisson_grid_fill.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 22:59:27 +0800
# vim:set fdm=indent foldlevel=0:
