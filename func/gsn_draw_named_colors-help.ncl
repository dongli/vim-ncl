THE_URL:https://www.ncl.ucar.edu/Document/Graphics/Interfaces/gsn_draw_named_colors.shtml
THE_TITLE:gsn_draw_named_colors

gsn_draw_named_colors

   Draws the given list of named colors.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

        procedure gsn_draw_named_colors (
                wks    [1] : graphic,
                colors [*] : string,
                dims   [2] : integer
        )

Arguments

   wks

   A Workstation identifier. The identifier is one returned either from calling gsn_open_wks or calling create to create a
   Workstation object.
   colors

   A string array of named colors.
   dims

   An array of two elements representing the number of rows and columns to draw the colors in.

Description

   This procedure takes the colors list of named colors, internally sets the color map to this list of colors, and draws
   them in a rows x column format (as specified by dims). This procedure is mostly for debugging purposes.

   After this procedure is called, the workstation is set back to its original color map.

See Also

   draw_color_palette, gsn_draw_colormap, gsn_define_colormap, gsn_reverse_colormap, gsn_retrieve_colormap,
   gsn_merge_colormaps, span_named_colors, namedcolor2rgb

Examples

   Example 1

   This example draws the a set of named colors.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

wks = gsn_open_wks("x11","named_colors")

colors = (/"white", "black", "PeachPuff", "MintCream", "SlateBlue",  \
           "Khaki", "OliveDrab","BurlyWood", "LightSalmon", "Coral", \
           "HotPink", "LemonChiffon", "AliceBlue", "LightGrey",      \
           "MediumTurquoise", "DarkSeaGreen", "Peru", "Tomato",      \
           "Orchid","PapayaWhip"/)

rows = 4
cols = 5
gsn_draw_named_colors(wks,colors,(/rows,cols/))  ; Draw the named colors.

   Example 2

   This draws the same set of named colors using draw_color_palette, which was added in NCL V6.3.0:

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

wks = gsn_open_wks("x11","named_colors")

colors = (/"white", "black", "PeachPuff", "MintCream", "SlateBlue",  \
           "Khaki", "OliveDrab","BurlyWood", "LightSalmon", "Coral", \
           "HotPink", "LemonChiffon", "AliceBlue", "LightGrey",      \
           "MediumTurquoise", "DarkSeaGreen", "Peru", "Tomato",      \
           "Orchid","PapayaWhip"/)

draw_color_palette(wks,colors,False)  ; Draw the named colors.

   See also the suite of color and color map examples.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:23:22 +0800
# vim:set fdm=indent foldlevel=0:
