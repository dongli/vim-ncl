THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/tanh.shtml
THE_TITLE:tanh

tanh

   Computes the hyperbolic tangent of numeric types.

Prototype

        function tanh (
                value  : numeric
        )

        return_val [dimsizes(value)] :  float or double

Arguments

   value

   One or more floating-point values of any dimension, in radians.

Return value

   Returns an array dimensioned the same as value.

   The return type is floating point if the input is floating point, and double if the input is of type double.

Description

   This function returns the hyperbolic tangent of each element of value. Missing values are ignored.

See Also

   sinh, cosh

Examples

   Example 1

  f = 0.67
  tanh_f = tanh(f)
  print(tanh_f)        ; Should be 0.5849799


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:12:55 +0800
# vim:set fdm=indent foldlevel=0:
