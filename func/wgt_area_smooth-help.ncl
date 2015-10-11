THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/wgt_area_smooth.shtml
THE_TITLE:wgt_area_smooth

wgt_area_smooth

   Smooths an array of data using a 5-point 2D area-weighted smoothing algorithm.

   [new.gif] Available in version 6.1.0 and later.

Prototype

        function wgt_area_smooth (
                field      : numeric,
                wgt [*][*] : numeric,
                opt    [1] : logical
        )

        return_val [dimsizes(field)] :  float or double

Arguments

   field

   An array of 2 or more dimensions to be smoothed using a 5-point smoothing algorithm with area weighting. The 2 rightmost
   dimension sizes must match those of the 2D array of area weights.
   wgt

   A 2D array of area weights.
   opt

   A scalar logical value. If False, all attributes take their default value. If True, the following attribute is supported:

   cyclic
          When set True, the first and last elements of the rightmost dimension of the field variable are considered to be
          adjacent to each other, and can therefore be smoothed relative to each other. Otherwise, the first and last
          elements of the rightmost dimension of the output variable are set to the fill value. Defaults to True.

Return value

   The return type is double if the input is double, and float otherwise.

Description

   This function returns a smoothed array with the same dimensionality as the input field array. For each data value (j,i),
   the smoothed value is computed as a weighted average of the five points (j-1,i), (j,i), (j+1,i), (j,i-1), and (j,i+1).

See Also

   smth9, smth9_Wrap


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:15:03 +0800
# vim:set fdm=indent foldlevel=0:
