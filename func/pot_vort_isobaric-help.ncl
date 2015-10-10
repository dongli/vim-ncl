THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/pot_vort_isobaric.shtml
THE_TITLE:pot_vort_isobaric

pot_vort_isobaric

   Compute potential vorticity on isobaric levels and a global grid.

   [new.gif] Available in version 6.3.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function pot_vort_isobaric (
                p        [*] : numeric,
                u            : numeric,
                v            : numeric,
                t            : numeric,
                lat      [*] : numeric,
                gridType [1] : integer,
                opt      [1] : integer
        )

        return_val [dimsizes(t)] :  float or double

Arguments

   p

   Array containing pressure (Pa) levels. Must be 1D (lev)
   u

   Array containing zonal wind components (m/s). Must be 3D (lev,lat,lon) or 4D (time,lev,lat,lon). The array must be
   ordered south to north.
   v

   Array containing meridional wind components (m/s). Same size and shape as u.
   t

   Array containing temperatures (K). Same size and shape as u.
   lat

   Latitudes ordered south to north.
   gridType

   Grid type. gridType=0 means gaussian grid; gridType=1 means regular or fixed grid.
   opt

     * opt=0: return potential vorticity
     * opt=1: return a list variable containing: potential vorticity, static stability, potential temperature

Return value

   A multi-dimensional array of the same size and shape as t. The output will be double if t is of type double.

Description

   Calculate the potential vorticity on isobaric levels on a global grid. The reason for the global grid is that highly
   accurate spherical harmonic functions are used to compute horizontal gradients.
References:
     Bluestein: Synoptic-Dynamic Meteorology in Midlatitudes pg 264  Eq 4.5.93

     Note: A nice basic discussion of PV may be found at:
     Mid-Latitude Atmospheric Dynamics: A First Course
     Jonathan E. Martin, Wiley 2006,   QC880.M36   , pp276-onward

See Also

   pot_vort_hybrid, static_stability, pot_temp,

Examples

   Note: The dimension names are those used by the CESM. NCL does not care what the dimensions are named.

   Worked potential vorticity examples are HERE.

   Example 1: Here the data are south to north.

     f   = addfile ("foo.nc", "r")
     U   = f->U    ; (time,lev,lat,lon) or (lev,lat,lon)
     V   = f->V
     T   = f->T    ; K
     lat = f->lat

     lev = f->lev  ; hPa
     lev = lev*100 ; convert units
     lev@units = "Pa"

     gridType  = 0       ; gaussian grid
     opt = 0
     PV = pot_vort_isobaric(lev,u,v,t,lat, gridType, opt)

   Example 2 Here the data are ordered north to south. Most reanalysis data sets are ordered north to south. Use NCL syntax
   to reorder the data.

     f   = addfile ("foo.nc", "r")
     U   = f->U   ; (time,lev,lat,lon)
     V   = f->V
     T   = f->T    ; K

     lev = f->lev  ; hPa
     lev = lev*100 ; convert units
     lev@units = "Pa"

     U   = U(:,:,::-1,:)    ; reorder to South -> North
     V   = V(:,:,::-1,:)
     T   = T(:,:,::-1,:)

     lat = T&lat
     gridType  = 1          ; fixed grid
     opt = 0

     PV = pot_vort_isobaric(lev,u,v,t,lat, gridType, opt)   ; Potential Vorticity


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:19:29 +0800
# vim:set fdm=indent foldlevel=0:
