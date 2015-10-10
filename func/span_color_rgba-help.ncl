THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/span_color_rgba.shtml
THE_TITLE:span_color_rgba

span_color_rgba

   Given the number of desired color values, return an array of RGB triplets or RGBA quadruplets that nicely span the given
   color map.

   [new.gif] Available in version 6.2.0 and later.

Prototype

        function span_color_rgba (
                color_map      ,
                num_colors [1] : integer
        )

Arguments

   color_map

   An NCL predefined color map (like "rainbow", "BlueRed", "matlab_jet"), an RGB array, or an RGBA array.
   num_colors

   The number of color values you want returned.

Return value

   An array of RGB or RGBA values from the given color map.

Description

   This function uses the same spanning algorithm that NCL uses to choose colors for a filled contour or vector plot, given
   a particular color map. It looks at the number of colors you want and the size of your color map, and creates a "nice"
   span across the color map such that it starts at the very first color and ends at the very last color.

   This function can be useful, for example, if you are drawing a scatter plot, where you need to color groups of markers
   based on some range of data they fall in.

   This function will return RGBA values if you give it an RGBA array or a predefined color map, and RGB values if you give
   it an array of RGB values. If you give it a predefined color map, the first two colors (background and foreground colors)
   will not be included.

   To have color index values returned instead, use span_color_indexes.

See Also

   span_color_indexes, get_color_index, get_color_rgba, read_colormap_file, span_named_colors

Examples

   Example 1

   Assume you are using the StepSeq25 predefined color map which has 27 colors (this includes color indexes 0 and 1), and
   that you want 10 nicely spanned colors. You can use span_color_indexes or span_color_rgba:

   icol = span_color_indexes("StepSeq25",10)
   rcol = span_color_rgba("StepSeq25",10)
   print(icol)
   write_matrix(rcol,"4f6.2",0)

   Note that for span_color_indexes, the indexes start at 2 because color indexes 0 and 1 are ignored for predefined
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

   Assume you want 10 colors from only the first half of the the amwg256 predefined color map.

   First you need to read it in with read_colormap_file, and then subscript it as appropriate:

   cmap = read_colormap_file("amwg256")    ; returns 254 x 4 array
   rgba = span_color_rgba(cmap(0:126,:),10)
   write_matrix(rgba,"4f6.2",0)

  0.57  0.44  0.86  1.00
  0.23  0.15  0.81  1.00
  0.05  0.11  0.82  1.00
  0.21  0.35  0.89  1.00
  0.36  0.51  0.93  1.00
  0.51  0.68  0.94  1.00
  0.65  0.85  0.91  1.00
  0.65  0.91  0.95  1.00
  0.60  0.96  0.93  1.00
  0.61  0.80  0.61  1.00


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:11:30 +0800
# vim:set fdm=indent foldlevel=0:
