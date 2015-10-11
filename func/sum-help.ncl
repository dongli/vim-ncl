THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/sum.shtml
THE_TITLE:sum

sum

   Sums the input.

Prototype

        function sum (
                x  : numeric
        )

        return_val [1] :  typeof(x)

Arguments

   x

   An array of any dimensionality.

Return value

   A scalar value of the same type as x.

Description

   The sum function sums all of the input values, regardless of dimensionality. It ignores missing values.

See Also

   dim_sum, avg, product, stddev

Examples

   In the example below, see how setting the missing value, x@_FillValue, changes the sum calculation:
  x    = (/ (/1,-999/), (/3,4/), (/-999,6/) /)
  xsum = sum(x)
;
; Before missing value is set, xsum = -1984.
;
  print(xsum)

  x@_FillValue = -999
  xsum = sum(x)
;
; After missing value is set, xsum = 14.
;
  print(xsum)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:12:45 +0800
# vim:set fdm=indent foldlevel=0:
