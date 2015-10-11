THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/sqrt.shtml
THE_TITLE:sqrt

sqrt

   Computes the square root of its input.

Prototype

        function sqrt (
                value  : float or double
        )

        return_val [dimsizes(value)] :  float or double

Arguments

   value

   An array of one or more values >= 0.0

Return value

   Returns an array dimensioned the same as value.

   The return type is floating point if the input is floating point, and double if the input is of type double.

Description

   This function computes the square root of each element of value. Missing values are ignored.

Examples

   Example 1

  f = 12.5
  sqrt_f = sqrt(f)
  print(sqrt_f)        ; Should be 3.535534


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:11:42 +0800
# vim:set fdm=indent foldlevel=0:
