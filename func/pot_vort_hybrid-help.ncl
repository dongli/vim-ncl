THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/pot_vort_hybrid.shtml
THE_TITLE:pot_vort_hybrid

pot_vort_hybrid

   Compute potential vorticity on hybrid levels and a global grid.

   [new.gif] Available in version 6.3.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function pot_vort_hybrid (
                p            : numeric,
                u            : numeric,
                v            : numeric,
                t            : numeric,
                lat      [*] : numeric,
                gridType [1] : integer,
                opt          : integer
        )

        return_val [dimsizes(t)] :  float or double

Arguments

   p

   Array containing pressure levels. Must be (lev,lat,lon) or (time,lev,lat,lon)
   u

   Array containing zonal wind components (m/s). Same size and shape as p.
   v

   Array containing meridional wind components (m/s). Same size and shape as p.
   t

   Array containing temperatures (K). Same size and shape as p.
   gridType

   Grid type. gridType=0 means gaussian grid; gridType=1 means regular or fixed grid.
   opt

     * opt=0: return potential vorticity
     * opt=1: return a list variable containing: potential vorticity, static stability, potential temperature

Return value

   A multi-dimensional array of the same size and shape as t. The output will be double if t is of type double.

Description

   Calculate the potential vorticity on hybrid levels on a global grid. The reason for the global grid is that highly
   accurate spherical harmonic functions are used to compute horizontal gradients.

Reference:
    Compute Isentropic Potential Vorticity on hybrid levels
    CCM Processor User's Guide: May 1994: page B-19
    Original source P Rasch and B Boville

Note: A nice basic discussion of PV may be found at:
Mid-Latitude Atmospheric Dynamics: A First Course
Jonathan E. Martin, Wiley 2006,   QC880.M36   , pp276-onward


See Also

   pot_vort_isobaric, static_stability, pot_temp

Examples

   Worked examples are HERE.

   Example 1

     f    = addfile("foo.nc", "r")
     U    = f->U   ; (time,lev,lat,lon) or (lev,lat,lon)
     V    = f->V
     T    = f->T
     lat  = f->lat

     hyam = f->hyam
     hybm = f->hybm
     p0   = f->P0  ; p0=100000
     ps   = f->PS  ; Pa
     p    = pres_hybrid_ccm (ps,p0,hyam,hybm)  ; Pa [kg/(m s2)]
     copy_VarCoords(U,p)

     gridType = 0  ; gaussian grid
                   ; Potential Vorticity
     PV = pot_vort_hybrid(p,u,v,t,lat, gridType,  0)

   Example 2 Here the data are ordered north to south. Most reanalysis data sets are ordered north to south. Use NCL syntax
   to reorder the data.

     f    = addfile ("foo.nc", "r")
     U    = f->U    ; (time,lev,lat,lon) or (lev,lat,lon)
     V    = f->V
     T    = f->T

     U    = U(:,:,::-1,:)    ; reorder to South -> North
     V    = V(:,:,::-1,:)
     T    = T(:,:,::-1,:)

     lat  = T&lat
     gridType  = 1          ; fixed grid
     opt = 0

     hyam = f->hyam
     hybm = f->hybm
     p0   = f->P0  ; p0=100000
     ps   = f->PS  ; Pa
     p    = pres_hybrid_ccm (ps,p0,hyam,hybm)  ; Pa [kg/(m s2)]
     copy_VarCoords(U,p)


     PV = pot_vort_hybrid(lev,u,v,t,lat, gridType, opt)   ; Potential Vorticity


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:19:27 +0800
# vim:set fdm=indent foldlevel=0:
