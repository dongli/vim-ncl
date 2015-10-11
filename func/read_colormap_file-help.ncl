THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/read_colormap_file.shtml
THE_TITLE:read_colormap_file

read_colormap_file

   Reads an NCL system colormap file or a user-defined colormap.

   [new.gif] Available in version 6.1.0 and later.

Prototype

        function read_colormap_file (
                filename  : string
        )

Arguments

   filename

   The name of a colormap from NCL's system colormaps, or the name of a file containing a user-defined color map.

Return value

   A float array of size n x 4 is returned, where n is the number of colors in the colormap. Colors are 4-tuples of red,
   green, blue, opacity values, in the range [0., 1.].

Description

   [Note: in NCL versions 6.1.2 or earlier, you must load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl" to use this
   function. In later versions, you don't need to load anything.]

   This is a convenience function for loading NCL's system colormaps or user-specified colormaps. While general-purpose in
   nature, its primary use-case is loading colormaps that are then assigned to resources such as cnFillPalette,
   cnFillColors, vcLevelPalette, vcLevelColors, stLevelColors, stLevelPalette, or mpFillColors.

   Note that the function always returns 4-component colors, consisting of red/green/blue/opacity values. If the source
   color tables do not contain opacity values, a default of 1.0 (opaque) is returned.

   The function follows all the naming and searching conventions for locating files as described here.

See Also

   draw_color_palette, namedcolor2rgb, gsn_define_colormap span_color_indexes, span_color_rgba, get_color_index,
   get_color_rgba, span_named_colors

Examples

   For several examples of manipulating color using the new color display introduced in NCL V6.1.0, see the "New color
   capabilities" examples page.

   Example 1

   This example shows how to read an existing color map, and then subscript part of it for a filled contour plot:
  cmap = read_colormap_file("BlAqGrYeOrReVi200")
...
  res@cnFillColors = cmap(3:,:)    ; Skips the first two colors

   Example 2

   This example shows how to read an existing color map, and make part of it transparent for a filled contour plot:
  cmap       = read_colormap_file("OceanLakeLandSnow")
...
  cmap(0:1,) = 0.0    ; Make first two blue colors fully transparent
  res@cnFillColors = cmap


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:10:24 +0800
# vim:set fdm=indent foldlevel=0:
