THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/wgt_areaave2.shtml
THE_TITLE:wgt_areaave2

wgt_areaave2

   Calculates the area average of a quantity using two-dimensional weights.

Prototype

        function wgt_areaave2 (
                q          : numeric,
                wgt [*][*] : numeric,
                opt        : integer
        )

        return_val  :  float or double

Arguments

   q

   An array of 2 or more dimensions containing the data to be averaged. The rightmost dimensions should correspond to
   "latitude" (lat) and "longitude" (lon) when dealing with quantities on a sphere ([...,],lat,lon), and "y" and "x"
   otherwise ([...,],y,x).
   wgt

   A two-dimensional array corresponding to the rightmost dimensions of q.
   opt

   If opt = 0, the area average is calculated using available non-missing data. If opt = 1, then if any point in q is
   missing, the area average is not computed. In this case, it will be set to the missing value, which is indicated by
   q@_FillValue, or the default missing value if q@_FillValue is not set.

Return value

   Returns a scalar if q is a two dimensional array. Otherwise, the output dimensionality is the same as the leftmost n - 2
   dimensions of the input.

   The return type is floating point if the input is floating point, and double if the input is of type double.

Description

   This function computes a weighted area average. It ignores missing values (q@_FillValue).

See Also

   wgt_areaave, wgt_arearmse, wgt_arearmse2, wgt_areasum2, wgt_runave, wgt_volave, wgt_volave_ccm, wgt_volrmse,
   wgt_volrmse_ccm

Examples

   Example 1

   Let q(t, y, x) [size: (nt, ny, nx)] and let each grid point have a unique weight represented by w(y, x). Ideally, 'w'
   would be the area represented by each grid cell. Then:
    qAvg = wgt_areaave2(q, w, opt)    ; opt = 0 or 1

   qAvg will be a 1D array of length nt.

   Example 2

   Let q(time, lev, lat, lon) [size: (ntim, klev, nlat, mlon)], lat(lat) and lon(lon) be the latitude and longitude
   (degrees). Here, the area (dy * dx) represented by each grid point is a function of latitude. Assuming constant latitude
   and longitude spacing (in degrees), then one simple approach might be:
   re   = 6.37122e06
   rad  = 4.0 * atan(1.0) / 180.0
   con  = re * rad
   clat = cos(lat * rad)           ; cosine of latitude

   dlon = (lon(2) - lon(1))        ; assume dlon is constant
   dlat = (lat(2) - lat(1))        ; assume dlat is constant

   dx   = con * dlon * clat        ; dx at each latitude
   dy   = con * dlat               ; dy is constant
   dydx = dy * dx                  ; dydx(nlat)

   wgt  = new((/nlat, mlon/), typeof(q))
   wgt  = conform (wgt, dxdy, 0)


   qAvg = wgt_areaave2(q, wgt, opt)  ; => qAvg(ntim, klev)

   Limited area sums may be obtained via standard or coordinate subscripting:

 ; standard subscripting => qAvg(ntim, klev)
   qAvg = wgt_areaave2(q(:, 10:20), wgt(:, 10:20), opt)

 ; name coordinates for wgt
   wgt!0   = "lat"
   wgt!1   = "lon"
   wgt&lat =  lat
   wgt&lon =  lon

 ; standard subscripting => qSumc(ntim, klev)
   qAvg = wgt_areaave2(q({-20:20}), {110:270}), wgt({-20:20}), {110:270}), opt)

   Example 3

   Let q(t, y, x) [size: (nt, ny, nx)] and let each grid point have a latitude (lat2d) associated with each grid point. If
   you do not know how to calculate the grid cell areas, you could possibly use cosine weighting.

    f      = addfile("foo.{grb,nc,hdf}","r")
    q      = f->Q                                          ; (ntim,nlat,mlon)
    lat2d  = f->LAT                                        ; (nlat,mlon)
    clat2d = cos(lat2d*0.01745329)
    qAvg   = wgt_areaave2(q, clat2d, opt)    ; opt = 0 or 1


   For a subset of the area, you can specify the appropriate indices.


    iStrt =
    iLast =
    jStrt =
    jLast =
    qAvg  = wgt_areaave2(q(:,jStrt:jLast,iStrt:iLast), clat2d(jStrt:jLast,iStrt:iLast), opt)    ; opt = 0 or 1



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:15:05 +0800
# vim:set fdm=indent foldlevel=0:
