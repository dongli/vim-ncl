THE_URL:https://www.ncl.ucar.edu/Document/Graphics/Interfaces/gsn_add_shapefile_polymarkers.shtml
THE_TITLE:gsn_add_shapefile_polymarkers

gsn_add_shapefile_polymarkers

   Attaches shapefile point data to the given plot(s) using polymarkers.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

        function gsn_add_shapefile_polymarkers (
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

   The name of the shapefile, xxxx.shp that contains point data to attach to the given plot(s).
   res

   A variable containing an optional list of polymarker resources, attached as attributes. Set to True if you want the
   attached attributes to be applied, and False if you either don't have any resources to set, or you don't want the
   resources applied.

Return value

   An array or scalar representing the id of the polymarkers attached is returned. If you call any other gsn_add_polyxxxxx
   functions for attaching markers, lines, or polygons, then you must assign each of their return values to a unique
   variable name.

Description

   This function reads in the given shapefile using addfile, reads the lat/lon information off the file, and attaches the
   lat/lon segments as polymarkers to the given plot(s) using gsn_add_polymarker. The "geometry_type" global attribute of
   the shapefile must be "point".

   The ability to attach the shapefile polymarkers to multiple input multiple plots was added in V6.2.1.

   This function only attaches the polymarkers to the plot(s); it doesn't draw the plot(s). Hence, you can only see the
   polymarkers when you call draw on the plot(s) you attached them to.

   You can use any of the marker resources in the GraphicStyle object to customize the polymarkers. Some common ones are:
     * gsMarkerIndex
     * gsMarkerColor
     * gsMarkerSizeF
     * gsMarkerThicknessF

   The default marker is an asterisk ('*'). You can change this using the gsMarkerIndex resource and any one of the markers
   in the marker table. You can also create your own marker using the NhlNewMarker function.

   If you resize the plot(s) (i.e. by passing them to gsn_panel or setting the vpWidthF or vpHeightF resources), then the
   polymarkers will be automatically resized with each plot.

See Also

   gsn_polygon, gsn_polymarker, gsn_polyline, gsn_polygon_ndc, gsn_polymarker_ndc, gsn_polyline_ndc, gsn_add_polygon,
   gsn_add_polymarker, gsn_add_polyline, gsn_text, gsn_text_ndc, gsn_add_text, gsn_add_shapefile_polylines,
   gsn_add_shapefile_polymarkers, gsn_add_shapefile_polygons, NhlNewMarker, NhlNewDashPattern

Examples

   Example 1

   This example shows how to add "places of interest" in Australia using point data from a shapefile.

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
;  http://www.mapcruzin.com/free-australia-oceania-arcgis-maps-shapefiles.htm
;
  filename = "places.shp"

;--- Open workstation.
  wks = gsn_open_wks("x11","shapefiles")

;---Create the map
  map = create_map(wks,"Places of interest")

;---Attach the filled polymarkers
  pres               = True
  pres@gsMarkerIndex = 16          ; filled dot
  pres@gsMarkerColor = "green"
  poly = gsn_add_shapefile_polymarkers(wks,map,filename,pres)

;---Drawing the map will also draw the attached polymarkers.
  draw(map)
  frame(wks)
end


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:22:18 +0800
# vim:set fdm=indent foldlevel=0:
