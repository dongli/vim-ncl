THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/vrdv2uvf.shtml
THE_TITLE:vrdv2uvf

vrdv2uvf

   Computes the wind components via spherical harmonics, given vorticity and divergence on a fixed grid.

Prototype

        procedure vrdv2uvf (
                vr  : numeric,
                dv  : numeric,
                ud  : float,    ; or double
                vd  : float     ; or double
        )

Arguments

   vr

   vorticity array (input, array with two or more dimensions, last two dimensions must be nlat x nlon)
     * input values must be in ascending latitude order
     * input array must be on a global grid

   dv

   divergence array (input, same dimensions as vr)
     * values must be in ascending latitude order
     * input array must be on a global grid

   ud
   vd

   wind components (output, same dimensions as vr and dv, values will be in ascending latitude order)

Description

   vrdv2uvf computes the wind components given vorticity and divergent arrays vr and dv and store the results in the arrays
   ud and vd. vrdv2uvf operates on a fixed grid.

   This procedure does not handle missing values (defined by the _FillValue attribute). If any missing values are
   encountered in a particular 2D input grid, then all of the values in the corresponding output grids will be set to the
   missing value defined by the output grids' _FillValue attributes.

   Input arrays should not include the cyclic (wraparound) points when invoking this procedure, or any procedure or function
   which uses spherical harmonics (Spherepack).

   If the input arrays vr and dv are on a gaussian grid, vrdv2uvg should be used. Also, note that vrdv2uvf is the procedural
   version of vrdv2uvF.

See Also

   vrdv2uvg, vrdv2uvF, vrdv2uvG, uv2vrdvf, uv2vrdvg, uv2dvf, uv2dvg, uv2vrf, uv2vrg, uv2vr_cfd

Examples

   Example 1

   Given the wind components u and v (on a fixed grid), compute the relative vorticity and divergence, and then reconstruct
   the wind components from the vorticity and divergence fields.

begin
  nlat  =  73                                       ; dimensions
  mlon  = 144
  mlon1 = mlon+1
  fbfile = "uv300.hs"
                                       ; Generic Workstation setup
  nrec  = fbinnumrec(fbfile)           ; total number of records in the file
  ntim  = nrec/2                       ; number of time steps in dataset

  uvmsg = 1e+36

  dv    = new ( (/nlat,mlon /), float, uvmsg )  ; divergence
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

   uv2vrdvf (u,v, vort,dv)           ; u,v ==> div and vort
   vrdv2uvf (vort,dv, uu,vv)         ; vr,dv > reconstruct original wind
  end do
end

Errors

   If jer or ker is equal to:

     1 : error in the specification of nlat
     2 : error in the specification of nlon
     4 : error in the specification of N (jer only)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:14:56 +0800
# vim:set fdm=indent foldlevel=0:
