THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/sinh.shtml
THE_TITLE:sinh

sinh

   Computes the hyperbolic sine of numeric types.

Prototype

        function sinh (
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

   This function returns the hyperbolic sine of each element of value. Missing values are ignored.

See Also

   cosh, tanh

Examples

   Example 1

  f = 1.4
  sinh_f = sinh(f)
  print(sinh_f)        ; Should be 1.904301


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:11:18 +0800
# vim:set fdm=indent foldlevel=0:
