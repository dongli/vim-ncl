THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/mixed_layer_depth.shtml
THE_TITLE:mixed_layer_depth

mixed_layer_depth

   Calculates a quantity derived from the Potential Density of significance. (Documentation under construction.)

   [new.gif] Available in version 6.1.0 and later.

Prototype

        function mixed_layer_depth (
                pot_density  : numeric,
                kmt   [*][*] : integer,
                ht    [*][*] : numeric,
                depth    [*] : numeric,
                offset   [1] : numeric
        )

        return_val [dimsizes(ht)] :  float or double

Arguments

   pot_density

   An array of at least three dimensions containing potential density. The last two dimensions of the array must have the
   same number of elements as the dimensions of arguments kmt and ht.
   kmt

   A two-dimensional integer array that contains the index of the lowest valid level at each horizontal location. Its
   dimension sizes must match those of ht and the last two dimensions of pot_density.
   ht

   A two-dimensional float or double array that contains the depth at each horizontal location. Its dimension sizes must
   match those of kmt and the last two dimensions of pot_density.
   depth

   A one-dimensional array containing the depth coordinate value for the third to the last dimension of the pot_density
   array.
   offset

   A scalar quantity that provides a criterion to quantify the depth of the mixed layer at each horizontal location.

Return value

   If pot_density is double, then the return array will be double; otherwise, the return array will be float.

Description

   This function calculates the oceanic mixed layer depth for each horizontal location.

Examples

   Example 1:

   Example 2:


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:07:57 +0800
# vim:set fdm=indent foldlevel=0:
