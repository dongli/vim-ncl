THE_URL:https://www.ncl.ucar.edu/Document/Graphics/Interfaces/gsn_retrieve_colormap.shtml
THE_TITLE:gsn_retrieve_colormap

gsn_retrieve_colormap

   Retrieves a color map for the given workstation.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

        function gsn_retrieve_colormap (
                wks [1] : graphic
        )

        return_val [*][3] :  float

Arguments

   wks

   A Workstation identifier. The identifier is one returned either from calling gsn_open_wks or calling create to create a
   Workstation object.

Return value

   The return value will be an n x 3 float array, where n is the number of colors in the color map.

Description

   This function retrieves the color map for the given workstation. The color map will be returned as floating point RGB
   triplets. The first two sets of RGB triplets will be the background and foreground colors, respectively.

   Note: retrieving color maps using this function is considered the older (pre NCL V6.1.0) way of dealing with color maps
   in NCL. It is better to use read_colormap_file to read in a predefined color map. See the examples below.

See Also

   read_colormap_file, gsn_define_colormap, gsn_reverse_colormap, gsn_merge_colormaps, gsn_draw_colormap,
   gsn_draw_named_colors, draw_color_palette

Examples

   Example 1 (newer way)

   Retrieve the "BlWhRe" color map and subset it to create a color contour plot that doesn't span the full color map. This
   example shows the newer way of doing it using read_colormap_file. See the next example for an older way of doing this.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

  f      = addfile ("80.nc", "r")
  x      = f->U(0,17,:,:)       ;Grab first timestep, 17th sigma level

  wks = gsn_open_wks("ps","color")
  colors = read_colormap_file("BlWhRe")

  res                      = True
  res@mpGeophysicalLineColor = "gray70"
  res@cnFillOn             = True
  res@cnFillPalette        = colors(8:,:)      ; Subset the color map
  res@cnLinesOn            = False   ; turn off the contour lines
  plot = gsn_csm_contour_map(wks,x,res)

   Example 1 (older way)

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

  f      = addfile ("80.nc", "r")
  x      = f->U(0,17,:,:)       ;Grab first timestep, 17th sigma level

  wks = gsn_open_wks("ps","color")
  gsn_define_colormap(wks,"BlWhRe")  ; use the BlWhRe colormap (instead of default colormap)
  colors = gsn_retrieve_colormap(wks)     ; retrieve color map for editing. dimensioned (103,3)
  colors(102,:) = (/ .68, .68, .68 /)     ; replace the last color with a medium gray
  gsn_define_colormap(wks,colors)         ; redefine colormap to workstation, color map now includes a gray

  res                      = True
  res@mpGeophysicalLineColor = "gray70"            ; draw the map outlines in a medium gray defined above (.68,.68,.68)=~gray70
  res@cnFillOn             = True
  res@gsnSpreadColors      = True                  ; use full colormap
  res@gsnSpreadColorStart  = 10                    ; start at color 10
  res@gsnSpreadColorEnd    = 101                   ; end at color 101
  res@cnLinesOn            = False   ; turn off the contour lines

  plot = gsn_csm_contour_map(wks,x,res)

   See also the suite of color and color map examples.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:23:39 +0800
# vim:set fdm=indent foldlevel=0:
