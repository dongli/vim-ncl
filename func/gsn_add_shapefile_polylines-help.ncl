THE_URL:https://www.ncl.ucar.edu/Document/Graphics/Interfaces/gsn_add_shapefile_polylines.shtml
THE_TITLE:gsn_add_shapefile_polylines

gsn_add_shapefile_polylines

   Attaches shapefile polyline or polygon data to the given plot(s) using polylines.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

        function gsn_add_shapefile_polylines (
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

   The name of the shapefile, xxxx.shp that contains polygon or polyline data to attach to the given plot(s).
   res

   A variable containing an optional list of polyline resources, attached as attributes. Set to True if you want the
   attached attributes to be applied, and False if you either don't have any resources to set, or you don't want the
   resources applied.

Return value

   An array or scalar representing the id of the polylines attached is returned. If you call any other gsn_add_polyxxxxx
   functions for attaching markers, lines, or polygons, then you must assign each of their return values to a unique
   variable name.

Description

   This function reads in the given shapefile using addfile, reads the lat/lon information off the file, and attaches the
   lat/lon segments as polylines to the given plot(s) using gsn_add_polyline. The "geometry_type" global attribute of the
   shapefile must be "polygon" or "polyline".

   The ability to attach the shapefile polylines to multiple input multiple plots was added in V6.2.1.

   This function only attaches the polylines to the plot(s); it doesn't draw the plot(s). Hence, you can only see the
   polylines when you call something like draw or gsn_panel on the plots you attached them to.

   Note: in NCL version 6.2.0, this routine was significantly sped up, because it no longer creates individual objects for
   each polyline or polygon segment added.

   You can use any of the line resources in the GraphicStyle object to customize the polylines. Some common ones are:
     * gsLineColor
     * gsLineDashPattern
     * gsLineThicknessF

   If you resize the plots (i.e. by passing them to gsn_panel or setting the vpWidthF or vpHeightF resources), then the
   polylines will be automatically resized with each plot.

See Also

   gsn_polygon, gsn_polymarker, gsn_polyline, gsn_polygon_ndc, gsn_polymarker_ndc, gsn_polyline_ndc, gsn_add_polygon,
   gsn_add_polymarker, gsn_add_polyline, gsn_text, gsn_text_ndc, gsn_add_text, gsn_add_shapefile_polylines,
   gsn_add_shapefile_polymarkers, gsn_add_shapefile_polygons, NhlNewMarker, NhlNewDashPattern

Examples

   Example 1

   This example shows how to add "river basins" in Australia using polyline from a shapefile.

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
;  http://e-atlas.org.au/content/au-ga-river-basins-1997
;
  filename = "rbasin_chain.shp"

;--- Open workstation.
  wks = gsn_open_wks("x11","shapefiles")

;---Create the map
  map = create_map(wks,"Places of interest")

;---Attach the polylines
  pres             = True
  pres@gsLineColor = "blue"
  poly = gsn_add_shapefile_polylines(wks,map,filename,pres)

;---Drawing the map will also draw the attached polylines.
  draw(map)
  frame(wks)
end

   Example 2

   This example shows how to add several administrative areas to a map of Australia. The shapefiles were downloaded from
   http://www.gadm.org/country.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin
  wks = gsn_open_wks("x11","coast")   ;   Open X11 window

  res               = True
  res@gsnMaximize   = True
  res@gsnDraw       = False
  res@gsnFrame      = False

  res@mpOutlineOn   = False
  res@mpFillOn      = False

;---Turn on fancier tickmark labels.
  res2@pmTickMarkDisplayMode = "Always"

;---Zoom in on Australia
  res@mpLimitMode           = "LatLon"
  res@mpMinLatF             = -45
  res@mpMaxLatF             =  -6
  res@mpMinLonF             = 110
  res@mpMaxLonF             = 155

;---Create map
  map = gsn_csm_map(wks,res)

;---Attach three different sets of shapefile outlines to map
  lnres                  = True
  lnres@gsLineColor      = "brown"
  lnres@gsLineThicknessF = 1.0

  map = gsn_add_shapefile_polylines(wks,map,"AUS_adm/AUS_adm2.shp",lnres)

  lnres@gsLineColor      = "purple"
  lnres@gsLineThicknessF = 2.0

  map = gsn_add_shapefile_polylines(wks,map,"AUS_adm/AUS_adm1.shp",lnres)

  lnres@gsLineColor      = "blue"
  lnres@gsLineThicknessF = 3.0

  map = gsn_add_shapefile_polylines(wks,map,"AUS_adm/AUS_adm0.shp",lnres)

  draw(map)
  frame(wks)
end

   Example 3

   This example is similar to the previous one, except it shows how to add one administrative area to four maps of
   Australia.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin
  wks = gsn_open_wks("x11","coast")   ;   Open X11 window

  res               = True
  res@gsnMaximize   = True
  res@gsnDraw       = False
  res@gsnFrame      = False

  res@mpOutlineOn   = False
  res@mpFillOn      = False

;---Turn on fancier tickmark labels.
  res2@pmTickMarkDisplayMode = "Always"

;---Zoom in on Australia
  res@mpLimitMode           = "LatLon"
  res@mpMinLatF             = -45
  res@mpMaxLatF             =  -6
  res@mpMinLonF             = 110
  res@mpMaxLonF             = 155

;---Create maps
  maps = new(4,graphic)
  do i=0,3
    maps(i) = gsn_csm_map(wks,res)
  end do

;---Attach the AUS_adm2.shp  shapefile outlines to each map
  lnres                  = True
  lnres@gsLineColor      = "brown"
  lnres@gsLineThicknessF = 1.0

  shpid = gsn_add_shapefile_polylines(wks,maps,"AUS_adm/AUS_adm2.shp",lnres)

  pres = True
  gsn_panel(wks,map,(/2,2/),pres)
end


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:22:17 +0800
# vim:set fdm=indent foldlevel=0:
