THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/span_color_indexes.shtml
THE_TITLE:span_color_indexes

span_color_indexes

   Given the number of desired color values, return an array of indexes that nicely span the given color map.

   [new.gif] Available in version 6.2.0 and later.

Prototype

        function span_color_indexes (
                color_map      ,
                num_colors [1] : integer
        )

        return_val [num_colors] :  integer

Arguments

   color_map

   An NCL predefined color map (like "rainbow", "BlueRed", "matlab_jet"), an RGB array, or an RGBA array.
   num_colors

   The number of color index values you want returned.

Return value

   An array of integer indexes into the given color map.

Description

   This function uses the same spanning algorithm that NCL uses to choose colors for a filled contour or vector plot, given
   a particular color map. It looks at the number of colors you want and the size of your color map, and creates a "nice"
   span across the color map such that it starts at the very first color and ends at the very last color.

   This function can be useful, for example, if you are drawing a scatter plot, where you need to color groups of markers
   based on some range of data they fall in.

   The index values returned will start at 2 or 0, depending on whether you give it a predefined color map or an array of
   RGB/RGBA values. If you give it a predefined color map, then the first two indexes, 0 and 1, are not considered, and the
   index values will hence start at index 2. If you give it an RGB/RGBA array, then it assumes you want to start at the
   first index (index 0).

   To have RGB or RGBA values returned instead, use span_color_rgba.

See Also

   span_color_rgba, get_color_index, get_color_rgba, read_colormap_file, span_named_colors

Examples

   Example 1

   Assume you are using the StepSeq25 predefined color map which has 27 colors (this includes color indexes 0 and 1), and
   that you want 10 nicely spanned colors. You can use span_color_indexes or span_color_rgba:

   icol = span_color_indexes("StepSeq25",10)
   rcol = span_color_rgba("StepSeq25",10)
   print(icol)
   write_matrix(rcol,"4f6.2",0)

   Note that for "span_color_indexes", the indexes start at 2 because color indexes 0 and 1 are ignored for predefined
   colormaps:

Variable: icol
Type: integer
Total Size: 40 bytes
            10 values
Number of Dimensions: 1
Dimensions and sizes:   [10]
Coordinates:
(0)     2
(1)     5
(2)     7
(3)     10
(4)     13
(5)     15
(6)     18
(7)     21
(8)     23
(9)     26

  0.60  0.06  0.06  1.00
  0.90  0.49  0.49  1.00
  0.60  0.33  0.06  1.00
  0.90  0.69  0.49  1.00
  0.52  0.70  0.17  1.00
  0.76  0.90  0.49  1.00
  0.17  0.52  0.70  1.00
  0.70  0.90  1.00  1.00
  0.26  0.17  0.70  1.00
  0.75  0.70  1.00  1.00

   Example 2

   Assume you want 20 colors from only the first half of the the amwg256 predefined color map.

   First you need to read it in with read_colormap_file, and then subscript it as appropriate:

   cmap = read_colormap_file("amwg256")    ; returns 254 x 4 array
   icol = span_color_indexes(cmap(0:126,:),20)
   print(icol)

   Note that the indexes start at 0, because you are just giving it an array of RGBA values, and it makes no assumption
   about the first two colors.

Variable: icol
Type: integer
Total Size: 80 bytes
            20 values
Number of Dimensions: 1
Dimensions and sizes:   [20]
Coordinates:
(0)     0
(1)     7
(2)     13
(3)     20
(4)     27
(5)     33
(6)     40
(7)     46
(8)     53
(9)     60
(10)    66
(11)    73
(12)    80
(13)    86
(14)    93
(15)    99
(16)    106
(17)    113
(18)    119
(19)    126


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:11:28 +0800
# vim:set fdm=indent foldlevel=0:
