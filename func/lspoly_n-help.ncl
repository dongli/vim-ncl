THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/lspoly_n.shtml
THE_TITLE:lspoly_n

lspoly_n

   Calculates a set of coefficients for a weighted least squares polynomial fit to the given data on the given dimension.

   [new.gif] Available in version 6.2.0 and later.

Prototype

        function lspoly_n (
                x       : numeric,
                y       : numeric,
                wgt     : numeric,
                n   [1] : integer,
                dim [1] : integer
        )

        return_val  :  float or double

Arguments

   x

   Abscissa values of the data.

   This can be one-dimensional or multi-dimensional. If one-dimensional, it must be the same length as the rightmost
   dimension of y. If multi-dimensional, it must be the same dimensionality as y.
   y

   Ordinate values of the data.
   wgt

   Weights for a weighted least squares model. If all data values are to be assigned equal weights, then setting the
   argument equal to a scalar 1.0 will result in all the weights being set to 1.0. Note: if x or y is equal to _FillValue
   (if present), the weight will be set to 0.0 for that coordinate pair.

   This can be one-dimensional or multi-dimensional. If one-dimensional, it must be the same length as the rightmost
   dimension of y. If multi-dimensional, it must be the same dimensionality as y.
   n

   The number of coefficients desired (i.e., n-1 will be the degree of the polynomial). It is suggested that n be less than
   or equal to five.
   dim

   A scalar integer indicating which dimension of y to do the calculation on. Dimension numbering starts at 0.

Return value

   The return array will have the same dimensionality as y, except the dim-th dimension will be of length n.

   If either x or y are of type double, then the return array is returned as double. Otherwise, the returned coefficients
   are returned as type float.

Description

   Given a set of data (x(i),y(i)), i = 1,...,m, lspoly_n calculates a set of coefficients for a weighted least squares
   polynomial fit to the given data on the given dimension. It is necessary that the number of data points) be greater than
   n (the number of coefficients).

See Also

   lspoly, regCoef, regline, regcoef, reg_multlin

Examples

   Example 1

   Note: we don't need to use lspoly_n in this example, since we are only using 1D arrays, and hence there's no reordering
   necessary.
  x = (/-4.5, -3.2, -1.4, 0.8, 2.5, 4.1/)
  y = (/ 0.7,  2.3,  3.8, 5.0, 5.5, 5.6/)

  n = 4
  c = lspoly_n(x, y, 1, n, 0)    ; all weights are set to one
  print(c)

   The 3rd degree polynomial is
         Y = c(0) + c(1)*x + c(2)*x^2 + c(3)*x^3

   The coefficients (which agree with those returned from Mathematica) are:
(0)      4.66863
(1)      0.489392
(2)     -0.0742387
(3)      0.00267663

   Example 2

   Similar as the previous example, but this time assume x and y are 3D arrays and that we want to solve the equation for
   the middle (dim=1) dimension:

  n = 4
  c = lspoly_n(x, y, 1, n, 1)    ; all weights are set to one
  print(c)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:07:48 +0800
# vim:set fdm=indent foldlevel=0:
