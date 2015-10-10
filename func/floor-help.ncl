THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/floor.shtml
THE_TITLE:floor

floor

   Computes the largest integer value smaller than the input.

Prototype

        function floor (
                value  : numeric
        )

        return_val [dimsizes(value)] :  float or double

Arguments

   value

   One or more values of any dimension.

Return value

   Returns an array dimensioned the same as value. The return type is double if the input is double, and float otherwise.

Description

   This function returns the largest integer value smaller than value. Missing values are ignored.

See Also

   ceil

Examples

   Example 1

  f       = 6.4
  floor_f = floor(f)
  ceil_f = ceil(f)
  print(floor_f)        ; Should be 6
  print(ceil_f)         ; Should be 7


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:04:23 +0800
# vim:set fdm=indent foldlevel=0:
