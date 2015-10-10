THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/rgba_to_color_index.shtml
THE_TITLE:rgba_to_color_index

rgba_to_color_index

   Converts RGBA quadruplets to their encoded integer equivalent absolute color indexes

   [new.gif] Available in version 6.2.0 and later.

Prototype

        function rgba_to_color_index (
                rgba [*][4] : float
        )

        return_val [*]

Arguments

   rgba

   A 2D array of float type rgba values or a single 1D rgba value. The rightmost dimension must have 4 elements, and the
   valid values for each element must be in the range [0.0 - 1.0].

Return value

   A single dimensioned array of absolute integer color indexes.

Description

   This function converts RGBA quadruplets into absolute color index values. RGBA values and absolute color indexes can be
   used interchangeably to set color index type resources. Absolute color indexes specify a particular color independent of
   any workstation color map. Since a single integer color index represents 4 floating point values, it may be more
   convenient or efficient to work with absolute color indexes in some situations.

See Also

   color_index_to_rgba

Examples

   Example 1

   Get and print the absolute color indexes associated with the rgba values in an NCL system colormap.



  cmap_name = "seaice_2"
  cmap = read_colormap_file(cmap_name)
  cix = rgba_to_color_index(cmap)

  print("The " + cmap_name + " colormap has " + dimsizes(cix) + " colors")
  print("rgba value (" + cmap(:,0) + "," + cmap(:,1) + "," + cmap(:,2) + "," + cmap(:,3) +") is represented by color index " + cix
(:))


   Output:


 (0)The seaice_2 colormap has 14 colors
 (0)rgba value (0,0,0.545098,1) is represented by color index 2130706571
 (1)rgba value (0.0352941,0.184314,0.686275,1) is represented by color index 2131308463
 (2)rgba value (0.0980392,0.478431,0.929412,1) is represented by color index 2132376301
 (3)rgba value (0.52549,0.803922,0.976471,1) is represented by color index 2139540985
 (4)rgba value (0.117647,0.980392,0.627451,1) is represented by color index 2132736672
 (5)rgba value (0.678431,1,0.184314,1) is represented by color index 2142109487
 (6)rgba value (0.980392,0.980392,0,1) is represented by color index 2147154432
 (7)rgba value (0.980392,0.733333,0,1) is represented by color index 2147138304
 (8)rgba value (0.980392,0.490196,0,1) is represented by color index 2147122432
 (9)rgba value (0.980392,0,0,1) is represented by color index 2147090432
 (10)rgba value (0.647059,0.164706,0.164706,1) is represented by color index 2141530666
 (11)rgba value (0.470588,0,0.352941,1) is represented by color index 2138570842
 (12)rgba value (0.580392,0,0.827451,1) is represented by color index 2140405971
 (13)rgba value (0.729412,0.333333,0.827451,1) is represented by color index 2142918099



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:10:37 +0800
# vim:set fdm=indent foldlevel=0:
