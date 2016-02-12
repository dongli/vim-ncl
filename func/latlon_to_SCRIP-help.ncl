THE_URL:https://www.ncl.ucar.edu/Document/Functions/ESMF/latlon_to_SCRIP.shtml
THE_TITLE:latlon_to_SCRIP

latlon_to_SCRIP

   Writes the description of a lat/lon grid to a SCRIP file.

   [new.gif] Available in version 6.1.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"

        procedure latlon_to_SCRIP (
                SCRIP_filename [1] : string,
                grid_type      [1] : string,
                opt            [1] : logical
        )

Arguments

   SCRIP_filename

   Name of SCRIP NetCDF file to write.
   grid_type

   The type of lat/lon grid to generate.
   opt

   An optional variable to set certain attributes for this procedure. If set to False, none of the attributes will have an
   effect.

   See below for a full list of attributes.

Description

   This procedure writes the description of the requested lat/lon grid to a NetCDF SCRIP output file.

   latlon_to_SCRIP is part of a suite of regridding routines based on Earth System Modeling Framework (ESMF) software. The
   regridding can be done via a multi-step process that includes this procedure, or via an "all-in-one" function called
   ESMF_regrid.

   Both methods have their advantages. The multi-step process involves:
    1. Creating the description NetCDF file for the source grid.
    2. Creating the description NetCDF file for the destination grid.
    3. Calculating and writing the weights to a NetCDF file.
    4. Applying the weights to regrid the data from the source grid to the destination grid.
    5. Copying attributes and coordinates to the newly regridded variable.

   The ESMF_regrid function performs all of the above steps.

   The types of grids recognized by grid_type include:
     * "1x1","5x5", "2x3", etc
     * "1deg", "0.25deg", etc
     * "G64", "G128", etc (gaussian grids)

   The attributes that can be attached to opt include:
     * LLCorner/URCorner (default = [-90,-180] and [90,180]) The lower left and upper right corners of the lat/lon grid
       desired. The default is LLCorner = (/-90,-180/) and URCorner = (/90,180/).
     * Rotation (no default) an optional rotation angle for the lat/lon grid.
     * GridMask (old name is Mask2D) (no default) A mask array of the same size as the desired lat/lon grid, that indicates
       which areas to mask out (that is, which values are missing). Set the masked (missing) areas to 0, and all the rest to
       1.
       If these masks are different across multiple levels or timesteps, then you will need to generate a separate weights
       file for each level or timestep where it changes. See the special note below.
     * LargeFile (default = False) If set to True, then the NetCDF file will be written in "large file" mode.
     * Overwrite (default = False) If set to True, then if the description NetCDF file exists (SCRIP_filename), you will be
       prompted for whether to remove it.
     * ForceOverwrite (default = False) If set to True, then the description NetCDF file (SCRIP_filename) will be
       overwritten no matter what.
     * Title (no default) An optional title to include in the NetCDF file.
     * PrintTimings (default = False) print the CPU time spent in this routine.
     * Debug (default = False) Turn on debug prints.

   Special note about weights files and missing values:

   You can use the same weights file to regrid across other levels and timesteps of the same variable, or across other
   variables, as long as the lat/lon grid that you are regridding from and to are exactly the same, and, if you use the
   special GridMask option, that your masks are exactly the same. The masks are arrays filled with 0's and 1's that indicate
   where your data values and/or lat/lon values are missing. Here's a description from Robert Oehmke of ESMF about this:

   What the mask does is remove the entity (cell or point depending on the type of regridding) from consideration by the
   regridder. If it's a source cell then no destination entities are mapped to it. If it's a destination entity, then it's
   not interpolated to. There is a little more in-depth discussion in the ESMF reference manual.

   Right now, masking needs to be done before weight calculation so the regridding knows what it should ignore, so if the
   mask changes then you need to regenerate weights. We actually have a feature request ticket for handling this type of
   missing value situation more fluidly. The plan is to have the interpolation automatically not use missing values when
   they are encountered in a data field. Which would allow the same weights to be used for all the levels.

   One trick you can do right now with missing values and a weight file is to do two interpolations to tell you where the
   missing values will spread in the destination field. First interpolate a field containing all 0's except for where the
   missing values are set the missing value locations to 1, the result of this interpolation tells you which destination
   locations (the ones whose values >0.0) will be affected by the missing values, so you can ignore them after interpolating
   the data. (You could also do something like this in one step during the data interpolation if you have a restricted range
   for your data and you use a value way outside that range for your missing value.) This, of course, will give you a
   coarser result than using the masking, but will probably be more efficient than recalculating the weights each time.

See Also

   ESMF_regrid, latlon_to_SCRIP, rectilinear_to_SCRIP, curvilinear_to_SCRIP, unstructured_to_ESMF, ESMF_regrid_gen_weights,
   ESMF_regrid_with_weights

Examples

   There's a suite of examples available on our ESMF applications page, and a set of basic ESMF template scripts to help you
   get started.

   Example 1

   This example regrids data from a global rectilinear NCEP grid (64 x 181) to a 5x5 degree lat/lon grid (25 x 72), using
   the default "bilinear" interpolation method.

   This example assumes the description and weight files have not been generated. If they have, then see example 2 below.

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"

begin
;---Input file
    srcFileName = "sst.nc"

;---Output (and input) files
    srcGridName = "src_SCRIP.nc"
    dstGridName = "dst_SCRIP.nc"
    wgtFileName = "NCEP_2_Rect.nc"

;----------------------------------------------------------------------
; Convert original source NCEP grid to a SCRIP convention file.
;----------------------------------------------------------------------
    src_file = addfile(srcFileName,"r")
    temp     = src_file->TEMP(0,0,:,:)

    Opt                = True
    Opt@GridMask       = where(.not.ismissing(temp),1,0)
    Opt@ForceOverwrite = True
    Opt@PrintTimings   = True
    Opt@Title          = "NCEP Grid"

    rectilinear_to_SCRIP(srcGridName,temp&LAT,temp&LON,Opt)

;---Clean up
    delete(Opt)

;----------------------------------------------------------------------
; Convert destination grid to a SCRIP convention file.
;----------------------------------------------------------------------
    Opt                = True
    Opt@LLCorner       = (/ -60.d,   0.d/)
    Opt@URCorner       = (/  60.d, 355.d/)
    Opt@ForceOverwrite = True
    Opt@PrintTimings   = True

    latlon_to_SCRIP(dstGridName,"5x5",Opt)

;---Clean up
    delete(Opt)

;----------------------------------------------------------------------
; Generate the weights that take you from the NCEP grid to a
; 5x5 degree grid.
;----------------------------------------------------------------------
    Opt                      = True
    Opt@InterpMethod         = "bilinear"     ; default
    Opt@ForceOverwrite       = True
    Opt@PrintTimings         = True

    ESMF_regrid_gen_weights(srcGridName,dstGridName,wgtFileName,Opt)

    delete(Opt)

;----------------------------------------------------------------------
; Apply the weights to a given variable on the NCEP file.
;----------------------------------------------------------------------
    Opt                = True
    Opt@PrintTimings   = True

;---In V6.1.0, coordinates and attributes are copied automatically
    temp_regrid = ESMF_regrid_with_weights(temp,wgtFileName,Opt)
    printVarSummary(temp_regrid)

;----------------------------------------------------------------------
; Plot the original and regridded data on a panel plot
;----------------------------------------------------------------------
    wks = gsn_open_wks("ps","ESMF")             ; ESMF.ps
    gsn_define_colormap(wks,"gui_default")      ; choose colormap

    res                     = True              ; Plot mods desired.
    res@gsnDraw             = False             ; We will panel later.
    res@gsnFrame            = False

    res@gsnMaximize         = True              ; Maximize plot

    res@mpMaxLatF           = 60                 ; choose map range
    res@mpMinLatF           = -60

    res@cnFillOn            = True              ; color plot desired
    res@cnLinesOn           = False             ; turn off contour lines
    res@cnLineLabelsOn      = False             ; turn off contour lines

    res@cnLevelSelectionMode =  "ManualLevels"   ; manual levels
    res@cnMinLevelValF       = 4                 ; min level
    res@cnMaxLevelValF       = 32                ; max level
    res@cnLevelSpacingF      =  2                ; interval

    res@lbLabelBarOn        = False              ; Labelbar will be in panel

;---Plot data on original grid
    res@gsnAddCyclic = False

    dims = tostring(dimsizes(temp))
    res@tiMainString = "NCEP monthly means temp: original data (" + \
                       str_join(dims," x ") + ")"
    plot_orig = gsn_csm_contour_map(wks,temp,res)

;---Plot data interpolated onto 5x5 degree grid
    res@gsnAddCyclic = True

    dims = tostring(dimsizes(temp_regrid))
    res@tiMainString = "NCEP monthly means temp: regridded to 5x5 grid (" +\
                       str_join(dims," x ") + ")"
    plot_regrid = gsn_csm_contour_map(wks,temp_regrid,res)

;---Resources for paneling
    pres                  = True
    pres@gsnMaximize      = True
    pres@gsnPanelLabelBar = True

    gsn_panel(wks,(/plot_orig,plot_regrid/),(/2,1/),pres)
end

   Example 2

   This example assumes the "NCEP_2_Rect.nc" weight file from the previous example has already been generated. It uses this
   weight file to regrid a new variable from the same "sst.nc" input file.

   The same weights file can only be used if the source and destination lat/lon grids are the same, and if the mask for the
   new variable is the same as the mask for the "temp" variable.

. . .
    sfile = addfile("sst.nc","r")
    P  = sfile->P(0,0,:,:)

    P_regrid = ESMF_regrid_with_weights(P,"NCEP_2_Rect.nc",False)
    printVarSummary(P_regrid)
. . .


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:21:26 +0800
# vim:set fdm=indent foldlevel=0:
