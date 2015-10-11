THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/copy_VarMeta.shtml
THE_TITLE:copy_VarMeta

copy_VarMeta

   Copies all attributes, named dimensions and coordinate variables from one variable to another.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        procedure copy_VarMeta (
                var_from  ,
                var_to
        )

Arguments

   var_from

   An array of any dimensionality. Must have attributes, named dimensions and coordinate variables.
   var_to

   An array of any dimensionality. Its dimensions must be a subset of the leftmost dimensions of var_from. For example, if
   var_from is dimensioned time x lev x lat x lon, then var_to can be dimensioned:
    1. the same size
    2. time x lev x lat
    3. lev x lat
    4. lat

Description

   This procedure copies all attributes, named dimensions and coordinate variables from var_from to var_to.

   If var_from and var_to are not the same size, this procedure is "smart" enough to only calculate the appropriate number
   of dimensions possessed by var_to.

See Also

   There are many metadata tools

Examples

   Example 1

;---read in zonal winds
  a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/uv300.nc","r")
  u = a->U(1,:,:)
  v = a->V(1,:,:)

  spd = sqrt(u^2+v^2)    ; spd won't have any metadata
  copy_VarMeta(u,spd)    ; Copy metadata from u to spd


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:52 +0800
# vim:set fdm=indent foldlevel=0:
