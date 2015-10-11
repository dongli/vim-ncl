THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/asin.shtml
THE_TITLE:asin

asin

   Computes the inverse sine of numeric types.

Prototype

        function asin (
                value  : numeric
        )

        return_val [dimsizes(value)] :  float or double

Arguments

   value

   One or more values of any dimension -1.0 <= value <= 1.0

Return value

   Returns an array dimensioned the same as value, in radians. The return type is double if the input is double, and float
   otherwise.

Description

   This function returns the inverse sine of each element of value, in radians. The return array is dimensioned the same as
   value. Missing values are ignored.

See Also

   acos, atan, atan2

Examples

   Example 1

  f = 0.5
  asin_f = asin(f)
  print(asin_f)        ; Should be 0.5235988

Errors

   If value is not -1.0 <= value <= 1.0, nan is returned.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 22:59:21 +0800
# vim:set fdm=indent foldlevel=0:
