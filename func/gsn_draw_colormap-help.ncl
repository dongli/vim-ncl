THE_URL:https://www.ncl.ucar.edu/Document/Graphics/Interfaces/gsn_draw_colormap.shtml
THE_TITLE:gsn_draw_colormap

gsn_draw_colormap

   Draws the current color map for the given workstation.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

        procedure gsn_draw_colormap (
                wks [1] : graphic
        )

Arguments

   wks

   A Workstation identifier. The identifier is one returned either from calling gsn_open_wks or calling create to create a
   Workstation object.

Description

   This procedure draws the color map for the given workstation (mostly for reference and debugging purposes). The colors
   are draw as filled boxes labeled with the corresponding index value.

   For a more flexible procedure for drawing colors and color maps, see read_color_palette. This procedure allows you to
   draw a set of colors or a color map without first having to set them using gsn_define_colormap.

   There are some differences between gsn_define_colormap and draw_color_palette:

   gsn_define_colormap draw_color_palette
   The background / foreground colors are included The background / foreground colors are not included
   Colors are drawn top-to-bottom, left to right Colors are drawn left to right, top-to-bottom
   The filled boxes are the same size no matter how many colors you have The filled boxes are sized to fill up the frame
   There are no options you can set to control how the colors are drawn There are options you can set to control how the
   colors are drawn (for example, to remove the number labels, to draw colors vertically instead of horizontally, etc)

See Also

   draw_color_palette, gsn_define_colormap, gsn_reverse_colormap, gsn_retrieve_colormap, gsn_merge_colormaps,
   gsn_draw_named_colors

Examples

   Example 1 (newer way)

   Draw the MPL_Paired color map, and then reverse it and draw it again.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

  wks = gsn_open_wks("x11","color")

  draw_color_palette(wks,"MPL_Paired",False)

  cmap = read_colormap_file("MPL_Paired")   ; read the color map
  draw_color_palette(wks,cmap(::-1,:),False)      ; draw the reversed color map


   Example 1 (older way)

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

  wks = gsn_open_wks("x11","color")

  gsn_define_colormap(wks,"MPL_Paired")
  gsn_draw_colormap(wks)              ; Draw the color map.
  gsn_reverse_colormap(wks)           ; Reverse the color map.
  gsn_draw_colormap(wks)              ; Draw the new color map.

   See also the suite of color and color map examples.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:23:20 +0800
# vim:set fdm=indent foldlevel=0:
