THE_URL:https://www.ncl.ucar.edu/Document/Graphics/Interfaces/gsn_histogram.shtml
THE_TITLE:gsn_histogram

gsn_histogram

   Draws a histogram plot on the given workstation.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

        function gsn_histogram (
                wks     : graphic,
                data    : numeric,
                res [1] : logical
        )

        return_val [1] :  graphic

Arguments

   wks

   A Workstation identifier. The identifier is one returned either from calling gsn_open_wks or calling create to create a
   Workstation object.
   data

   The data for the histogram. The data must either be one-dimensional for a single histogram, or two-dimensional where two
   histogram fields are drawn.
   res

   A variable containing an optional list of resources to apply to the histogram, attached as attributes. Set to True if you
   want the attached attributes to be applied, and False if you either don't have any resources to set, or you don't want
   the resources applied.

Return value

   A scalar id of the histogram plot created is returned. In addition, several attributes are returned:
     * NumInBins - an array of the number of items in each bin.
     * BinLocs - an array of the values of the bin locations. This will be the end points of each bin if you have intervals,
       or the actual values if you have discrete values.
     * NumMissing - the number of missing values (if any).
     * Percentages - an array of percentages indicating the distribution of the bin values (missing values are counted in
       total)
     * PercentagesNoMissing - an array of percentages indicating the distribution of the bin values (missing values are not
       counted in total)

   The following three attributes contain X locations of the bars so you can annotate them as necessary. See example 12 on
   the histogram applications page.

     * BeginBarLocs - an array indicating the X positions of the beginning location of each bar.
     * MidBarLocs - an array indicating the X positions of the mid point location of each bar.
     * EndBarLocs - an array indicating the X positions of the end location of each bar.

Description

   This function draws a histogram plot, where values in the given data are binned into equally-spaced intervals. The
   intervals will be selected for you, based on the range of the data, unless you set the gsnHistogramBinIntervals resource
   to the desired list of interval values.

   The data values will be binned as follows (assume there are n interval values, and thus n-1 bins):
  bin1   <= data < bin2
  bin2   <= data < bin3
  ...
  binn-2 <= data < binn-1
  binn-1 <= data <= binn

   Note that the last interval is treated specially. This is intentional, to make sure that all data values that fall
   inclusively between the lowest and highest intervals are binned.

   You can set the gsnHistogramMinMaxBinsOn resource to True to slightly alter the behavior of the binning as follows. This
   will effectively cause all of your data to be binned in the following fashion:

  data   <  bin1
  bin1   <= data < bin2
  bin2   <= data < bin3
  ...
  binn-1 <= data < binn
  binn   <= data

   To bin your data based on discrete values rather than intervals, use the gsnHistogramDiscreteBinValues resource.

   Two histogram fields are drawn if data is two-dimensional. If missing values are encountered in data, then they are
   ignored.

   There are many resources specific to this function. See the gsnHistogram resources for a full list.

   To maximize the area that the plot is drawn in, set the special resource gsnMaximize to True.

See Also

   bin_sum, bin_avg
   Special gsn resources

   ndtooned,pdfx

Examples

   Example 1

   The example below shows how to bin values between the given intervals. This script should produce two plots, each with
   three bars. The first plot will have bars all equal to 2. The second plot will have three bars with 2, 2, and 4 values
   respectively.
  wks = gsn_open_wks("x11","histogram")

  res                          = True
  res@gsnMaximize              = True
  res@gsnHistogramBinIntervals = (/1,2,5,7/)

  data = (/1,1.5,2,2.5,5.5,7/)
  plot = gsn_histogram(wks,data,res)

  data := (/1,1,2,2,5,5,7,7/)
  plot = gsn_histogram(wks,data,res)

   Example 2

   This example uses the same data as above, but with a different set of intervals and with gsnHistogramMinMaxBinsOn set to
   True.

   This script should produce two plots, each with five bars. The first plot will have bar values of 2, 2, 1, and 1,
   respectively, and the second plot will have 2 values in each bar.

  wks = gsn_open_wks("x11","histogram")

  res                          = True
  res@gsnMaximize              = True
  res@gsnHistogramBinIntervals = (/2,4,6/)
  res@gsnHistogramMinMaxBinsOn = True

  data = (/1,1.5,2,2.5,5.5,7/)
  plot = gsn_histogram(wks,data,res)

  data := (/1,1,2,2,5,5,7,7/)
  plot = gsn_histogram(wks,data,res)

   Example 3

   The example below shows how to bin values exactly equal to the given values. This script should produce a plot with four
   bars with 3, 2, 1, and 0 values respectively.
  wks = gsn_open_wks("x11","histogram")

  res                               = True
  res@gsnMaximize                   = True
  res@gsnHistogramDiscreteBinValues = (/1,2,5,7/)

  data = (/1,2.5,8.,2.1,3,5,4.2,1,1.2,0.5,2,2.5,1,5.5,2.0/)
  plot = gsn_histogram(wks,data,res)

   Example 4

   Assume you have a multi-dimensional array, x(time,lat,lon), and that a histogram of the entire array is desired. The
   function ndtooned can be used to reshape the array.

   plot = gsn_histogram(wks,ndtooned(x),False)

   Example 5

   If the "x" array from the previous example has lat/lon coordinate arrays, then you can plot a histogram for values
   between 30 south and 30 north latitude using coordinate subscripting:

  plot = gsn_histogram(wks,ndtooned(x(:,{-30:30},:)),False)

   For some more examples, see the suite of histogram plot examples.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:23:23 +0800
# vim:set fdm=indent foldlevel=0:
