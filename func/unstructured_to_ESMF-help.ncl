THE_URL:https://www.ncl.ucar.edu/Document/Functions/ESMF/unstructured_to_ESMF.shtml
THE_TITLE:unstructured_to_ESMF

unstructured_to_ESMF

   Writes the description of an unstructured grid to an ESMF file.

   [new.gif] Available in version 6.1.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/esmf/ESMF_regridding.ncl"

        procedure unstructured_to_ESMF (
                ESMF_filename [1] : string,
                lat               : numeric,
                lon               : numeric,
                opt           [1] : logical
        )

Arguments

   ESMF_filename

   Name of ESMF NetCDF file to write.
   lat
   lon

   The lat/lon arrays representing the unstructured grid.
   opt

   An optional variable to set certain attributes for this procedure. If set to False, none of the attributes will have an
   effect.

   See below for a full list of attributes.

Description

   This procedure writes the description of a an unstructured grid to an ESMF description file.

   unstructured_to_ESMF is part of a suite of regridding routines based on Earth System Modeling Framework (ESMF) software.
   The regridding can be done via a multi-step process that includes this procedure, or via an "all-in-one" function called
   ESMF_regrid.

   Both methods have their advantages. The multi-step process involves:
    1. Creating the description NetCDF file for the source grid.
    2. Creating the description NetCDF file for the destination grid.
    3. Calculating and writing the weights to a NetCDF file.
    4. Applying the weights to regrid the data from the source grid to the destination grid.
    5. Copying attributes and coordinates to the newly regridded variable.

   The ESMF_regrid function performs all of the above steps.

   The attributes that can be attached to opt include:
     * GridMask (old name is Mask2D) (no default) A mask array of the same size as the desired lat/lon grid, that indicates
       which areas to mask out (that is, which values are missing). Set the masked (missing) areas to 0, and all the rest to
       1.
       If these masks are different across multiple levels or timesteps, then you will need to generate a separate weights
       file for each level or timestep where it changes. See the special note below.
     * GridCornerLat / GridCornerLon (calculated internally if not provided)
       [Only needed for the "conserve" interpolation method.]
       These arrays indicate the corner (edge) points of your source grid. If you don't set these attributes, then they will
       be calculated for you using a generic algorithm.
       It is better to use your own calculated values, especially for unusual grids like the HOMME grid. The values must be
       provided as an N x 4 array, where N represents the dimensionality of the center lat/lon grid. For example, if the
       center lat/lon grid is dimensioned 256 x 220, then the corner arrays must be 256 x 220 x 4. Sometimes the corner
       grids are provided on the file along with the center grids, with names like "lat_vertices"/"lon_vertices" or
       "lat_bounds"/"lon_bounds".
     * NetCDFType (default = "netcdf3")
       You can set this option to "netcdf4" to force a NetCDF-4 file to be written for the weights file.
       Available in version 6.2.1 and later.
     * LargeFile (default = False) If set to True, then the NetCDF file will be written in "large file" mode.
     * Overwrite (default = False) If set to True, then if the description NetCDF file exists, you will be prompted for
       whether to remove it.
     * ForceOverwrite (default = False) If set to True, then the description NetCDF file will be overwritten no matter what.
     * InputFileName (no default) Optional: name of the file containing the unstructured grid.
     * LargeFile (default = False) If set to True, then the NetCDF file will be written in "large file" mode.
     * PrintTimings (default = False) Print the CPU time spent in this routine.
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


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:21:28 +0800
# vim:set fdm=indent foldlevel=0:
