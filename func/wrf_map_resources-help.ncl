THE_URL:https://www.ncl.ucar.edu/Document/Functions/WRF_arw/wrf_map_resources.shtml
THE_TITLE:wrf_map_resources

wrf_map_resources

   Sets map plotting resources based on an input WRF-ARW file.

   [new.gif] Available in version 6.1.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

        function wrf_map_resources (
                nc_file  : file,
                res      : logical
        )

        return_val [1] :  logical

Arguments

   nc_file

   Reference to an input WRF-ARW file opened with addfile.
   res

   A logical variable that will be used to attach additional plotting resources as attributes.

Return value

   A logical variable containing all the attributes originally attached to res plus any new ones added by this function.

Description

   This function examines the input nc_file WRF-ARW file to determine what map plotting resources (mpProjection,
   mpCenterLonF, mpCenterLatF, etc) to attach to res. This function uses the same internal function used by wrf_map_overlays
   to set the plotting resources.

   For debugging purposes, you can print res after you call this function to see what map resources were set. You can then
   change any that you don't like the values for. See the example below.

   You can safely ignore these warnings:

warning:mpNestTime is not a valid resource in map at this time
warning:start_lat is not a valid resource in map at this time
warning:start_lon is not a valid resource in map at this time
warning:end_lat is not a valid resource in map at this time
warning:end_lon is not a valid resource in map at this time

   WRF-related questions should be sent to wrfhelp@ucar.edu.

See Also

   wrf_map, wrf_map_overlays

Examples

   Example 1

   You can use this function to set the necessary map resources for a particular WRF-ARW dataset, and then use one of the
   gsn_csm_xxxx_map routines to plot the data:

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

begin
;---Open file and calculate slp.
    a = addfile("wrfout_d01_2000-01-24_12:00:00.nc","r")

    slp = wrf_user_getvar(a,"slp",0)
    wrf_smooth_2d( slp, 3 )             ; smooth slp

;---Start the graphics
    wks = gsn_open_wks("x11","wrf")

;---Set some graphical resources
    res             = True
    res@gsnMaximize = True
    res@cnFillOn    = True
    res@tfDoNDCOverlay = True     ; This is necessary if you don't
                                  ; set sfXArray/sfYArray

;---Add additional map resources
    res = wrf_map_resources(a,res)

;---Change some of the resources that were set (these were set to "gray")
    res@mpGeophysicalLineColor  = "black"
    res@mpNationalLineColor     = "black"
    res@mpUSStateLineColor      = "black"

    plot = gsn_csm_contour_map(wks,slp,res)

  end


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:21:47 +0800
# vim:set fdm=indent foldlevel=0:
