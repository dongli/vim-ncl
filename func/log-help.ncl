THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/log.shtml
THE_TITLE:log

log

   Computes the natural log of a numeric type.

Prototype

        function log (
                value  : numeric
        )

        return_val [dimsizes(value)] :  float or double

Arguments

   value

   An array of one or more values of any dimension value > 0.0

Return value

   Returns a floating point array dimensioned the same as value.

   The return type is floating point if the input is floating point, and double if the input is of type double.

Description

   This function returns the natural logarithm of each element of value. Missing values are ignored.

See Also

   exp log10

Examples

   Example 1

  f = 3.6
  log_f = log(f)
  print(log_f)        ; Should be 1.280934

   Example 2: Find the cube root of 3112.136 [=x^3]

  x = exp( log(3112.136)/3.0 )
  print( x )        ; Should be 14.6

   Example 3: Solve the following for x: y = 9.328*(0.729-x^3) - 1.8

   y = 2.0
   x = exp( log(0.729-((y+1.8)/9.328))/3.0 )  ; = 0.685


Errors

   If value < 0.0, nan is returned.

   If value = 0.0, -inf is returned.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:07:38 +0800
# vim:set fdm=indent foldlevel=0:
