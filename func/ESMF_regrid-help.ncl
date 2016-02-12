THE_URL:https://www.ncl.ucar.edu/Document/Functions/ESMF/ESMF_regrid.shtml
THE_TITLE:ESMF_regrid

ESMF_regrid

   Regrids data from one lat/lon grid to another, using ESMF software.

   [new.gif] Available in version 6.1.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"

        function ESMF_regrid (
                data    : numeric,
                opt [1] : logical
        )

        return_val [dimsizes(data)] :  double

Arguments

   data

   The data to regrid. This can be any dimensionality. If this is a curvilinear or rectilinear lat/lon grid, then the
   rightmost two dimensions must be nlat x nlon.
   opt

   An optional variable to set certain attributes for this function. If set to False, none of the attributes will have an
   effect. However, it is likely you will need to set at least a few attributes in order for the regridding to be done
   correctly.

   See below for a full list of attributes.

Description

   This function regrids data from a source grid to a destination grid, and creates a weights file in the interim. The
   source and destination grids can be rectilinear, curvilinear, or unstructured.

   Some things to note:
     * This function will return type float if data is float, and double if data is double or the special ReturnDouble
       option is set to True.
     * Coordinate variables will be attached by default, if regridding to a rectilinear grid. Otherwise, "lat2d" and "lon2d"
       attributes will be attached to the output array. You can set the special CopyVarCoords option to False if you don't
       want this behavior.
     * If your source data or destination lat/lon values contain missing values, then you must set the special SrcGridMask
       and/or DstGridMask (old names are "SrcMask2D" and "DstMask2D", which still work). options. If these masks are
       different across multiple levels or timesteps, then you will need to generate a separate weights file for each level
       or timestep where it changes. See the special note below.
     * The NetCDF files created by this function are written with "large file support" turned on. If this is not desired,
       set the special options SrcLargeFile and/or DstLargeFile to False.

   ESMF_regrid is part of a suite of regridding routines based on the Earth System Modeling Framework (ESMF) software.

   This function is an "all-in-one" function that performs all of these steps:

    1. Writes the description of the source grid to a SCRIP or ESMF description NetCDF file.
    2. Writes the description of the destination grid to a SCRIP or ESMF description NetCDF file.
    3. Generates the weights and writes them to a NetCDF file.
    4. Regrids the data by applying the weights.
    5. Copies metadata (attributes and coordinate arrays) where possible.

   The attributes that can be attached to opt include:

     * SrcFileName (default = "source_grid_file.nc")
       The name to use for the NetCDF file that will contain the needed grid description of the source grid. Do NOT set this
       to the original file that contains your data! This is the name of the *new* source description file that will get
       written.
     * DstFileName (default = "destination_grid_file.nc")
       The name to use for the NetCDF file that will contain the needed grid description of the destination grid. Do NOT set
       this to the original file that contains your data! This is the name of the *new* destination description file that
       will get written.
     * WgtFileName (default = "weights_file.nc")
       The name to use for the NetCDF weights file that is generated under the hood.
     * SkipSrcGrid (default = False)
       If this is set to True, then it assumes the source description file has already been generated.
     * SkipDstGrid (default = False)
       If this is set to True, then it assumes the destination description file has already been generated.
     * SkipWgtGen (default = False)
       If this is set to True, then it assumes the weights file has already been created.
     * SrcOverwrite and DstOverwrite (default = False)
       If set to True, then if the corresponding description NetCDF file already exists, you will be prompted for whether to
       remove it.
     * SrcForceOverwrite and DstForceOverwrite (default = False)
       If set to True, then if the corresponding the description NetCDF file already exists, then it will be overwritten no
       matter what.
     * NoPETLog (default = False) Do not generate the "PET0.RegridWeightGen.log" file, or append anything to it if it
       already exists. See also the RemovePETLog option.
       Available in version 6.2.1 and later.
     * RemovePETLog (default = False) Remove the "PET0.RegridWeightGen.log" file, if generated. See also the NoPETLog
       option.
       Available in version 6.2.0 and later.
     * RemoveSrcFile and RemoveDstFile and RemoveWgtFile (default = False)
       If set to True, then the corresponding grid files and/or weight will be removed after ESMF_regrid completes.
     * SrcLargeFile and DstLargeFile (default = True)
       If set to True, then the description NetCDF file will be written in "large file" mode.
     * SrcGridLat / SrcGridLon (default: will try to use information from the input variable)
       These are the arrays that define the source lat/lon grid.
       If these attributes are not set, then this function will try to determine what the source lat/lon grid is by looking
       for:
          + one-dimensional coordinate arrays attached to the input data array
          + attributes called "lat2d" and "lon2d" attached to data
          + attributes called "lat1d" and "lon1d" attached to data (this implies you have an unstructured grid)
       If none of the above can be found, then these two arrays must be provided, or you'll get an error.
     * DstGridLat / DstGridLon (no default)
       These are the arrays that define the destination lat/lon grid.
       Since this function has no way to automatically determine what the output grid is, you must set these two attributes
       or you will get an error.
     * SrcGridCornerLat / SrcGridCornerLon
       [Only needed for the "conserve" interpolation method.]
       These arrays indicate the corner points of your source grid. If you don't set these attributes, then they will be
       calculated for you using a generic algorithm.
       It is better to use your own calculated values, especially for unusual grids like the HOMME grid. The values must be
       provided as an N x 4 array, where N represents the dimensionality of the center lat/lon grid. For example, if the
       center lat/lon grid is dimensioned 256 x 220, then the corner arrays must be 256 x 220 x 4. Sometimes the corner
       grids are provided on the file along with the center grids, with names like "lat_vertices"/"lon_vertices" or
       "lat_bounds"/"lon_bounds".
     * DstGridCornerLat / DstGridCornerLon
       [Only needed for the "conserve" interpolation method.]
       These arrays indicate the corner points of your destination grid. If you don't set these attributes, then they will
       be calculated for you using a generic algorithm.
       It is better to use your own calculated values, especially for unusual grids like HOMME. See the SrcGridCornerLat/Lon
       description above about a possible bug and a fix.
     * SrcGridMask and DstGridMask (no default)
       Note: SrcMask2D and DstMask2D were renamed to SrcGridMask and DstGridMask in NCL V6.3.0, since the "2D" is
       misleading. The old names will still work.
       A mask array of the same size as the desired lat/lon grid, that indicates which areas to mask out. Set the desired
       masked areas to 0, and all the rest to 1. This is an important option to set if your data contains missing values.
       If these masks are different across multiple levels or timesteps, then you will need to generate a separate weights
       file for each level or timestep where it changes. See the special note below.
     * SrcNetCDFType / DstNetCDFType / WgtNetCDFType (default = "netcdf3")
       You can set these options or "NetCDFType" to "netcdf4" to force a NetCDF-4 file to be written for the source,
       destination, and/or weights files.
       Available in version 6.2.1 and later.
     * SrcGridType and DstGridType (no default)
       Instead of providing lat/lon arrays that describe the source and/or destination grids (via SrcGridLat, SrcGridLon,
       DstGridLat, DstGridLon), you can provide a "type" via a descriptive string. Valid types include:
          + "1x1", "2x3", "0.25x0.25", etc
          + "1deg", "0.25deg" "0.25 deg" "0.25" (which means "0.25deg")
          + "G64", "G128" (gaussian)
       The DstGridType resource may need to be set if SkipDstGrid is set to True
       . See this attribute for more details.

          SrcLLCorner and DstLLCorner (default = [-90,-180])

                [Only used if SrcGridType or DstGridType is set.]

                The lower left corner of the lat/lon grid desired. Use in conjunction with SrcURCorner and DstURCorner.

          SrcURCorner and DstURCorner (default = [90,180])

                [Only used if SrcGridType or DstGridType is set.]

                The upper right corner of the lat/lon grid desired. Use in conjunction with SrcLLCorner and DstLLCorner.

          SrcRotation and DstRotation (no default)

                [Only used if SrcGridType or DstGridType is set.]

                An optional rotation angle for the lat/lon grid.

     * SrcTriangularMesh and DstTriangularMesh (no default)
       If regridding to or from an unstructured grid, NCL needs to generate a triangular mesh of the lat/lon points. It uses
       a function called csstri which can be slow and memory intensive. If you already have a triangular mesh of your
       lat/lon points, then you can set it using this option.
       Available in version 6.2.0 and later.
     * InterpMethod (default = "bilinear")
       The regridding interpolation method to use. The allowed types are "bilinear" (default), "patch", "conserve",
       "neareststod" and "nearestdtos":
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
     * IgnoreUnmappedPoints (default = True)
       The ESMF regridding application will return an error if there exists a destination point for which regridding weights
       can't be generated. In other words, if there exists a destination point which can't be mapped to a source cell. The
       default of this attribute is True, which means the application ignores those destination points and they simply won't
       be regridded.
     * SrcRegional (default = False)
       By default, the ESMF regridding application assumes that a logically rectangular grid is periodic. This means that it
       connects the ends of the first dimension to form a sphere and allows extrapolation over the pole. If this attribute
       is set to True, then the source grid is assumed to NOT have a periodic connection and instead is considered just a
       region of the sphere.
     * DstRegional (default = False)
       By default, the ESMF regridding application assumes that a logically rectangular grid is periodic. This means that it
       connects the ends of the first dimension to form a sphere and allows extrapolation over the pole. If this attribute
       is set to True, then the destination grid is assumed to NOT have a periodic connection and instead is considered just
       a region of the sphere.
     * SrcESMF (default = False)
       If set to True, this indicates that the source file is in ESMF unstructured format. If ESMF unstructured format is
       not specified then the source file is assumed to be SCRIP format.
     * DstESMF (default = False)
       If set to True, this indicates that the destination file is in ESMF unstructured format. If ESMF unstructured format
       is not specified then the destination file is assumed to be SCRIP format.
     * ReturnDouble
       If set to True, then the return value from this function will be double, regardless of the type of the input data.
     * RemapIndexes (default = False)
       If set to True, then this indicates that the weights in this file apply to a 1D grid is a subset of a larger nD grid.
       This means the values have to be remapped onto the original destination grid using index values indicated by Indexes,
       and the dimension sizes indicated by IndexesDims.

          Indexes (no default)

                See the description for RemapIndexes.

          IndexesDims (no default)

                See the description for RemapIndexes.

     * SrcInputFileName and DstInputFileName (no default)
       Name of the original input file that contained the grid, if any. This will be written to the appropriate description
       file as an attribute "inputFile". This is optional, but useful for descriptive purposes.
     * SrcTitle and DstTitle (default = some descriptive string, depending on the type of grid being written)
       An optional title to include in the description NetCDF file as a global attribute called "title".
     * CopyVarAtts (default = True)
       The attributes of the variable being regridded will be copied to the regridded variable, unless this is set to False.
       Attributes that will not be copied include "lat2d", "lon2d", "lat1d", "lon1d", and "coordinates".

          CopyVarAttsExcept (no default)

                Use this in conjunction with CopyVarAtts to indicate additional attributes that you don't want copied.

     * CopyVarCoords (default = True)
       This function will attempt to copy over any coordinate arrays, unless this attribute is set to False. It gets the
       coordinate information from the weights file.
       If the destination grid is rectilinear, then the coordinates will be copied as 1D coordinate arrays. If the
       destination grid is curvilinear, then the coordinates will be attached as special attributes called "lat2d" and
       "lon2d". If the destination grid is unstructured, then the coordinates will be attached as special attributes called
       "lat1d" and "lon1d".
     * PrintTimings (default = False)
       Print the CPU time spent in the individual ESMF routines.
     * Check (default = False)
       If set to True, then extra analytic output will be computed and printed, including the mean relative error between
       the destination and analytic field, and the relative error between the mass of the source and destination fields in
       the conservative case.
       Available in version 6.2.1 and later.
     * Debug (default = False)
       Turn on debug print statements.

   Special note about weights files and missing values:

   You can use the same weights file to regrid across other levels and timesteps of the same variable, or across other
   variables, as long as the lat/lon grid that you are regridding from and to are exactly the same, and, if you use the
   special GridMask (or Mask2D prior to NCL V6.3.0) option, that your masks are exactly the same. The masks are arrays
   filled with 0's and 1's that indicate where your data values and/or lat/lon values are missing. Here's a description from
   Robert Oehmke of ESMF about this:

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

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"

begin
    sfile = addfile("sst.nc","r")
    temp  = sfile->TEMP(0,0,:,:)

    Opt                = True

    Opt@SrcFileName    = "src_SCRIP.nc"
    Opt@DstFileName    = "dst_SCRIP.nc"
    Opt@WgtFileName    = "NCEP_2_Rect.nc"
    Opt@ForceOverwrite = True

    Opt@SrcGridMask    = where(.not.ismissing(temp),1,0)

    Opt@DstGridType    = "5x5"
    Opt@DstLLCorner    = (/ -60.d,   0.d/)
    Opt@DstURCorner    = (/  60.d, 355.d/)

    temp_regrid = ESMF_regrid(temp,Opt)
    printVarSummary(temp_regrid)
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

   Example 3

   This example shows how to regrid from a subset (511 x 1081) of a high-resolution rectilinear global elevation grid (5401
   x 10801) to a low-resolution 0.5 degree regional grid (35 x 73), using the "conserve" interpolation method.

   It uses default names for the output source, destination, and weight files, since none are provided.
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"

begin
    latS  = 25    ; rough box that encloses the Tibet Plateau
    latN  = 42    ; this is larger than the 'final' Tibet region
    lonW  = 72    ; common TIBET region: 28N-40N and 75-104E
    lonE  = 108

;---Read data to regrid
    sfile = addfile("ETOPO2_GLOBAL_2_ELEVATION.nc","r")
    zcrit = 1500  ; user specifed elevation boundary for Tibet
    topo  = short2flt(sfile->ELEV({latS:latN},{lonW:lonE}))
    topo  = where(topo .lt.zcrit, topo@_FillValue , topo )

    Opt                = True

    Opt@SrcTitle       = "TOPO Grid"

    Opt@DstGridType    = "0.5deg"         ; Destination grid description
    Opt@DstTitle       = "Global 0.5 degree resolution"
    Opt@DstLLCorner    = (/ latS, lonW /)
    Opt@DstURCorner    = (/ latN, lonE /)

    Opt@SrcGridMask    = where(.not.ismissing(topo),1,0)

    Opt@SrcRegional    = True             ; These are necessary
    Opt@DstRegional    = True

    Opt@InterpMethod   = "conserve"       ; Default is bilinear

    topo_regrid = ESMF_regrid(topo,Opt)   ; Do the regridding
    printVarSummary(topo_regrid)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:21:22 +0800
# vim:set fdm=indent foldlevel=0:
