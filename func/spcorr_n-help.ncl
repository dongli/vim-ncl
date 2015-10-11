THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/spcorr_n.shtml
THE_TITLE:spcorr_n

spcorr_n

   Computes Spearman rank order correlation (Rho) correlation coefficient across the given dimension.

   [new.gif] Available in version 6.1.0 and later.

Prototype

        function spcorr_n (
                x       : numeric,
                y       : numeric,
                dim [1] : integer
        )

        return_val  :  float or double

Arguments

   x

   An array of any numeric type or size. The dim-th dimension is the dimension to be used.
   y

   An array of any numeric type and same size as x. The dim-th dimension is the dimension to be used.
   dim

   A scalar integer indicating which dimension of x, y to do the calculation on. Dimension numbering starts at 0.

Return value

   The return value will have the same dimensions as all but the dim-th dimension of x and y. The return will be a double if
   x or y are double, and float otherwise.

Description

   Computes Spearman rank order correlation (Rho) across the given dimension. The Spearman correlation is less sensitive
   than the Pearson correlation to strong outliers that are in the tails of both samples. That is because Spearman's Rho
   limits the outlier to the value of its rank.

   This function should not be used if there are many ranked 'ties'. The formula used does not apply to this situation.

   Missing values will be removed from the input x and/or y prior to doing the calculation.

See Also

   spcorr, rtest, escorc, escorc_n, esacv, esacr, esccr, esccv, escovc

Examples

   Example 1: See: http://en.wikipedia.org/wiki/Spearman%27s_rank_correlation_coefficient

  x   = (/ 86, 97, 99, 100, 101, 103, 106, 110, 112, 113/)
  y   = (/  0, 20, 28,  27,  50,  29,   7,  17,   6,  12/)
  N   = dimsizes(x)

  spc = spcorr_n( x, y, 0)  ; spc = -0.1757576
  p   = rtest( spc, N, 0)   ; p   =  0.6271883


   Example 2 x(2,ntim), y(2,ntim)

  x   = (/ (/ 86, 97, 99, 100, 101, 103, 106, 110, 112, 113/), \   ; (2,ntim)
           (/ 90, 93, 96, 102, 103, 105, 106, 109, 111, 113/) /)

  y   = (/ (/  0, 20, 28,  27,  50,  29,   7,  17,   6,  12/), \
           (/  0, 10, 15,  26,  40,  35,  16,   8,   3,   1/) /)

  dimxy = dimsizes(y)
  ntim  = dimy(1)

  spc = spcorr_n( x, y, 1)     ; spc = (/ -0.1757576, -0.1151515 /)
  p   = rtest( spc, ntim, 0)    ; p   = (/  0.6271883, 0.75142    /)



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:11:34 +0800
# vim:set fdm=indent foldlevel=0:
