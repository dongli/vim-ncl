THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/draw_color_palette.shtml
THE_TITLE:draw_color_palette

draw_color_palette

   Draws the given colors or color map as a series of filled boxes.

   [new.gif] Available in version 6.3.0 and later.

Prototype

        procedure draw_color_palette (
                wks [1] : graphic,
                colors  ,
                opt [1] : logical
        )

Arguments

   wks

   A Workstation identifier. The identifier is one returned either from calling gsn_open_wks or calling create to create a
   Workstation object.
   colors

   The colors variable can be:
     * an array of color map names ("GMT_jet", "precip2_15lev", etc),
     * a list of named colors, ("red","blue","PeachPuff")
     * an RGB array (n x 3)
     * an RGBA array (n x 4)
       an array of color indexes
       (/2,5,3,8/).

   opt

   If opt is set to True, then you can optionally attach attributes to control the behavior of this procedure:

     * Across - whether to draw the labels across (left-to-right, top-to-bottom) versus down (top-to-bottom, left-to-right)
       Default: True
     * Frame - whether to advance the frame after routine is called
       Default: True
     * LabelsOn - whether to label each box with an index value
       Default: True
     * LabelStrings - the label strings to use instead of an index value
     * LabelFontHeight - The font height of each label
       Default: 0.015

Description

   This procedure draws the given colors as filled boxes with numbers starting at 0. This procedure is useful for examining
   and debugging color maps.

   This procedure is similar to gsn_draw_colormap, which draws the current colormap associated with the workstation.

   There are some notable differences between the two routines:
   draw_color_palette gsn_draw_colormap
   You can draw any number of colors with this routine. This routine is for drawing the color map associated with the
   workstation, so it is limited to 256 colors.
   Colors are drawn left-to-right, top-to-bottom by default. An option can be set to change this. Colors are drawn
   top-to-bottom, left-to-right.
   The background and foreground colors are not included. The background and foreground colors are included.
   The color boxes are scaled to fit the screen. The color boxes are the same size no matter what.
   There are a number of options you can set to control the output. You can't set any options.

See Also

   read_colormap_file, span_named_colors, span_color_indexes, span_color_rgba, gsn_draw_colormap

Examples

   Example 1

   This example shows how to draw two predefined color maps individually and then as one color table.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

  wks = gsn_open_wks("x11","color")
  draw_color_palette(wks,"GMT_jet",False)
  draw_color_palette(wks,"MPL_Paired",False)
  draw_color_palette(wks,(/"MPL_Paired","GMT_jet"/),False)

   Example 2

   This example shows how to use the read_colormap_file to generate an RGBA array from a predefined color map, and then use
   this array to reverse this colormap and then to make the colors 50% transparent.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

  wks = gsn_open_wks("x11","color")

  cmap_name = "MPL_RdYlGn"     ; 128 colors

                                         ; draw original color map
  draw_color_palette(wks,cmap_name,False)

  cmap = read_colormap_file(cmap_name) ;  128 x 4

  cmap = cmap(::-1,:)                    ; reverse the color map
  draw_color_palette(wks,cmap,False)

  cmap(:,3) =  0.5                       ; make colors partially opaque
  draw_color_palette(wks,cmap,False)


   Example 3

   This example shows how to draw a series of named colors with a title included. The special "Frame" option is set to False
   so that the frame is not advanced before the title is added.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

  wks = gsn_open_wks("x11","color")

  opt       = True
  opt@Frame = False
  colors    = (/"red","green","blue","cyan","magenta","yellow"/)
  draw_color_palette(wks, colors, opt)

  txres               = True
  txres@txFontHeightF         = 0.05
  txres@txPerimOn             = True
  txres@txBackgroundFillColor = "white"

  gsn_text_ndc(wks,dimsizes(colors) + " colors",0.5,0.9,txres)
  frame(wks)

  colors := (/ "PapayaWhip", "ForestGreen", "DodgerBlue", "Goldenrod",\
               "gray25", "Brown", "Cyan", "Gray", "Navy", "PeachPuff", \
               "orchid", "beige","gold", "khaki", "plum", "Chocolate", \
               "pink","slategray1", "bisque1","aquamarine3"/)

  draw_color_palette(wks, colors, opt)
  gsn_text_ndc(wks,dimsizes(colors) + " colors",0.5,0.9,txres)
  frame(wks)

  colors := "gray" + ispan(0,100,1)  ; gray0, gray1, ..., gray100
  draw_color_palette(wks, colors, opt)

  gsn_text_ndc(wks,dimsizes(colors) + " grayscale colors",0.5,0.9,txres)
  frame(wks)

   Example 4

   This example uses span_named_colors to create a color map that spans a given list of named colors.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

  wks = gsn_open_wks("x11","color")

  colors = (/"SandyBrown","IndianRed","LightBlue","Purple","Yellow"/)

;----Draw just the five colors, with each one labeled.
  sopt              = True
  sopt@LabelStrings = colors

  draw_color_palette(wks,colors,sopt)

;----Draw a color map that spans the given five colors equally.
  rgb_array = span_named_colors(colors,False)

  draw_color_palette(wks,rgb_array,False)

;----Draw a color map that spans the same given five colors with a different number of colors
  sopt                  = True
  sopt@NumColorsInRange = (/5,20,50,20/)

  rgb_array := span_named_colors(colors,sopt)

  draw_color_palette(wks,rgb_array,False)

   Example 5

   This example shows how to use span_color_rgba to select n colors that span the given predefined color map.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

  wks = gsn_open_wks("x11","color")

  color_map_name = "WhiteBlueGreenYellowRed"
  nlevels         = 100

  opt       = True
  opt@Frame = False

;---Add a title
  txres                       = True
  txres@txFontHeightF         = 0.025

  rgba_full    = read_colormap_file(color_map_name)
  ncolors_full = dimsizes(rgba_full(:,0))

  rgba_partial = span_color_rgba(color_map_name,nlevels)
  draw_color_palette(wks,rgba_partial,opt)

  gsn_text_ndc(wks,color_map_name + " (" + ncolors_full + " originally)",0.5,0.97,txres)
  frame(wks)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:02:35 +0800
# vim:set fdm=indent foldlevel=0:
