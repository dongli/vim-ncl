THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/advect_variable.shtml
THE_TITLE:advect_variable

advect_variable

   Horizontally advect a variable on the globe.

   [new.gif] Available in version 6.3.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function advect_variable (
                u            : numeric,
                v            : numeric,
                x            : numeric,
                gridType [1] : integer,
                longName [1] : string,
                units    [1] : string,
                opt          : integer
        )

        return_val [dimsizes(x)] :  float or double

Arguments

   u

   Array containing zonal wind components (m/s). The array must be ordered south to north.
   v

   Array containing meridional wind components (m/s). Same size and shape as u.
   x

   Array containing a scalar quantity (eg: temperature, specific humidity,
   ). Same size and shape as u. gridType

   Grid type. gridType=0 means gaussian grid; gridType=1 means regular or fixed grid.
   longName

   A string to be used as the long_name of the advected variable.
   units

   A string specifying the units of the returned variable.
   opt

   option. Currently not used, set to 0.

Return value

   A multi-dimensional array of the same size and shape as x. The output will be double if u, v or x is of type double.

Description

   Calculate the horizontal advection of a quantity on the globe.

             adv_X =  U*(dX/dlon) + V*(dX/dlat)


   NOTE: This is a non-linear quantity. Generally, it is not appropriate to use (say) monthly means quantities. Rather, the
   elemental (hourly, 3-hr, 6-hr, daily) quantities should be used. Then the monthly average can be determined.

See Also

   pot_vort_hybrid, pot_vort_isobaric, static_stability_n, wind_component, wind_direction

Examples

   Note: The dimension names are those used by the CESM. NCL does not care what the dimensions are named.

   Example 1 Here the data are ordered south to north.

   f = addfile ("foo.nc", "r")
   u = f->U    ; (...,lat,lon)
   v = f->V
   T = f->T
               ; advection of temperature
   Tadv = advect_variable(u,v,T,0,"advection of temperature","m-K/s",0)

Example 2 Vertically integrate advected quantities: (a) hybrid levels; (b)sigma levels; (c) isobaric levels.


   diri = "./
   fili = "data.nc"
   fi   = addfile(diri+fili, "r")

   q  = fi->shum               ; (time,lev,lat,lon)
   u  = fi->uwnd
   v  = fi->vwnd

   grid  = 0                    ; gaussian grid
   adv_q = advect_variable(u, v, q, grid, "moisture advection", "(m/s)(kg/kg)",0)
   printVarSummary(adv_q)


   All the following require surface pressure.

   psfc  = fi->psfc              ; (time,lat,lon)


   Vertical integration requires layer thicknesses [delta p].

(a) hybrid levels =======================================

   p0    = 1000                  ; hPa (reference pressure)
                                 ; check units
   if (isatt(psfc,"units")) then
       if (psfc@units.eq."Pa" .or. psfc@units.eq."Pascals") then
           p0 = 100000           ; Pa
       end if
   end if
                                 ; read interface coefficients
   hyai = fi->hyai               ; pressure part
   hybi = fi->hybi               ; sigma part

                                 ; layer thicknesses
   dp   = dpres_hybrid_ccm(psfc,p0,hyai,hybi)

(b)sigma levels:  =======================================

        ; sigma interface ( half ) levels; one more than full sigma level
        ; same as hybi on hybrid coordinate system
   sigi = (/ 1.000000, 0.990000, 0.974180, 0.954590, 0.930540, 0.901350  \
           , 0.866420, 0.825270, 0.777730, 0.724010, 0.664820, 0.601350  \
           , 0.535290, 0.468600, 0.403340, 0.341370, 0.284210, 0.232860  \
           , 0.187830, 0.149160, 0.116540, 0.0894499,0.067230, 0.049200  \
           , 0.034690, 0.023090, 0.013860, 0.0065700,0.00001             /)
   hyai = sigi                   ; create same size and type as sigi
   hyai = 0.0                    ; set hyai to 0

                                 ; layer thicknesses
   dp   = dpres_hybrid_ccm(psfc,p0,hyai,sigi)

(c)isobaric levels: =======================================

    plev = f->lev  ; (/  1,  2,  3,  5,   7, 10, 20, 30, \
                   ;    50, 70,100,150, 200,250,300,400, \
                   ;   500,600,700,775, 850,925,1000 /)
    lev@units = "hPa"    ; to match PS

    ptop= 0             ; integrate 0==>psfc at each grid point
                        ; dp(ntim,klev,nlat,mlon)
    dp  = dpres_plevel(plev, psfc, ptop, 0)


Add metadata if desired

   copy_VarCoords(q, dp)
   dp@long_name = "layer thickness at each grid point"
   dp@units     = ps@units
   printVarSummary(dp)
   printMinMax(dp, 0)

Integrate:

   vopt  = 0     ; vertically weighted sum (integral)
   vint  = wgt_vertical_n(adv_q, dp, vopt, 1)
   printVarSummary(vint)
   printMinMax(vint, 0)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:19 +0800
# vim:set fdm=indent foldlevel=0:
