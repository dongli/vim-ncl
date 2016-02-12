THE_URL:https://www.ncl.ucar.edu/Document/Graphics/Interfaces/gsn_coordinates.shtml
THE_TITLE:gsn_coordinates

gsn_coordinates

   Draws or attaches the data coordinate locations on the given plot as grid lines or markers.

   [new.gif] Available in version 6.1.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

        procedure gsn_coordinates (
                wks  [1] : graphic,
                plot [1] : graphic,
                data     : numeric,
                res      : logical
        )

Arguments

   wks

   A Workstation identifier. The identifier is one returned either from calling gsn_open_wks or calling create to create a
   Workstation object.
   plot

   The plot identifier on which to draw the coordinates. It can be created by using one of the many gsn functions, or by
   calling create to create a View object.

   data

   The data array that contains the coordinates to be drawn, either as 1D coordinate arrays, as special "lat2d"/"lon2d"
   attributes, or, (as of NCL 6.2.0) as special "lat1d"/"lon1d" attributes. If there are no coordinates associated with the
   data, then see the special "gsnCoordsLat"/"gsnCoordsLon" and "gsnCoordsX"/"gsnCoordsY" attributes below.
   res

   A logical variable containing an optional list of resources for drawing the coordinates. Set to True if you want the
   attached attributes to be applied, and False if you either don't have any resources to set, or you don't want the
   resources applied.

Description

   This function draws the given plot and the coordinate locations associated with data on the plot as either markers (the
   default) or lines. This can be useful for debugging purposes, if you want to see what your data grid looks like, or you
   need to see at which coordinate locations you have missing values.

   If gsnCoordsAttach is set to False, then the lines or markers will be attached to plot, and nothing will get drawn until
   you draw the plot. This is mainly useful for if you need to draw the plot later, say in a panel plot.

   The res variable can contain the following special attributes:

   gsnCoordsLat / gsnCoordsLon (or gsnCoordsY / gsnCoordsX)
          If your input data array doesn't have one-dimensional coordinate arrays or the special "lat2d"/"lon2d" or
          "lat1d"/"lon1d" attributes attached, then you can use either of these two attribute pairs to set the coordinates
          for the X and Y axis. These two arrays must both be the same dimensionality.

   gsnCoordsNonMissingColor
          If drawing the coordinates as markers, this attribute indicates a color to draw the locations of the non-missing
          data.

   gsnCoordsMissingColor
          If drawing the coordinates as markers, this attribute indicates a color to draw the locations of the missing data.

   gsnCoordsAsLines
          If set to True, the coordinates will be drawn as a lat/lon grid. The default is to draw the grid with markers
          (filled dots).

   gsnCoordsAttach
          By default, the markers or lines are drawn with gsn_polymarker or gsn_polyline and are not attached to the plot.
          If you need to attach the markers or lines (perhaps for paneling the plot later), then set this attribute to True.

   There are some "gs" resources (associated with markers and lines) that you can set to customize the markers or lines:

     * gsMarkerIndex - the default marker used for this routine is marker #16, a filled dot. You can create your own marker
       using NhlNewMarker, or use a different one from the marker table.
     * gsMarkerColor - set this to change the marker color. You can use a named color or a color index number.
     * gsLineColor - set this to change the line color. You can use a named color or a color index number.
     * gsLineThicknessF - set this to change the line thickness. The default is 1.
     * gsLineDashPattern - set this ato change the style of grid lines. The default is a solid line. You can use a dash
       pattern from the existing dash pattern table, or you can create your own using NhlNewDashPattern.

See Also

   gsn_add_polymarker, gsn_add_polyline, gsn_polymarker, gsn_polyline

Examples

   This example draws a lat/lon grid over a contour plot.
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin
;---Read netCDF file
  f = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/uv300.nc","r")
  u = f->U(1,:,:)

;---Start the graphics.
  wks = gsn_open_wks("x11","mapgrid")

  res               = True                        ; plot mods desired
  res@gsnMaximize   = True                        ; maximize plot size
  res@gsnDraw       = False                       ; don't draw yet
  res@gsnFrame      = False                       ; don't advance frame

;---Create map (don't draw it yet)
  map = gsn_csm_contour_map(wks,res)

;---Call function to draw lat/lon lines.
  pres                   = True
  pres@gsnCoordsAsLines  = True        ; Default is points
  gsn_coordinates(wks,map,u,pres)
end


   See also the suite of map lat/lon grid examples.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:22:26 +0800
# vim:set fdm=indent foldlevel=0:
