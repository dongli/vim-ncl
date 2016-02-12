THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/simpne.shtml
THE_TITLE:simpne

simpne

   Integrates a sequence of unequally spaced points using Simpson's three-point formula.

Prototype

        function simpne (
                x  : numeric,
                y  : numeric
        )

        return_val  :  float or double

Arguments

   x

   An array of one or more dimensions. The rightmost dimension is the dimension to be integrated. If y is multi-dimensional
   and x is one-dimensional then x must be the same size as the rightmost dimension of y. Otherwise, x and y must be the
   same size.
   y

   An array of one or more dimensions. The rightmost dimension is the dimension to be integrated.

Return value

   The return value will have same dimensions as all but the rightmost dimension of y (or be a scalar if y is
   one-dimensional). The return type will be double if y is double, and float otherwise.

Description

   This function performs Simpson's formula for integration. The number of points may be odd or even. Missing values are
   allowed.

   Other integration functions that may better fit your needs include vibeta and ftcurvi.

See Also

   ftcurvi, vibeta, simpeq

Examples

   Example 1

   Evaluate exp^x from x=1.6 to x=3.8. Exact answer should be 29.7482.

   x  = (/1.6, 1.7, 2.33, 2.49, 3.122, 3.8/)    ; even number pts
   y  = exp(x)
   result = simpne(x,y)         ; = 40.03341

   X  = (/1.6, 1.7, 2.33, 2.49, 2.75, 3.122, 3.8/)
   Y  = exp(X)
   RESULT = simpne(X,Y)         ; = 39.9082     ; odd number pts

   Example 2

   Assume x is dimensioned ntim and y is dimensioned nloc x ntim. Integrate over time at each location:
   result  = simpne(x,y)         ; result(nloc)

   Example 3

   Assume z is dimensioned lev and f is dimensioned ntim x klev x nlat x mlon with named dimensions "time", "lev", "lat",
   and "lon". Integrate over z:
  result  = simpne(z,f(time|:,lat|:,lon|:,lev|:)) ; result(ntim,nlat,mlon)

   Note: the above mentioned vibeta function may better fit your needs.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:11:14 +0800
# vim:set fdm=indent foldlevel=0:
