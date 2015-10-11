THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/stddev.shtml
THE_TITLE:stddev

stddev

   Calculates the sample standard deviation.

Prototype

        function stddev (
                data  : numeric
        )

        return_val [1] :  float or double

Arguments

   data

   A numeric array of any dimensionality.

Return value

   The return value will be a scalar of type double if data is double, and a scalar of type float otherwise.

Description

   This function returns the sample standard deviation of the input data, regardless of dimensionality. Missing values
   (data@_FillValue) are ignored. To determine the number of data points used to calculate the standard deviation, use:
   N = num(.not.ismissing(data))

See Also

   dim_stddev, avg, stat_trim

Examples

   Example 1

   The following calculates the sample standard deviation of 5 values.
  f = (/ 7, 9, -2, -8, 2/)
  std_f = stddev(f)
  print(std_f)

Variable: std_f
Type: float
Total Size: 4 bytes
            1 values
Number of Dimensions: 1
Dimensions and sizes:   [1]
Coordinates:
(0)     6.8775

   Example 2

   The following calculates the sample standard deviation of a (3,5,10) array, f.
  f = onedtond(ispan(1, 150, 1), (/3, 5, 10/))
  stddev_f = stddev(f)
  print(stddev_f)

Variable: stddev_f
Type: float
Total Size: 4 bytes
            1 values
Number of Dimensions: 1
Dimensions and sizes:   [1]
Coordinates:
(0)     43.44537



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:11:54 +0800
# vim:set fdm=indent foldlevel=0:
