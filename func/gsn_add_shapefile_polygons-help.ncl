THE_URL:https://www.ncl.ucar.edu/Document/Graphics/Interfaces/gsn_add_shapefile_polygons.shtml
THE_TITLE:gsn_add_shapefile_polygons

gsn_add_shapefile_polygons

   Attaches shapefile polygon data to the given plot(s) using randomly-filled polygons.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

        function gsn_add_shapefile_polygons (
                wks      [1] : graphic,
                plot     [*] : graphic,
                shp_name [1] : string,
                res      [1] : logical
        )

        return_val [*] :  graphic

Arguments

   wks

   A Workstation identifier. The identifier is one returned either from calling gsn_open_wks or calling create to create a
   Workstation object.
   plot

   A plot identifier created by using one of the many gsn functions, or by calling create to create a View object.

   In version 6.2.1 of NCL, this function was enhanced to allow an array of plot identifiers.
   shp_name

   The name of the shapefile, xxxx.shp that contains polygon data to attach to the given plot(s).
   res

   A variable containing an optional list of polygon resources, attached as attributes. Set to True if you want the attached
   attributes to be applied, and False if you either don't have any resources to set, or you don't want the resources
   applied.

Return value

   An array or scalar representing the id of the polygons attached is returned. If you call any other gsn_add_polyxxxxx
   functions for attaching markers, lines, or polygons, then you must assign each of their return values to a unique
   variable name.

Description

   This function reads in the given shapefile using addfile, reads the lat/lon information off the file, and attaches the
   lat/lon segments as filled polygons to the given plot(s) using gsn_add_polygon. The "geometry_type" global attribute of
   the shapefile must be "polygon".

   The ability to attach the shapefile polylines to multiple input multiple plots was added in V6.2.1.

   The polygons are filled in random colors. You can set the fill color using the gsFillColor resource, but then all
   polygons will be filled in that color.

   This function only attaches the polygons to the plot(s); it doesn't draw them. Hence, you can only see the polygons when
   you call draw or gsn_panel on the plots you attached them to.

   Note: in NCL version 6.2.0, this routine was significantly sped up, because it no longer creates individual objects for
   each polyline or polygon segment added.

   You can use any of the polygon resources in the GraphicStyle object to customize the polygons. Some common ones are:
     * gsFillColor
     * gsEdgesOn
     * gsFillPattern

   If you resize the plots (i.e. by passing the plot to gsn_panel or setting the vpWidthF or vpHeightF resources), then the
   polygons will be automatically resized with each plot.

See Also

   gsn_polygon, gsn_polymarker, gsn_polyline, gsn_polygon_ndc, gsn_polymarker_ndc, gsn_polyline_ndc, gsn_add_polygon,
   gsn_add_polymarker, gsn_add_polyline, gsn_text, gsn_text_ndc, gsn_add_text, gsn_add_shapefile_polylines,
   gsn_add_shapefile_polymarkers, gsn_add_shapefile_polygons, NhlNewMarker, NhlNewDashPattern

Examples

   Example 1

   This example shows how to fill in the indigenous areas of Australia using random colors.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

;----------------------------------------------------------------------
; This function creates a cylindrical equidistant map of Australia
; so you you can add polylines, polygons, or point data to it later.
;----------------------------------------------------------------------
function create_map(wks,title)
local a, res2
begin
  res2               = True
  res2@gsnMaximize   = True
  res2@gsnDraw       = False
  res2@gsnFrame      = False

  res2@mpOutlineOn   = True
  res2@mpFillOn      = False
  res2@mpDataBaseVersion = "MediumRes"

;---Turn on fancier tickmark labels.
  res2@pmTickMarkDisplayMode = "Always"

;---Zoom in on area of interest
  res2@mpLimitMode           = "LatLon"
  res2@mpMinLatF             = -45
  res2@mpMaxLatF             =  -6
  res2@mpMinLonF             = 110
  res2@mpMaxLonF             = 155

  res2@tiMainString          = title

;---Create map.
  map = gsn_csm_map(wks,res2)

  return(map)
end

;----------------------------------------------------------------------
; Main code
;----------------------------------------------------------------------
begin
;
; This shapefile was obtained from:
;
;  http://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/2923.0.30.0012006
;
  filename = "IARE06aAUST_region.shp"

;--- Open workstation.
  wks = gsn_open_wks("x11","shapefiles")

;---Create the map
  map = create_map(wks,"Indigenous Areas")

;---Attach the filled polygons
  pres = True
  poly = gsn_add_shapefile_polygons(wks,map,filename,pres)

;---Drawing the map will also draw the attached polygons.
  draw(map)
  frame(wks)
end


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:22:16 +0800
# vim:set fdm=indent foldlevel=0:
