THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/regcoef.shtml
THE_TITLE:regcoef

regcoef

   Calculates the linear regression coefficient between two variables.

Prototype

        function regcoef (
                x      : numeric,
                y      : numeric,
                tval   : float,    ; or double
                nptxy  : integer
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
   tval

   (output)
   An array that will contain the t-statistic (assuming null hypothesis). The dimensions are a function of the dimensions of
   x and y. Space for this must be explicitly allocated by the user (see example below).
   nptxy

   (output)
   An array containing the number of points used (output) that has the same dimensionality as tval. Space for this must be
   explicitly allocated by the user (see example below).

Return value

   If either x or y are of type double, then the return array is returned as double. Otherwise, rc is returned as type
   float. The dimensionality is a bit more complicated; see the description and examples below.

Description

   regcoef computes the regression coefficient via least-squares. regcoef is designed to work with multi-dimensional x and y
   arrays. If the regression information for a single best fit line for 1-dimensional x and y data is desired, then regline
   is the appropriate choice. Missing data are allowed.

   The regcoef function behaves exactly the same as regCoef, only you have to preallocate the space for tval and nptxy,
   since they are part of the argument list.

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

   regCoef, regCoef_n, regline

Examples

   Note: in the code snippets below, there are examples of both regcoef and regCoef, so you can see how they both can be
   utilized.

   Example 1

   In the example below, the regression coefficient for the case with no missing data is 0.97, the number of points used
   (nptxy) was 18 which yields 16 degrees of freedom (=nptxy-2). A test of the null hypothesis (i.e., that the regression
   coefficient is zero) yields a t-statistic of 38.7, which is distributed as t(16). Obviously, the null hypothesis would be
   rejected.

begin

 x = (/ 1190.,1455.,1550.,1730.,1745.,1770. \
     ,  1900.,1920.,1960.,2295.,2335.,2490. \
     ,  2720.,2710.,2530.,2900.,2760.,3010. /)

 y = (/ 1115.,1425.,1515.,1795.,1715.,1710. \
     ,  1830.,1920.,1970.,2300.,2280.,2520. \
     ,  2630.,2740.,2390.,2800.,2630.,2970. /)

 x@_FillValue = -999.
 y@_FillValue = -999.

 tval  = 0.
 nptxy = 0
 rc = regcoef(x,y,tval,nptxy)

 print ("NO MSG DATA: rc="+rc+"  tval="+tval+"  nptxy="+nptxy)

 x(2) = x@_FillValue
 y(8) = y@_FillValue

 rc = regcoef(x,y,tval,nptxy)
 print ("MSG DATA: rc="+rc+"  tval="+tval+"  nptxy="+nptxy)

end

   Example 2

   Assume x is a one-dimensional array (1D) array of size ntim and type float. Assume y is a four-dimensional array (4D)
   array of size nlev x nlat x nlon x ntim and type float.

   An NCL script snippet might look like:

   dimy = dimsizes(y)    ; determine the dimensions of "y"
   nlev = dimy(0)
   nlat = dimy(1)
   nlon = dimy(2)
   ntim = dimy(3)        ; not used in this example

   tval = new ((/nlev,nlat,nlon/) , float)    ; explicitly allocate space
   nxy  = new ((/nlev,nlat,nlon/) , integer)  ; explicitly allocate space
   rc   = regcoef (x,y, tval,nxy)

   or
   dimy = dimsizes(y)    ; determine the dimensions of "y"
   nlev = dimy(0)
   nlat = dimy(1)
   nlon = dimy(2)
   ntim = dimy(3)        ; not used in this example

   rc   = regCoef (x,y) ; rc@tval and rc@nptxy will be 1D arrays of
                        ; size nlev*nlat*nlon

   Here, rc will be of type float and have dimension size nlev x nlat x nlon.

   Example 3

   If y has size ntim x nlev x nlat x nlon and named dimensions "time","lev", "lat", and "lon". Then:
  dimy = dimsizes(y)    ; determine the dimensions of "y"
  ntim = dimy(0)
  nlev = dimy(1)
  nlat = dimy(2)
  nlon = dimy(3)

  tval = new ((/nlev,nlat,nlon/) , float)
  nxy  = new ((/nlev,nlat,nlon/) , integer)
  rc   = regcoef (x,y(lev|:,lat|:,lon|:,time|:), tval,nxy)
 ;delete (nxy)         ; delete if not interested

   Again, rc will be of type float and have dimension size nlev x nlat x nlon.

   Example 4

   Assume x is a two dimensional array (2D) array of size N x ntim and type double. Assume y is a four dimensional array
   (4D) array of size nlev x nlat x nlon x ntim and type double. Then:

  tval = new ((/N,nlev,nlat,nlon/) , double)
  nxy  = new ((/N,nlev,nlat,nlon/) , integer)
   rc   = regcoef (x,y, tval,nxy)

   or
   rc   = regCoef (x,y)  ; rc@tval and rc@nptxy will be 1D arrays of
                         ; size N*nlev*nlat*nlon. rc@tval will be of type
                         ; double.

   Here rc will be of type double and have dimension size N x nlev x nlat x nlon.

   Example 5

   If y has size ntim x nlev x nlat x nlon and named dimensions "time","lev", "lat","lon" (i.e. y(time,lev,lat,lon)), then:

  dimy = dimsizes(y)    ; determine the dimensions of "y"
  ntim = dimy(0)
  nlev = dimy(1)
  nlat = dimy(2)
  nlon = dimy(3)

  tval = new ((/N,nlev,nlat,nlon/) , float)
  nxy  = new ((/N,nlev,nlat,nlon/) , integer)
  rc   = regcoef (x,y(lev|:,lat|:,lon|:,time|:), tval,nxy)
  ;delete (nxy)         ; delete if not interested

   Again, rc will be of type double and have dimension size N x nlev x nlat x nlon.

   Example 6 (special case)

   Assume x and y are 4D arrays of size nlev x nlat x nlon x ntim and of type float.

  tval = new ((/nlev,nlat,nlon/) , float)
  nxy  = new ((/nlev,nlat,nlon/) , integer)
  rc   = regcoef (x,y, tval,nxy)

   Here rc will be of type float and have dimension size nlev x nlat x nlon.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:10:26 +0800
# vim:set fdm=indent foldlevel=0:
