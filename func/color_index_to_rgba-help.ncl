THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/color_index_to_rgba.shtml
THE_TITLE:color_index_to_rgba

color_index_to_rgba

   Converts an absolute color index to its equivalent RGBA quadruplet

   [new.gif] Available in version 6.2.0 and later.

Prototype

        function color_index_to_rgba (
                color_indexes [*] : numeric
        )

        return_val [4]

Arguments

   color_indexes

   An array of absolute color indexes. An absolute color index is an integer with a value between 2^30 (1073741824) and 2^31
   -1 (2147483647) that maps to a unique RGBA quadruplet. Absolute color indexes are independent of the workstation color
   table specified using the resource wkColorMap.

Return value

   An array of unique RGBA quadruplets.

Description

   Absolute color indexes are mainly encountered by an NCL user when retrieving the values of color resources such as
   cnFillColors using the getvalues visualization block. Absolute color indexes are created when setting colors for a plot
   object using any of the palette resources such as cnFillPalette, or when using a named color or an explicit RGBA value to
   set any color index type resource.

   This function converts the absolute color index values to more humanly readable RGBA quadruplets. RGBA values and
   absolute color indexes can be used interchangeably to set color index type resources.

   Note that currently this function does not do any checking to see that the color indexes to be converted are within the
   proper range. In particular, color indexes associated with a workstation color map (in the range 0 - 255) will return
   bogus values.

See Also

   rgba_to_color_index

Examples

   Example 1

   Get and print the RGBA values associated with a color indexes of simple contour fill plot.


  T = generate_2d_array(5,5,0,120,50,(/100,100/))

  wks = gsn_open_wks("png","color_index_to_rgba_example")

  res = True
  res@cnFillPalette   =  "rainbow"
  res@cnFillOn              = True

  plot = gsn_contour(wks,T,res)
  getvalues plot
        "cnFillColors" : fcol
  end getvalues

  rgba = color_index_to_rgba(fcol)

  print("plot has " + dimsizes(fcol) + " colors")
  print("index " + fcol(:) + " represents red: " + rgba(:,0) + " green: " + rgba(:,1) + " blue: " + rgba(:,2) + " alpha: " + rgba(
:,3))


   Output:

  (0)plot has 12 colors
  (0)index 2136211615 represents red: 0.329412 green: 0 blue: 0.623529 alpha: 1
  (1)index 2132869370 represents red: 0.129412 green: 0 blue: 0.980392 alpha: 1
  (2)index 2130725119 represents red: 0 green: 0.282353 blue: 1 alpha: 1
  (3)index 2130752255 represents red: 0 green: 0.698039 blue: 1 alpha: 1
  (4)index 2130771937 represents red: 0 green: 1 blue: 0.882353 alpha: 1
  (5)index 2130771835 represents red: 0 green: 1 blue: 0.482353 alpha: 1
  (6)index 2130771728 represents red: 0 green: 1 blue: 0.0627451 alpha: 1
  (7)index 2136604416 represents red: 0.34902 green: 1 blue: 0 alpha: 1
  (8)index 2143289088 represents red: 0.74902 green: 1 blue: 0 alpha: 1
  (9)index 2147473408 represents red: 1 green: 0.847059 blue: 0 alpha: 1
  (10)index 2147445248 represents red: 1 green: 0.415686 blue: 0 alpha: 1
  (11)index 2147418112 represents red: 1 green: 0 blue: 0 alpha: 1


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:00:20 +0800
# vim:set fdm=indent foldlevel=0:
