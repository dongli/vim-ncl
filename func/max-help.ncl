THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/max.shtml
THE_TITLE:max

max

   Computes the maximum value of a multi-dimensional array.

Prototype

        function max (
                value  : numeric
        )

        return_val [1] :  numeric

Arguments

   value

   An array of one or more numeric values of any dimension.

Return value

   Returns a scalar of the same type as value.

Description

   This function returns the maximum value for an array of any dimensionality. Missing values are ignored; a missing value
   is returned only if all values are missing.

See Also

   min, minind, maxind, dim_min, dim_max, dim_min_n, dim_max_n

Examples

   Example 1

  f = (/2.1, 3.2, 4.3, 5.4, 6.5, 7.6, 8.7, 9.8/)
  max_f = max(f)
  print(max_f)        ; Should be 9.8


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:07:50 +0800
# vim:set fdm=indent foldlevel=0:
