THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/vr2uvf.shtml
THE_TITLE:vr2uvf

vr2uvf

   Computes the rotational wind components via spherical harmonics, given an array containing relative vorticity on a fixed
   grid.

Prototype

        procedure vr2uvf (
                vor  : numeric,
                ur   : float,    ; or double
                vr   : float     ; or double
        )

Arguments

   vor

   vorticity array (input, array with two or more dimensions, last two dimensions must be nlat x nlon)
     * input values must be in ascending latitude order
     * array must be on a global grid

   ur
   vr

   non-divergent wind components (output, same dimensions as vor, values will be in ascending latitude order)

Description

   vr2uvf computes the rotational wind components given an array, vor, containing relative vorticity. The results are stored
   in the arrays ur and vr. vr2uvf operates on a fixed grid.

   This procedure does not handle missing values (defined by the _FillValue attribute). If any missing values are
   encountered in a particular 2D input grid, then all of the values in the corresponding output grids will be set to the
   missing value defined by the output grids' _FillValue attributes.

   Input arrays should not include the cyclic (wraparound) points when invoking this procedure, or any procedure or function
   which uses spherical harmonics (Spherepack).

   If the input array vr is on a gaussian grid, vr2uvg should be used. Also, note that vr2uvf is the procedural version of
   vr2uvF.

See Also

   vr2uvg, vr2uvF, vr2uvG, vrdv2uvf, vrdv2uvF, vrdv2uvg, vrdv2uvG, uv2vrdvf, uv2vrdvg, uv2vrf, uv2vrg, uv2vr_cfd

Examples

   Example 1

   Compute relative vorticity from the wind component arrays u and v (on a fixed grid), and then compute the rotational wind
   components.

begin
  nlat  =  73                                       ; dimensions
  mlon  = 144
  mlon1 = mlon+1
  fbfile = "uv300.hs"
                                       ; Generic Workstation setup
  nrec  = fbinnumrec(fbfile)           ; total number of records in the file
  ntim  = nrec/2                       ; number of time steps in dataset

  uvmsg = 1e+20
  vort  = new ( (/nlat,mlon /), float, uvmsg )  ; vorticity  (relative)
  ur    = new ( (/nlat,mlon /), float, uvmsg )
  vr    = new ( (/nlat,mlon /), float, uvmsg )

  do i = 0,nrec-1,2
   month = 1                         ; January
   if (i .ge. 2) then
       month = 7                     ; July
   end if

   work = fbinrecread(fbfile,i  ,(/nlat,mlon1/),"float")
   u    = work(:,0:mlon-1)
   work = fbinrecread(fbfile,i+1,(/nlat,mlon1/),"float")
   v    = work(:,0:mlon-1)

   uv2vrf   (u,v,vort)               ; u,v ==> vorticity (rel)
   vr2uvf   (vort,ur,vr)             ; ur,vr > rotational wind components
  end do
end

Errors

   If jer or ker is equal to:

     1 : error in the specification of nlat
     2 : error in the specification of nlon
     4 : error in the specification of N (jer only)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:14:54 +0800
# vim:set fdm=indent foldlevel=0:
