THE_URL:https://www.ncl.ucar.edu/Document/Graphics/Interfaces/gsn_csm_streamline_scalar_map.shtml
THE_TITLE:gsn_csm_streamline_scalar_map

gsn_csm_streamline_scalar_map

   Creates and draws a streamline plot over a map, using a scalar field to color the streamlines.

   [new.gif] Available in version 6.3.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

        function gsn_csm_streamline_scalar_map (
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

   This function creates and draws a streamline plot over a map on the given workstation. The scalar field is used to color
   the streamlines. Note that the gsnScalarContour resource is NOT recognized by this routine. If you need to overlay
   streamlines on a contour plot, then use gsn_csm_contour, gsn_csm_streamline_map, and overlay.

   The default projection is a cylindrical equidistant, which you can override by setting the mpProjection resource.

   The special resource gsnAddCyclic will be set to True so that a cyclic point will be added to the data. Set this resource
   to False if your data is not cyclic, or if you have already added the cyclic point in another fashion.

   If u, v, or data have a _FillValue attribute, these values will be used as missing values.

   If you want to turn the labelbar off, set lbLabelBarOn to False.

   For the map, the following will happen automatically:
     * the continents will be colored gray
     * the continental outlines will be turned off
     * the latitude/longitude locations will be labeled (cylindrical equidistant and polar stereographic maps only)
     * the tickmarks will point outward (cylindrical equidistant map only)

   If u has an attribute called "long_name", and gsnLeftString hasn't explicitly been set, then the value of this attribute
   is used for the left string title.

   If u has an attribute called "units", and gsnRightString hasn't explicitly been set, then the value of this attribute is
   used for the right string title.

   To maximize the area that the plot is drawn in, set the special resource gsnMaximize to True.

See Also

   gsn_csm_streamline, gsn_csm_streamline_scalar, gsn_csm_streamline_contour_map, gsn_csm_streamline_contour_map_polar,
   gsn_csm_streamline_map, gsn_csm_streamline_scalar_map_polar, gsn_csm_streamline_map_polar, gsn_streamline,
   gsn_streamline_scalar, gsn_streamline_scalar_map, gsn_streamline_map, gsn_csm_pres_hgt_streamline

   gsn_csm_contour, gsn_csm_contour_map
   Special gsn resources

Examples

;---Read in 2D data only
  uvf = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/941110_UV.cdf","r")
  pf  = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/941110_P.cdf","r")
  u   = uvf->u
  v   = uvf->v
  p   = pf->Psl
  printVarSummary(u)
  printVarSummary(p)

  wks = gsn_open_wks("x11", "streamline")

  res                        = True                           ; plot mods desired
  res@gsnMaximize            = True
  res@gsnAddCyclic           = False

  res@stLevelPalette         = "SVG_Lindaa07"
  res@stLineThicknessF       = 3.0

  res@stLevelSelectionMode   = "ExplicitLevels"
  res@stLevels               = ispan(950,1040,5)

  res@stLevelPalette         = "GMT_split"

  res@tiMainString           = "Example of a streamline/scalar/map plot"

  plot = gsn_csm_streamline_scalar_map(wks,u,v,p,res)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:22:59 +0800
# vim:set fdm=indent foldlevel=0:
