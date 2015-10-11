THE_URL:https://www.ncl.ucar.edu/Document/Graphics/Interfaces/gsn_define_colormap.shtml
THE_TITLE:gsn_define_colormap

gsn_define_colormap

   Defines a color map for the given workstation.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

        procedure gsn_define_colormap (
                wks    [1] : graphic,
                color_map
        )

Arguments

   wks

   A Workstation identifier. The identifier is one returned either from calling gsn_open_wks or calling create to create a
   Workstation object.
   color_map

   Can be a string array of named colors, an array of red/blue/green (RGB) triplets, or a predefined color map.

Description

   This procedure sets a color map for the given workstation. If no color map is set, then a default color map is used.

   color_map can be a string array of named colors, an array of red/blue/green (RGB) triplets, or a predefined color map.

   You can use the gsn_draw_colormap or draw_color_palette or procedure to draw the color map (useful for debugging
   purposes).

   If you want to define a colormap using a combination of RGB triplets and named colors, you can do so by enclosing values
   in quotes (see example below).

   Note: in NCL Version 6.1.0, the default color map was changed from one called "default" which only had 32 colors, to one
   called "ncl_default" which has 256 colors:

        ncl_default (newer)           default (older)
   [ncl_default_labelbar.sm.png] [default_labelbar.sm.png]

   Second note: setting a color map for a workstation is considered the older (pre NCL V6.1.0) way of dealing with color
   maps in NCL. It is better to use read_colormap_file to read in a predefined color map, and then associate that color map
   with a color contour, vector, or streamline plot using the resources cnFillPalette, vcLevelPalette, or stLevelPalette.

See Also

   read_colormap_file, draw_color_palette, gsn_retrieve_colormap, gsn_reverse_colormap, gsn_merge_colormaps,
   gsn_draw_colormap, gsn_draw_named_colors, span_named_colors, namedcolor2rgb, hsvrgb

Examples

   To see how to use several of the color functions, run the following example:
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

begin
  wks = gsn_open_wks("x11","color")

  gsn_define_colormap(wks,"BlueRed")
  gsn_draw_colormap(wks)              ; Draw the color map.
  gsn_reverse_colormap(wks)            ; Reverse the color map.
  gsn_draw_colormap(wks)              ; Draw the new color map.
end

   Example 1 - using newer method

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

begin
  wks = gsn_open_wks("x11","color")

  draw_color_palette(wks,"BlueRed",False)
  cmap = read_colormap_file("BlueRed")
  draw_color_palette(wks,cmap(::-1,:),False)
end

   Example 2

   To define a color map using a combination of RGB triplets and named colors, enclose each value in quotes:
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

begin
  wks = gsn_open_wks("x11","color")

  cmap = (/"(/1.00, 1.00, 1.00/)", "(/0.00, 0.00, 0.00/)", \
           "(/.560, .500, .700/)", "(/.300, .300, .700/)", \
           "(/.100, .100, .700/)", "(/.000, .100, .700/)", \
           "(/.000, .300, .700/)", "(/.000, .500, .500/)", \
           "(/.000, .700, .100/)", "(/.060, .680, .000/)", \
           "(/.550, .550, .000/)", "(/.570, .420, .000/)", \
           "(/.700, .285, .000/)", "(/.700, .180, .000/)", \
           "(/.870, .050, .000/)", "(/1.00, .000, .000/)", \
           "CadetBlue", "Ivory", "LimeGreen", "DarkSalmon"/)

  gsn_define_colormap(wks,cmap)
  gsn_draw_colormap(wks)
end

   See also the suite of color and color map examples.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:23:19 +0800
# vim:set fdm=indent foldlevel=0:
