THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/dim_acumrun_n.shtml
THE_TITLE:dim_acumrun_n

dim_acumrun_n

   Calculates individual accumulated sums of sequences ('runs') of a specified length.

   [new.gif] Available in version 6.2.1 and later.

Prototype

        function dim_acumrun_n (
                x        : numeric,
                lrun [1] : integer,
                opt      : integer,
                dims [*] : integer
        )

        return_val [dimsizes(x)] :  typeof(x)

Arguments

   x

   A variable of numeric type and any dimensionality. NOTE: If there is no explicit _FillValue associated with x, the
   default _FillValue will be used.
   lrun

   A scalar specifying the length of the run. lrun must be greater than or equal to 2.
   opt

   A scalar indicating how an individual run with _FillValue are handled. The default is opt=0.
     * opt=0: if a _FillValue is encountered, set the current accumulated run value to _FillValue.
     * opt=1: if a _FillValue is encountered, continue calculating the accumulated sum using available values.

   dims

   The dimension(s) of x on which to calculate the sum. Must be consecutive and monotonically increasing.

Return value

   The same type and dimensionality as x.

Description

   The dim_acumrun_n function calculates the cumulative sum of the current values and the previous (lrun-1) values. This
   type of calculation is often done for precipitation values to assess drought.

See Also

   dim_cumsum_n, dim_cumsum_n_Wrap

Examples

   Example 1: Calculate the accumulated individual running sums of the current and previous (lrun-1i) values. When no
   _FillValue are encountered opt=0 and 1 yield the same answer.

  x        = (/1,2,3,4,5,7,-23/)
  x@_FillValue = -999
  x_ars    = dim_acumrun_n(x,3,0,0)            ; (/-999,-999, 6, 9, 12, 16, -11 /)
  x_ars    = dim_acumrun_n(x,3,1,0)            ; (/-999,-999, 6, 9, 12, 16, -11 /)

   Example 2: When one or more _FillValue are encountered, opt=0 and 1 yield different results.

  x        = (/1,2,-999,4,5,7,-999, 2, -9, 5/)
  x@_FillValue = -999
  x_ars    = dim_acumrun_n(x,3,0,0)            ; (/-999,-999,-999,-999,-999, 16,-999,-999,-999, -2 /)
  x_ars    = dim_acumrun_n(x,3,1,0)            ; (/-999,-999,  3 ,  6 ,  9 , 16, 12 ,  9 , -7 , -2 /)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:01:34 +0800
# vim:set fdm=indent foldlevel=0:
