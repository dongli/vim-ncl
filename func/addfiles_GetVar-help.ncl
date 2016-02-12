THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/addfiles_GetVar.shtml
THE_TITLE:addfiles_GetVar

addfiles_GetVar

   Creates a reference that spans multiple data files and returns metadata. (deprecated: see addfiles)

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function addfiles_GetVar (
                f         : list,
                files [*] : string,
                name      : string
        )

        return_val [1] :  list

Arguments

   f

   The list of files returned from addfiles returns (e.g. f_list = addfiles (fils+".nc", "r")).
   files

   A one-dimensional array that equal the file names to access.
   name

   A one-dimensional array or scalar value equal to the variable to be retrieved from f. Must match the syntax and case
   sensitivity of the variable.

Return value

   An array of any dimensionality or type. This is the variable selected by name on files.

Description

   The addfiles in NCL version 5.1.0 (March 2009) was upgraded to return metadata. It is faster and more flexible than
   addfiles_GetVar. We highly recommend that you use addfiles. Basically, in place of:
     T = addfiles_GetVar(f,fils,"T")

   you can use:

     T = f[:]->T

   This is an old routine that was a follow-on to an old version of addfiles, which initally didn't return any metadata.
   This routine would read in a variable AND return the appropriate attributes and coordinate variables. It assumes that in
   the case of an addfiles join argument, that the leftmost dimension is the coordinate variable that must be specially
   treated.

See Also

   addfiles, ListSetType

Examples

   Example 1

   Consider a directory that has five multiple netCDF files: annual_1.nc, annual_2.nc, ..., annual_5.nc. Each file has
   variables with 12 time steps.

   OLD WAY (see NEW WAY below)
     load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

     fils = systemfunc("ls /model/annual*nc")
     f    = addfiles(fils, "r")           ; note the "s" of addfile
     T    = addfiles_GetVar(f,fils,"T")
     printVarSummary(T)

   NEW WAY

     load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

     fils = systemfunc("ls /model/annual*nc")
     f    = addfiles(fils, "r")           ; note the "s" of addfile
     T    = f[:]->T
     printVarSummary(T)

   The output yields:
     Variable: T
     Type: float
     Total Size: 5529600 bytes
                 1382400 values
     Number of Dimensions: 4
     Dimensions and sizes:   [time | 60] x [lev 5] x [lat | 48] x [lon | 96]
     Coordinates:
          time: [2349..4143]
          lev: [850..200]
          lat: [-87.15909..87.15909]
          lon: [ 0..356.25]

   Note A: If the file names did not have the .nc extension, then the user could indicate that the files are netCDF by
   appending the extension via an NCL statement. The actual names of the files on the disk need not be altered.
       fils = systemfunc("ls /model/annual*") +".nc"

   Note B: This approach can be used for any supported format: .nc, .grb, .hdf, .hdfeos

   Example 2

   Same as Example 1 but with the "join" option specified.

   OLD WAY (see NEW WAY below)
     load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

     fils = systemfunc("ls /model/annual*")
     f    = addfiles(fils, "r")           ; note the "s" of addfile

     ListSetType (f, "join")

     T    = addfiles_GetVar(f,fils,"T")
     printVarSummary(T)

   NEW WAY

     load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

     fils = systemfunc("ls /model/annual*")
     f    = addfiles(fils, "r")           ; note the "s" of addfile

     ListSetType (f, "join")

     T    = f[:]->T
     printVarSummary(T)

   The output yields:

     Variable: T
     Type: float
     Total Size: 5529600 bytes
                 1382400 values
     Number of Dimensions: 5
     Dimensions and sizes:   [case | 5] x [time | 12] x [lev | 5] x [lat | 48] x [lon

     | 96]
     Coordinates:
                 case: [0..4]
                 time: [2349..2683]
                 lev: [850000..200]
                 lat: [-87.15909..87.15909]
                 lon: [ 0..356.25]

     Number Of Attributes: 3
       missing_value :       1e+36
       units :
       long_name :   temperature


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:17 +0800
# vim:set fdm=indent foldlevel=0:
