THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/get_color_index.shtml
THE_TITLE:get_color_index

get_color_index

   Chooses a color index for a scalar value, given a color map and a range of values.

   [new.gif] Available in version 6.2.0 and later.

Prototype

        function get_color_index (
                color_map  ,
                levels [*] : numeric,
                value  [1] : numeric
        )

        return_val [1] :  integer

Arguments

   color_map

   An NCL predefined color map (like "rainbow", "BlueRed", "matlab_jet"), an RGB array, or an RGBA array.
   levels

   An array of monotonically increasing numeric values of which to compare the scalar value to.
   value

   A scalar value that you want to calculate the appropriate color index for, based on the given levels.

Return value

   A scalar integer index into the given color map.

Description

   This function uses the same spanning algorithm that NCL uses to choose colors for a filled contour or vector plot, given
   a particular color map and an array of levels. It uses the number of levels you have to create a "nice" span across the
   color map such that it starts at the very first color and ends at the very last color, using close to equal spacing. It
   determines which range the given scalar value falls in, and calculates the appropriate color index to return.

   Here's what the return color indexes mean, given n values in levels:

color index 0 : value < levels(0)
color index 1 : levels(0) <= value < levels(1)
color index 2 : levels(1) <= value < levels(2)
.
.
.
color index n-1 : levels(n-2) <= value < levels(n-1)
color index n : levels(n-1) > value

   The color index value returned will start at 2 or 0, depending on whether you give it a predefined color map or an array
   of RGB/RGBA values. If you give it a predefined color map, then the first two indexes, 0 and 1, are not considered, and
   the index value will start at 2. If you give it an RGB/RGBA array, then it assumes you want to start at the first index
   (index 0).

   The color index values will always end at clen-1, where clen is the number of colors in the given color map.

   If you want to get the full array of color index values based on a set of levels, use span_color_indexes.

   If you want the RGB or RGBA value returned rather than the color index value, use get_color_rgba.

See Also

   span_color_indexes, span_color_rgba, get_color_rgba, read_colormap_file, span_named_colors

Examples

   Example 1

   Get the appropriate color index out of the StepSeq25 color map for various scalar values, when given a range of levels
   from 1 to 10. "StepSeq25" has 27 colors. Note that colors 0 and 1 will not be included:

   levels = ispan(1,10,1)
   icol = get_color_index("StepSeq25",levels,0.5)
   print("color index = " + icol)

   icol = get_color_index("StepSeq25",levels,1.0)
   print("color index = " + icol)

   icol = get_color_index("StepSeq25",levels,9.9)
   print("color index = " + icol)

   icol = get_color_index("StepSeq25",levels,10)
   print("color index = " + icol)

   icol = get_color_index("StepSeq25",levels,10.1)
   print("color index = " + icol)


   The first scalar value was less than the first level, so that index was equal to 2.

  (0)  color index = 2
  (0)  color index = 4
  (0)  color index = 24
  (0)  color index = 26
  (0)  color index = 26

   Example 3

   Get the appropriate color index out of the StepSeq25 color map for various scalar values, when given a range of levels
   from 1 to 10. This example shows how to get the same results from both get_color_rgba and get_color_index.

   cmap_name = "StepSeq25"
   levels    = ispan(1,10,1)
   cmap      = read_colormap_file(cmap_name)
   rcol1     = get_color_rgba(cmap_name,levels,0.0)
   icol1     = get_color_index(cmap_name,levels,0.0)
   rcol2     = get_color_rgba(cmap_name,levels,10.1)
   icol2     = get_color_index(cmap_name,levels,10.1)
;
; Note "icol1-2" instead of "icol1". This is because using get_color_index
; on a predefined color map ignores indexes 0 and 1. But, read_colormap_file
; simply doesn't include color indexes 0 and 1 when it reads the colormap,
; which means color index 0 is really the third color in the predefined
; colormap.
;
   print("rcol1 = " + rcol1 + "/" + cmap(icol1-2,:))
   print("rcol2 = " + rcol2 + "/" + cmap(icol2-2,:))

   Output:

  (0)rcol1 = 0.6/0.6
  (1)rcol1 = 0.0588235/0.0588235
  (2)rcol1 = 0.0588235/0.0588235
  (3)rcol1 = 1/1
  (0)rcol2 = 0.74902/0.74902
  (1)rcol2 = 0.698039/0.698039
  (2)rcol2 = 1/1
  (3)rcol2 = 1/1


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:05:12 +0800
# vim:set fdm=indent foldlevel=0:
