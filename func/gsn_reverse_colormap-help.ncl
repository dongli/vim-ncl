THE_URL:https://www.ncl.ucar.edu/Document/Graphics/Interfaces/gsn_reverse_colormap.shtml
THE_TITLE:gsn_reverse_colormap

gsn_reverse_colormap

   Reverses the color map for the given workstation.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

        procedure gsn_reverse_colormap (
                wks [1] : graphic
        )

Arguments

   wks

   A Workstation identifier. The identifier is one returned either from calling gsn_open_wks or calling create to create a
   Workstation object.

Description

   This procedure reverse the color map for the given workstation, keeping the foreground and background colors the same.

   Note: reversing color maps using this function is considered the older (pre NCL V6.1.0) way of dealing with color maps in
   NCL. It is better to use read_colormap_file to read a predefined color map and then the "::-1" syntax to reverse it. See
   the examples below.

See Also

   read_colormap_file, draw_color_palette, gsn_define_colormap, gsn_retrieve_colormap, gsn_merge_colormaps,
   gsn_draw_colormap, gsn_draw_named_colors

Examples

   Example 1 (newer way)

   Draw the BlueRed color map, and then reverse it and draw it again.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

  wks = gsn_open_wks("x11","color")

  draw_color_palette(wks,"BlueRed",False)

  cmap = read_colormap_file("BlueRed")   ; read the color map
  draw_color_palette(wks,cmap(::-1,:),False)      ; draw the reversed color map

   Example 1 (older way)

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

  wks = gsn_open_wks("x11","color")

  gsn_define_colormap(wks,"BlueRed")
  gsn_draw_colormap(wks)              ; Draw the color map.
  gsn_reverse_colormap(wks)           ; Reverse the color map.
  gsn_draw_colormap(wks)              ; Draw the new color map.

   See also the suite of color and color map examples.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:23:40 +0800
# vim:set fdm=indent foldlevel=0:
