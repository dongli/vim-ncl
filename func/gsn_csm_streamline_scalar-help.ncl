THE_URL:https://www.ncl.ucar.edu/Document/Graphics/Interfaces/gsn_csm_streamline_scalar.shtml
THE_TITLE:gsn_csm_streamline_scalar

gsn_csm_streamline_scalar

   Creates and draws a streamline plot, using a scalar field to color the streamlines.

   [new.gif] Available in version 6.3.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

        function gsn_csm_streamline_scalar (
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

   A scalar id of the streamline plot created is returned. The id of the streamline data object is returned as an attribute
   called vfdata, and the id of the scalar data object is returned as an attribute called sfdata. These ids are useful if
   you want to use setvalues to change some data or plot options after this function has been called.

Description

   This function creates and draws a streamline plot. The scalar field is used to color the streamlines. Note that the
   gsnScalarContour resource is NOT recognized by this routine. See gsn_csm_streamline_contour_map instead.

   If you want to turn the labelbar off, set lbLabelBarOn to False.

   If u, v, or data have a _FillValue attribute, these values will be used as missing values.

   If u has an attribute called "long_name", and gsnLeftString hasn't explicitly been set, then the value of this attribute
   is used for the left string title.

   If u has an attribute called "units", and gsnRightString hasn't explicitly been set, then the value of this attribute is
   used for the right string title.

   To maximize the area that the plot is drawn in, set the special resource gsnMaximize to True.

See Also

   gsn_csm_streamline, gsn_csm_streamline_contour_map, gsn_csm_streamline_contour_map_polar, gsn_csm_streamline_map,
   gsn_csm_streamline_scalar_map, gsn_csm_streamline_scalar_map_polar, gsn_csm_streamline_map_polar, gsn_streamline,
   gsn_streamline_scalar, gsn_streamline_scalar_map, gsn_streamline_map, gsn_csm_pres_hgt_streamline

   Special gsn resources

Examples

;---Read in 2D data only
  uvf = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/941110_UV.cdf","r")
  pf  = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/941110_P.cdf","r")
  u   = uvf->u
  v   = uvf->v
  p   = pf->Psl

;---Send graphics to an X11 window
  wks = gsn_open_wks("x11","streamlines")

;---Set some plotting resources
  res                        = True                           ; plot mods desired
  res@gsnMaximize            = True
  res@gsnAddCyclic           = False

  res@stLevelPalette         = "SVG_Lindaa07"
  res@stLineThicknessF       = 3.0

  res@tiMainString           = "Example of a streamline/scalar plot"
  res@lbOrientation          = "Vertical"

  res@stLevelSelectionMode   = "ExplicitLevels"
  res@stLevels               = ispan(950,1040,5)     ; default is a spacing of 10

  plot = gsn_csm_streamline_scalar(wks,u,v,p,res)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:22:58 +0800
# vim:set fdm=indent foldlevel=0:
