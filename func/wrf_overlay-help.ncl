THE_URL:https://www.ncl.ucar.edu/Document/Functions/WRF_arw/wrf_overlay.shtml
THE_TITLE:wrf_overlay

wrf_overlay

   Overlays multiple plots, created from other ARW WRF plot functions (deprecated in version 5.1.0).

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

        procedure wrf_overlay (
                wks       : graphic,
                plots [*] : graphic,
                res   [1] : logical
        )

Arguments

   wks

   An NCL Workstation identifier. The identifier is one returned either from calling gsn_open_wks or calling create to
   create a Workstation object.
   plots

   Plots to overlay, possibly created by calls to wrf_contour and/or wrf_vector.
   res

   A plot resource. Set to True if you want to advance the frame before creating the next frame. Set to False if you do not
   want to advance the frame. Use False only if you plan on adding additional text/lines/symbols to the frame before
   advancing it.

Description

   This procedure will be deprecated in version 5.1.0. Use the much more versatile function wrf_overlays instead.

   This procedure overlays a number of graphical plots. This is typically used for idealized ARW WRF model runs.

   wrf_overlay is part of a library of functions and procedures in WRFUserARW.ncl written to help users plot ARW WRF model
   data.

   WRF-related questions should be sent to wrfhelp@ucar.edu.

See Also

   wrf_contour, wrf_vector, wrf_map, wrf_map_overlay

Examples

   Example 1

  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

  ; Open ARW WRF output for the quater supercell idealized case
  a = addfile("wrfout_qss.nc","r")

  wks = gsn_open_wks("x11","test")

  time = 1
  tc2 = wrf_user_getvar(a,"T2",time)   ; T2 in Kelvin
  u10 = wrf_user_getvar(a,"U10",time)  ; u at 10 m
  v10 = wrf_user_getvar(a,"V10",time)  ; v at 10 m

  rest = True
  rest@cnFillOn = True
  contour = wrf_contour(a,wks,tc2,rest)

  resw = True
  vector = wrf_vector(a,wks,u10,v10,resw)

  wrf_overlay(wks,(/contour,vector/),True)

   You can see some other example scripts and their resultant images at:

     http://www.mmm.ucar.edu/wrf/OnLineTutorial/Graphics/NCL/


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:21:49 +0800
# vim:set fdm=indent foldlevel=0:
