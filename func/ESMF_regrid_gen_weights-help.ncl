THE_URL:https://www.ncl.ucar.edu/Document/Functions/ESMF/ESMF_regrid_gen_weights.shtml
THE_TITLE:ESMF_regrid_gen_weights

ESMF_regrid_gen_weights

   Writes a weight file using the offline ESMF weight generator.

   [new.gif] Available in version 6.1.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"

        procedure ESMF_regrid_gen_weights (
                srcGridFile [1] : string,
                dstGridFile [1] : string,
                wgtFile     [1] : string,
                opt         [1] : logical
        )

Arguments

   srcGridFile

   Name of the input NetCDF file containing the SCRIP or ESMF grid description for the source grid.
   dstGridFile

   Name of the input NetCDF file containing the SCRIP or ESMF grid description for the destination grid.
   wgtFile

   Name of the output NetCDF file to use for writing the weights.
   opt

   An optional variable to set certain attributes for this procedure. If set to False, none of the attributes will have an
   effect.

   See below for a full list of attributes.

Description

   This procedure writes weight values to a NetCDF file, which allow you to interpolate data on a source grid to a
   destination grid. It uses the input description files (srcGridFile and dstGridFile) for the source and destination grids,
   and the offline "ESMF_RegridWeightGen" weight generation tool to generate the weights.

   ESMF_regrid_gen_weights is part of a suite of regridding routines based on Earth System Modeling Framework (ESMF)
   software. The regridding can be done via a multi-step process that includes this procedure, or via an "all-in-one"
   function called ESMF_regrid.

   Both methods have their advantages. The multi-step process involves:
    1. Creating the description NetCDF file for the source grid.
    2. Creating the description NetCDF file for the destination grid.
    3. Calculating and writing the weights to a NetCDF file.
    4. Applying the weights to regrid the data from the source grid to the destination grid.
    5. Copying attributes and coordinates to the newly regridded variable.

   The ESMF_regrid function performs all of the above steps.

   The source and destination grids can be written using one of the following procedures:
     * latlon_to_SCRIP
     * rectilinear_to_SCRIP
     * curvilinear_to_SCRIP
     * unstructured_to_ESMF

   You can then use ESMF_regrid_with_weights to apply the weights to a given data variable for interpolation to a new grid.

   The attributes that can be attached to opt include:
     * InterpMethod (default = "bilinear") The interpolation method to use. The allowed types are "bilinear" (default),
       "patch", "conserve", "neareststod" and "nearestdtos":
          + "bilinear" - the algorithm used by this application to generate the bilinear weights is the standard one found
            in many textbooks. Each destination point is mapped to a location in the source mesh, the position of the
            destination point relative to the source points surrounding it is used to calculate the interpolation weights.
          + "patch" - this method is the ESMF version of a technique called "patch recovery" commonly used in finite element
            modeling. It typically results in better approximations to values and derivatives when compared to bilinear
            interpolation.
          + "conserve" - this method will typically have a larger interpolation error than the previous two methods, but
            will do a much better job of preserving the value of the integral of data between the source and destination
            grid.
          + "neareststod" and "nearestdtos" - Available in version 6.2.0 and later. The nearest neighbor methods work by
            associating a point in one set with the closest point in another set. If two points are equally close then the
            point with the smallest index is arbitrarily used (i.e. the point with that would have the smallest index in the
            weight matrix). There are two versions of this type of interpolation available in the regrid weight generation
            application. One of these is the nearest source to destination method ("neareststod"). In this method each
            destination point is mapped to the closest source point. The other of these is the nearest destination to source
            method ("nearestdtos"). In this method each source point is mapped to the closest destination point. Note, that
            with this method the unmapped destination point detection doesn't work, so no error will be returned even if
            there destination points which don't map to any source point.
     * Pole (default = "all" for "bilinear" or "patch" methods, and "none" for "conserve", "neareststod", or "nearestdtos"
       methods)
       There's a bug in NCL versions 6.1.2 and earlier where only "pole" is recognized, and not "Pole". This will be fixed
       in version 6.2.0.
       For periodic logically rectangular source grid (e.g. without Opt@SrcRegional=True), the regridding application will
       perform extrapolation for destination points which lie above or below the source grid. By specifying "all", the
       application does an average of all the source values surrounding the pole and uses that value at an artificially
       constructed pole in the center of the pole region. The region around this pole is then triangulated to extrapolate
       destination points. If "none" is specified, no extrapolation occurs and destination points which fall above or below
       the source grid are not mapped. A value of "all" is not supported for the "conserve", "neareststod", or "nearestdtos"
       interpolation methods.
       If "teeth" is specified, then no new pole point is constructed, instead the holes at the poles are filled by
       constructing triangles across the top and bottom row of the source Grid. This can be useful because no averaging
       occurs, however, because the top and bottom of the sphere are now flat, for a big enough mismatch between the size of
       the destination and source pole regions, some destination points may still not be able to be mapped to the source
       Grid.
       If a value <N> is specified, then this will construct an artificial pole placed in the center of the top (or bottom)
       row of nodes, but projected onto the sphere formed by the rest of the grid. The value at this pole is the average of
       the N source nodes next to the pole and surrounding the destination point (i.e. the value may differ for each
       destination point. Here N ranges from 1 to the number of nodes around the pole.
       The default value is "all" if method is "bilinear" or "patch" (or not set at all), and "none" if method is set to
       "conserve".
     * SrcRegional (default = False)
       By default, the ESMF regridding application assumes that a logically rectangular grid is periodic. This means that it
       connects the ends of the first dimension to form a sphere and allows extrapolation over the pole. If this option is
       set to True, then the source grid is assumed to NOT have a periodic connection and instead is considered just a
       region of the sphere.
     * DstRegional (default = False)
       By default, the ESMF regridding application assumes that a logically rectangular grid is periodic. This means that it
       connects the ends of the first dimension to form a sphere and allows extrapolation over the pole. If this option is
       set to True, then the destination grid is assumed to NOT have a periodic connection and instead is considered just a
       region of the sphere.
     * SrcESMF (default = False)
       If set to True, this indicates that the source file is in ESMF unstructured format. If ESMF unstructured format is
       not specified then the source file is assumed to be SCRIP format.
     * DstESMF (default = False)
       If set to True, this indicates that the destination file is in ESMF unstructured format. If ESMF unstructured format
       is not specified then the destination file is assumed to be SCRIP format.
     * IgnoreUnmappedPoints (default = True)
       The ESMF regridding application will return an error if there exists a destination point for which regridding weights
       can't be generated. In other words, if there exists a destination point which can't be mapped to a source cell. The
       default of this option is True, which means the application ignores those destination points and they simply won't be
       regridded.
     * NetCDFType (default = "netcdf3")
       You can set this option to "netcdf4" to force a NetCDF-4 file to be written for the weights file.
       Available in version 6.2.1 and later.
     * LargeFile (default = False) If set to True, then the weight file will be created in the NetCDF 64-bit offset format
       to allow variables larger than 2GB.
     * Overwrite (default = False) If set to True, then if the weight NetCDF file (wgtFile) exists, you will be prompted for
       whether to remove it.
     * ForceOverwrite (default = False) If set to True, then the weight NetCDF file (wgtFile) will be overwritten no matter
       what.
     * NoPETLog (default = False) Do not generate the "PET0.RegridWeightGen.log" file, or append anything to it if it
       already exists. See also the RemovePETLog option.
       Available in version 6.2.1 and later.
     * RemoveFiles / RemoveSrcFile / RemoveDstFile (default = False) If True, then the corresponding description file will
       be removed after the weight generation is done. If the weight generation is unsuccessful, these files won't be
       removed.
     * RemovePETLog (default = False) Remove the "PET0.RegridWeightGen.log" file, if generated. See also the NoPETLog
       option.
       Available in version 6.2.0 and later.
     * PrintTimings (default = False) print the CPU time spent in this routine
     * Check (default = False)
       If set to True, then extra analytic output will be computed and printed, including the mean relative error between
       the destination and analytic field, and the relative error between the mass of the source and destination fields in
       the conservative case.
       Available in version 6.2.1 and later.
     * Debug (default = False) Turn on debug print statements. This will also print the full command line used for
       "ESMF_RegridWeightGen".

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
2015-10-03 23:21:23 +0800
# vim:set fdm=indent foldlevel=0:
