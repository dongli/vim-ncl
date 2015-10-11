THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/copy_VarCoords.shtml
THE_TITLE:copy_VarCoords

copy_VarCoords

   Copies all named dimensions and coordinate variables from one variable to another.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        procedure copy_VarCoords (
                var_from  ,
                var_to
        )

Arguments

   var_from

   An array of any dimensionality. Must have named dimensions and coordinate variables. An array of any dimensionality.

Description

   This procedure copies all named dimensions and coordinate variables from one variable to another.

See Also

   There are many metadata tools.

Examples

   Example 1

;---read in netCDF file and read in data
  cdf_file = addfile("slp.1963.nc","r")
  slp      = cdf_file->slp(:,::-1,:)                     ; slp has coordinate arrays

  newslp = ((slp*slp@scale_factor)+slp@add_offset)*.01   ; newslp won't have any coordinate arrays
  copy_VarCoords(slp,newslp)                             ; copy coordinate arrays from slp to newslp


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:49 +0800
# vim:set fdm=indent foldlevel=0:
