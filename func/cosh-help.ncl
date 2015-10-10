THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/cosh.shtml
THE_TITLE:cosh

cosh

   Computes the hyperbolic cosine of numeric types.

Prototype

        function cosh (
                value  : numeric
        )

        return_val [dimsizes(value)] :  float or double

Arguments

   value

   One or more values of any dimension, in radians.

Return value

   Returns an array dimensioned the same as value.

   The return type is floating point if the input is floating point, and double if the input is of type double.

Description

   This function returns the hyperbolic cosine of each element of value. Missing values are ignored.

See Also

   sinh tanh

Examples

   Example 1

  f = -3.2
  cosh_f = cosh(f)
  print(cosh_f)        ; Should be 12.28665


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:00:24 +0800
# vim:set fdm=indent foldlevel=0:
