THE_URL:https://www.ncl.ucar.edu/Document/Graphics/Interfaces/gsn_polygon.shtml
THE_TITLE:gsn_polygon

gsn_polygon

   Draws a filled polygon on the given plot.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

        procedure gsn_polygon (
                wks  [1] : graphic,
                plot [1] : graphic,
                x    [*] : numeric,
                y    [*] : numeric,
                res  [1] : logical
        )

Arguments

   wks

   A Workstation identifier. The identifier is one returned either from calling gsn_open_wks or calling create to create a
   Workstation object.
   plot

   A plot identifier created by using one of the many gsn functions, or by calling create to create a View object.
   x
   y

   One-dimensional arrays of the same length containing the X and Y coordinates of the polygon, and must be in the range of
   the X/Y coordinates of the data in plot. If drawing the polygon on a map, then X should correspond to longitude values,
   and Y to latitude values.
   res

   A variable containing an optional list of polygon resources, attached as attributes. Set to True if you want the attached
   attributes to be applied, and False if you either don't have any resources to set, or you don't want the resources
   applied.

Description

   If a missing value is encountered in x and/or y, then this pair is ignored (the polygon will still be closed).

   There are many fill patterns available, and you can use the gsFillIndex resource to change the fill pattern. The default
   is a solid fill. You can change the color of the fill via the gsFillColor resource.

   If you want to resize the plot (i.e. by passing the plot to gsn_panel or setting the vpWidthF or vpHeightF resources),
   then use the function gsn_add_polygon. This will cause the polygon to be attached to the given plot, and hence
   automatically resized when the plot is resized.

   Note: there is a potential incompatible change in NCL version 6.2.0, when attaching lines or polygons to a map. This
   change affects gsn_polyline, gsn_add_polyline, gsn_polygon, and gsn_add_polygon.

   Previously, drawing a polyline around the equator, for example, could be specified using 2-element arrays. For example:

  lnid = gsn_add_polyline(wks,map,(/0,360/),(/0,0/),lnres)

   Now, however, in order to eliminate a number of ambiguous situations and to make user code simpler in most cases, a new
   behavior has been introduced: the line between two points on the globe always follows the shortest path. In the example
   above, the behavior in NCL V6.2.0 leads to a 0-length line. The recommended approach now for drawing a line around the
   equator is to use four points, such that the distance from one to the next is always less than 180 degrees. For example:

  lnid = gsn_add_polyline(wks,map,(/0,120,240,360/),(/0,0,0,0/),lnres)

See Also

   gsn_polygon, gsn_polymarker, gsn_polyline, gsn_polygon_ndc, gsn_polymarker_ndc, gsn_polyline_ndc, gsn_add_polygon,
   gsn_add_polymarker, gsn_add_polyline, gsn_text, gsn_text_ndc, gsn_add_text, gsn_add_shapefile_polylines,
   gsn_add_shapefile_polymarkers, gsn_add_shapefile_polygons, NhlNewMarker, NhlNewDashPattern

Examples

   For some application examples, see:
     * "polyg_2.ncl" (view example)

   Also, see the suite of polygon examples.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:23:31 +0800
# vim:set fdm=indent foldlevel=0:
