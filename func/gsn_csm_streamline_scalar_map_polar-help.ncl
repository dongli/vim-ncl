THE_URL:https://www.ncl.ucar.edu/Document/Graphics/Interfaces/gsn_csm_streamline_scalar_map_polar.shtml
THE_TITLE:gsn_csm_streamline_scalar_map_polar

gsn_csm_streamline_scalar_map_polar

   Creates and draws a streamline plot over a polar stereographic map, using a scalar field to color the streamlines.

   [new.gif] Available in version 6.3.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

        function gsn_csm_streamline_scalar_map_polar (
                wks     [1] : graphic,
                u    [*][*] : numeric,
                v    [*][*] : numeric,
                data [*][*] : numeric,
                res     [1] : logical
        )

        return_val [1] :  graphic

Arguments

   wks

   A Workstation identifier. The identifier is one returned either from calling gsn_open_wks or calling create to create a
   Workstation object.
   u
   v

   The u and v data for the streamline plot; must be two-dimensional.
   data

   The data field for which to color the streamlines by; must be one- or two-dimensional.
   res

   A variable containing an optional list of plot resources, attached as attributes. Set to True if you want the attached
   attributes to be applied, and False if you either don't have any resources to set, or you don't want the resources
   applied.

Return value

   A scalar id of the map plot created is returned. The id of the streamline plot is returned as an attribute called
   streamline. The id of the data object is returned as an attribute called vfdata, and the id of the scalar data object is
   returned as an attribute called sfdata. This is useful if you want to use setvalues to change some data options after
   this function has been called.

Description

   This function creates and draws a streamline plot over a polar stereographic map on the given workstation. The default is
   to show only the northern hemisphere, unless the special resource gsnPolar is set to "SH".

   This function puts special longitude labels around the polar map. These labels can be controlled only through a limited
   set of gsnPolar* resources. To turn off the labels completely, set the resource gsnTickMarksOn to False.

   The scalar field is used to color the streamlines. Note that the gsnScalarContour resource is NOT recognized by this
   routine. If you need to overlay streamlines on a contour plot, then use gsn_csm_contour, gsn_csm_streamline_map_polar,
   and overlay.

   The special resource gsnAddCyclic will be set to True so that a cyclic point will be added to the data. Set this resource
   to False if your data is not cyclic, or if you have already added the cyclic point in another fashion.

   If u, v, or data have a _FillValue attribute, these values will be used as missing values.

   If you want to turn the labelbar off, set lbLabelBarOn to False.

   For the map, the following will happen automatically:
     * the continents will be colored gray
     * the continental outlines will be turned off
     * the longitude locations will be labeled

   If u has an attribute called "long_name", and gsnLeftString hasn't explicitly been set, then the value of this attribute
   is used for the left string title.

   If u has an attribute called "units", and gsnRightString hasn't explicitly been set, then the value of this attribute is
   used for the right string title.

   To maximize the area that the plot is drawn in, set the special resource gsnMaximize to True.

See Also

   gsn_csm_streamline, gsn_csm_streamline_scalar, gsn_csm_streamline_contour_map, gsn_csm_streamline_contour_map_polar,
   gsn_csm_streamline_map, gsn_csm_streamline_scalar_map, gsn_csm_streamline_map_polar, gsn_streamline,
   gsn_streamline_scalar, gsn_streamline_scalar_map, gsn_streamline_map, gsn_csm_pres_hgt_streamline

   Special gsn resources

Examples

;---read in netCDF file
  a = addfile("$NCARGTEST/nclscripts/cdf_files/ice001608.nc","r")

;--read in components
  u    = a->uiceh(0,:,:)
  v    = a->uiceh(0,:,:)
  hice = a->hice(0,:,:)

;---create plot
  wks = gsn_open_wks("x11","streamline")

  res            = True                         ; plot mods desired

  res@gsnPolar   = "NH"                         ; specify the hemisphere
  res@mpMinLatF  = 75                           ; minimum lat to plot

; because this is ice data, which has a gap in the tropics, we need to
; explicitly pass the range of the data to plot.  Since we are coloring
; the vectors, this range should also match the MinLatF above, since the
; range for the colors is chosen over the full data passed, and not the
; map limits.

  res@stLevelPalette     = "StepSeq25"
  res@stLineThicknessF   = 3.0
  res@lbOrientation      = "Vertical"

  plot = gsn_csm_streamline_scalar_map_polar(wks,u({75.:90.},:),\
                                                 v({75.:90.},:),\
                                                hice({75:90.},:),res)



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:23:01 +0800
# vim:set fdm=indent foldlevel=0:
