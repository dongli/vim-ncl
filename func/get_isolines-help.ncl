THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/get_isolines.shtml
THE_TITLE:get_isolines

get_isolines

   Retrieves the points that define a contour line.

   [new.gif] Available in version 6.1.1 and later.

Prototype

        function get_isolines (
                contour_plot_id [1] : graphic,
                levels          [*] : 1D numeric array or scalar string
        )

Arguments

   contour_plot_id

   The contour plot object id from which to retrieve the isoline(s). You do not need to draw the plot object in order to
   retrieve isolines but it must be supplied with valid data.
   levels

   Can be set to the special value "plot", or numeric values that represent the desired isoline level(s).

   See the description below for more information.

Description

   This function retrieves the points that define a contour line or a set of contour lines given an existing contour plot.

   If levels is set to "plot", then all levels that would be drawn with the current setting of cnLevelSelectionMode will be
   retrieved.

   If levels is a scalar number, then the isoline for that particular level is returned as a 2D array variable with a
   printVarSummary that looks like this:
Variable: L0
Type: float
Total Size: 896 bytes
            224 values
Number of Dimensions: 2
Dimensions and sizes:   [yx | 2] x [points | 112]
Coordinates:
Number Of Attributes: 5
  _FillValue :  9.96921e+36
  level :        0
  segment_count :       4
  start_point : ( 0, 28, 56, 84 )
  n_points :    ( 28, 28, 28, 28 )

   The attributes have the following meaning:
     * segment_count - the number of discreet line segments that make up the isoline
     * start_point - an array that points to the beginning point of each segment
     * n_points - the number of points in each segment

   If levels is an array of values, then the return value is a list of array variables that each appear like the variable
   above. The actual value is a 2D array composed of the y and x coordinates of each point in the isoline. The Y coordinates
   are element 0 and the X coordinates are element 1 of the first dimension (dimension number 0).

Examples

   Example 1

   Get the isolines established by the current settings of ContourPlot "cn" resources. Then print statistics about each
   isoline and draw it in the plot space using gsn_polyline:
  isolines = get_isolines(cn,"plot")

  do i = 0, ListCount(isolines) - 1
      iso := isolines[i]
      count = 0
      do j = 0, iso@segment_count -1
          b = iso@start_point(j)
          e = b + iso@n_points(j) - 1
          y := iso(0,b:e)
          x := iso(1,b:e)
          gsn_polyline(wid,cn,x,y,False)
          count = count + iso@n_points(j)
      end do
      print(iso@level + " has " + count + " total points in " + iso@segment_count + " segments" )
  end do

   Example 2

   Here we get the isolines for three specific levels in the data currently set for ContourPlot "cn". Note the levels do not
   need to be levels that are set in the cnLevels resource. If any specified level is not in the range of the data currently
   attached to the ContourPlot a missing value will be returned for that level. Once again print statistics about each
   isoline aand draw it in the plot space using gsn_polyline:
  isolines = get_isolines(cn,(/ 30.0, 45.0, 47.5 /))
  do i = 0, ListCount(isolines) - 1
      iso := isolines[i]
      count = 0
      do j = 0, iso@segment_count -1
          b = iso@start_point(j)
          e = b + iso@n_points(j) - 1
          y := iso(0,b:e)
          x := iso(1,b:e)
          gsn_polyline(wid,cn,x,y,False)
          count = count + iso@n_points(j)
      end do
      print(iso@level + " has " + count + " total points in " + iso@segment_count + " segments" )
  end do

   Example 3

   Get a single level. Notice that in this case the return value is an array rather than a list of arrays:
  isoline = get_isolines(cn, 77.8)
  count = 0
  do i = 0, isoline@segment_count -1
      b = isoline@start_point(i)
      e = b + isoline@n_points(i) - 1
      y := isoline(0,b:e)
      x := isoline(1,b:e)
      gsn_polyline(wid,cn,x,y,False)
      count = count + isoline@n_points(i)
  end do
  print(isoline@level + " has " + count + " total points in " + isoline@segment_count + " segments" )



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:05:15 +0800
# vim:set fdm=indent foldlevel=0:
