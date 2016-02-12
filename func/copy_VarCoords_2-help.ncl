THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/copy_VarCoords_2.shtml
THE_TITLE:copy_VarCoords_2

copy_VarCoords_2

   Copies all named dimensions and coordinate variables from one variable to another except for the rightmost two
   dimensions.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        procedure copy_VarCoords_2 (
                var_from  ,
                var_to
        )

Arguments

   var_from

   An array of any dimensionality. Must have named dimensions and coordinate variables
   var_to

   An array of any dimensionality.

Description

   This procedure copies all named dimensions and coordinate variables from one variable to another except for the rightmost
   two dimensions.

See Also

   There are many metadata tools.

Examples

   Example 1

  fo = natgrid (xi,yi,fi, xo,yo)            ; perform interpolation

  copy_VarAtts (fi, fo)         ; copy variable attributes
  copy_VarCoords_2 (fi, fo)     ; copy left coordinate arrays if present


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:51 +0800
# vim:set fdm=indent foldlevel=0:
