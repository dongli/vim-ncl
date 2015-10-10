THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/tdlnpa.shtml
THE_TITLE:tdlnpa

tdlnpa

   Draws the projection of a line joining two points in the reference parallelogram (for use with selected TDPACK routines).

   [new.gif] Available in version 4.3.1 and later.

Prototype

        procedure tdlnpa (
                wks  [1] : graphic,
                uvw1 [2] : float,
                uvw2 [2] : float
        )

Arguments

   wks

   An NCL workstation identifier for where you want to draw the surface. The wks identifier is one returned either from
   calling gsn_open_wks or calling create to create a Workstation object.

   uvw1
   uvw2

   Float arrays of 2 elements each specifying the first and second parallelogram coordinates in the reference parallelogram.

Description

   This routine is part of the low-level TDPACK package, which is a group of Fortran and C callable routines for projecting
   objects from a 3-dimensional coordinate system having U, V, and W axes to a 2-dimensional projection plane having X and Y
   axes and/or for drawing the projections of those objects. This can be referred to somewhat loosely as "drawing objects in
   three dimensions".

   Please see the documentation on TDLNPA for a full description of this procedure.

See Also

   Initialization routines: tdinit, tdpara, tdclrs

   Parameter access routines: tdgetp, tdgtrs, tdsetp, tdstrs

   Point transforming routines: tdprpt, tdprpa, tdprpi

   Line drawing routines: tdline, tdlndp, tdlpdp, tdcurv, tdcudp

   Grid drawing routines: tdgrds, tdgrid

   Label drawing routines: tdlbls, tdlbla, tdlblp, tdplch

   Surface drawing routines: tddtri, tdstri, tditri, tdmtri, tdttri, tdctri, tdotri, tdsort

   Simplified interface routines: tdez2d, tdez3d

Examples

   No examples are available for this function currently. Please see the documentation on TDLNPA for more information about
   this function.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:13:20 +0800
# vim:set fdm=indent foldlevel=0:
