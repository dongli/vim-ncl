THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/regCoef_n.shtml
THE_TITLE:regCoef_n

regCoef_n

   Calculates the linear regression coefficient between two variables on the given dimensions.

Prototype

        function regCoef_n (
                x          : numeric,
                y          : numeric,
                dims_x [*] : integer,
                dims_y [*] : integer
        )

        return_val  :  float or double

Arguments

   x

   An array of any dimensionality. Missing values should be indicated by x@_FillValue. If x@_FillValue is not set, then the
   NCL default (appropriate to the type of x) will be assumed.
   y

   An array of any dimensionality. The last dimension of y must be the same as the last dimension of x. Missing values
   should be indicated by y@_FillValue. If y@_FillValue is not set, then the NCL default (appropriate to the type of y) will
   be assumed.
   dims_x

   A scalar integer indicating which dimension of x to do the calculation on. Dimension numbering starts at 0.
   dims_y

   A scalar integer indicating which dimension of y to do the calculation on. Dimension numbering starts at 0.

Return value

   If either x or y are of type double, then the return array is returned as double. Otherwise, the returned variable is
   returned as type float. The dimensionality is a bit more complicated; see the description and examples below.

Description

   regCoef_n computes the linear regression coefficient via least-squares across the given dimensions. regCoef_n is designed
   to work with multi-dimensional x and y arrays. If the regression information for a single best fit line for 1-dimensional
   x and y data is desired, then regline is the appropriate choice. Missing data are allowed.

   The regCoef_n function returns the following attributes: tval (t-statistic), rstd (standard error of the estimated
   regression coefficient) and nptxy (number of elements used). These will be returned as scalars for one-dimensional x/y;
   otherwise, as one-dimensional attributes of the return variable (call it rc). The type of tval and rstd will be the same
   as rc while nptxy will be of type integer. These attributes may be used for statistical testing (see examples).

   The dimensions of rc are illustrated as follows:

    x(N), y(N)          rc, tval, mptxy are scalars
    x(N), y(K,M,N)      rc, tval, mptxy are arrays of size (K,M)
  x(I,N), y(K,M,N)      rc, tval, mptxy are arrays of size (I,K,M)
x(J,I,N), y(L,K,M,N)    rc, tval, mptxy are arrays of size (J,I,L,K,M)

   There's a special case when all dimensions of x and y are identical:

   x(J,I,N), y(J,I,N)      rc, tval, mptxy are arrays of size (J,I)

   Note on the units of the returned regression coefficient(s): if x has units of, say, degrees Kelvin (K), and y has units
   of, say, meters (M), then the units of the regression coefficient are M/K. The function does not standardize x (or y)
   prior to calculating the regression coefficient. If this is desired, then it is the user's responsibility do so. The NCL
   function dim_standardize can be used.

See Also

   regCoef, regcoef, regline

Examples

   Example 1

   Assume x is a one dimensional array (1D) array of size ntim and type float. Assume y is a three-dimensional array (3D)
   array with named dimensions, "time", "lat" and "lon" with the following ordering y(time,lat,lon).
   rc   = regCoef_n(x, y, 0, 0)


   If y has coordinate variables these may readily be assigned via NCL syntax:
   rc!0   = "lat"    ; name dimensions
   rc!1   = "lon"
   rc&lat = y&lat   ; assign coordinate values to named dimensions
   rc&lon = y&lon


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:10:27 +0800
# vim:set fdm=indent foldlevel=0:
