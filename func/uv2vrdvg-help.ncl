THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/uv2vrdvg.shtml
THE_TITLE:uv2vrdvg

uv2vrdvg

   Computes the vorticity and divergence via spherical harmonics, given the u and v wind components on a gaussian grid.

Prototype

        procedure uv2vrdvg (
                u   : numeric,
                v   : numeric,
                vr  : float or double,
                dv  : float or double
        )

Arguments

   u
   v

   wind component (input, two or more dimensions, where the rightmost two dimensions must be lat x lon)
     * input values must be in ascending latitude order
     * input array must be on a global grid

   vr

   vorticity array (output, same dimensions as u and v, values will be in ascending latitude order)
   dv

   divergence array (output, same dimensions as u and v, values will be in ascending latitude order)

Description

   uv2vrdvg takes as input u and v and returns the vorticity and divergence in the arrays vr and dv. uv2vrdvg operates on a
   gaussian grid.

   This procedure does not handle missing values (defined by the _FillValue attribute). If any missing values are
   encountered in a particular 2D input grid, then all of the values in the corresponding output grids will be set to the
   missing value defined by the output grids' _FillValue attributes.

   Note: For the arrays whose rightmost two dimensions are nlat x nlon, the rest of the dimensions (if any) are collectively
   referred to as N. If the input/output arrays are just two dimensions, then N can either be considered equal to 1 or
   nothing at all.

   Arrays which have dimensions N x nlat x nlon should not include the cyclic (wraparound) points when invoking the
   procedures and functions which use spherical harmonics (Spherepack).

   If the input arrays u and v are on a fixed grid, uv2vrdvf should be used. Also, note that uv2vrdvg is the procedural
   version of uv2vrdvG.

   Note, if the input arrays are not global or contain missing data, then it is recommended that uv2vr_cfd be used to
   compute vorticity.

See Also

   uv2vrdvG,uv2vrdvf, uv2vrdvF, uv2vr_cfd, uv2vrg, uv2vrG, uv2vrf, uv2vrF, vr2uvg, dv2uvg, vrdv2uvg, uv2sfvpg

Examples

   Example 1

   Compute the vorticity and divergence given u and v on a gaussian grid. Also, compute the rotational wind components and
   the divergent wind components, and finally reconstruct the original wind from the divergence and vorticity fields.
begin
  nlat  = 128                                       ; dimensions
  mlon  = 256
  mlon1 = mlon+1
  fbfile = "uv300.hs"
                                       ; Generic Workstation setup
  nrec  = fbinnumrec(fbfile)           ; total number of records in the file
  ntim  = nrec/2                       ; number of time steps in dataset

  uvmsg = 1e+36

  dv    = new ( (/nlat,mlon /), float, uvmsg )  ; divergence
  vort  = new ( (/nlat,mlon /), float, uvmsg )  ; vorticity  (relative)
  ux    = new ( (/nlat,mlon /), float, uvmsg )  ; reconstructed u
  vx    = new ( (/nlat,mlon /), float, uvmsg )  ; reconstructed v
  ud    = new ( (/nlat,mlon /), float, uvmsg )
  vd    = new ( (/nlat,mlon /), float, uvmsg )
  ur    = new ( (/nlat,mlon /), float, uvmsg )
  vr    = new ( (/nlat,mlon /), float, uvmsg )

  do i = 0,nrec-1,2
   month = 1                         ; january
   if (i .ge. 2) then
       month = 7                     ; july
   end if

   work = fbinrecread(fbfile,i  ,(/nlat,mlon1/),"float")
   u    = work(:,0:mlon-1)
   work = fbinrecread(fbfile,i+1,(/nlat,mlon1/),"float")
   v    = work(:,0:mlon-1)

   uv2vrdvg (u,v,vort,dv)           ; u,v ==> div and vort
   dv2uvg   (dv,ud,vd)              ; dv  ==> divergent  wind components
   vr2uvg   (vort,ur,vr)            ; ur,vr > rotational wind components
   vrdv2uvg (vort,dv, ux,vx)        ; vr,dv > reconstruct original wind
  end do
end

Errors

   If jer or ker is equal to:

     1 : error in the specification of nlat
     2 : error in the specification of nlon
     4 : error in the specification of N (jer only)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:14:27 +0800
# vim:set fdm=indent foldlevel=0:
