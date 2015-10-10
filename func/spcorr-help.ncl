THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/spcorr.shtml
THE_TITLE:spcorr

spcorr

   Computes Spearman rank order correlation (Rho) correlation coefficient.

Prototype

        function spcorr (
                x  : numeric,
                y  : numeric
        )

        return_val  :  float or double

Arguments

   x

   An array of any numeric type or size. The rightmost dimension is the dimension to be used.
   y

   An array of any numeric type and same size as x. The rightmost dimension is the dimension to be used.

Return value

   The return value will have the same dimensions as all but the rightmost dimension of x and y. The return will be a double
   if x or y are double, and float otherwise.

Description

   Computes Spearman rank-order correlation. This function should not be used if there are many ranked 'ties'. The formula
   used does not apply to this situation.

   The Spearman rank-order correlation is less sensitive than the Pearson correlation to strong outliers that are in the
   tails of both samples. That is because Spearman's Rho limits the outlier to the value of its rank.

   Missing values will be removed from the input x and/or y prior to doing the calculation. [Available in version 6.1.0 and
   later.]

   Use spcorr_n if the dimension to do the calculation on is not the rightmost dimension and reordering is not desired. This
   function can be significantly faster than spcorr.

See Also

   spcorr_n, rtest, escorc, escorc_n, esacv, esacr, esccr, esccv, escovc

Examples

   Example 1 See: http://en.wikipedia.org/wiki/Spearman%27s_rank_correlation_coefficient
  x   = (/ 86, 97, 99, 100, 101, 103, 106, 110, 112, 113/)
  y   = (/  0, 20, 28,  27,  50,  29,   7,  17,   6,  12/)

  spc = spcorr( x, y)       ; spc = -0.175758
  p   = rtest( spc, N, 0)   ; p   =  0.6271883

   Example 2

   ; http://www.statsdirect.com/help/nonparametric_methods/spear.htm
  x = (/4,10,3,1, 9,2,6,7,8,5/)
  y = (/5, 8,6,2,10,3,9,4,7,1/)

  spc = spcorr( x, y)       ; spc = 0.684848

   Example 3

   ; http://birdcentral.net/spearman.htm
  x = (/122, 66, 79, 94, 43, 64, 30, 91,110, 76, 61,104, 67, 30, 92/)
  y = (/107, 32, 61,111, 48, 72, 34, 76,119, 90, 90, 59, 64, 46, 90/)

  spc = spcorr( x, y)       ; spc = 0.68125

   Example 4 - missing values

   In versions 6.1.0 and later, any missing values will be removed from the input arrays before the calculation is done. If
   all indexes of one or both arrays are missing, then the return value will be missing.

  x = (/122, 66, 79, 94, -999, 64, 30, 91,110, 76, 61, 104, 67, 30, 92/)
  y = (/107, 32, 61,111,   48, 72, 34, 76,119, 90, 90,-888, 64, 46, 90/)
  x@_FillValue = -999
  y@_FillValue = -888

  spc = spcorr( x, y )       ; spc = 0.7513736

   In versions 6.0.0 and earlier, you can use ind as a simple work-around for 1D arrays.

  x = (/122, 66, 79, 94, -999, 64, 30, 91,110, 76, 61, 104, 67, 30, 92/)
  y = (/107, 32, 61,111,   48, 72, 34, 76,119, 90, 90,-888, 64, 46, 90/)
  x@_FillValue = -999
  y@_FillValue = -888

  i   = ind( .not.(ismissing(x) .or. ismissing(y)) )
  spc = spcorr( x(i), y(i))       ; spc = 0.7513736


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:11:32 +0800
# vim:set fdm=indent foldlevel=0:
