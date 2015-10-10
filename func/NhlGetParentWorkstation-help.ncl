THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/NhlGetParentWorkstation.shtml
THE_TITLE:NhlGetParentWorkstation

NhlGetParentWorkstation

   Returns the ids of the parent workstations of the given objects.

Prototype

        function NhlGetParentWorkstation (
                objs  : graphic
        )

        return_val [dimsizes(objs)] :  graphic

Arguments

   objs

   An array of one or more NCL View objects whose parent workstation ids are desired.

Description

   This function returns an array of parent Workstation ids that are the parent workstations of the given objects. If an
   object is not a View object and hence does not have a parent workstation associated with it, a missing value is returned.

See Also

   NhlChangeWorkstation, NhlAppGetDefaultParentId, NhlGetWorkspaceObjectId, NhlGetParentId

Examples

   Example 1

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

begin
  wks = gsn_open_wks("ncgm","test")

  npts = 500
  x    = fspan(0,npts-1,npts)
  y    = 500.+ 0.9 * x * sin(0.031415926535898*x)
  xy   = gsn_y(wks,y,False)

  parent_ids = NhlGetParentWorkstation((/wks,xy/))
  print(parent_ids)

end


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:08:51 +0800
# vim:set fdm=indent foldlevel=0:
