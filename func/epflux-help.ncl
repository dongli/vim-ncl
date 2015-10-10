THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/epflux.shtml
THE_TITLE:epflux

epflux

   Compute quasi-geostrophic Eliassen-Palm fluxes at isobaric levels.

   [new.gif] Available in version 6.3.1 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function epflux (
                u        : numeric,  ; float, double, integer only
                v        : numeric,
                t        : numeric,
                plvl [*] : numeric,
                lat  [*] : numeric,
                opt  [1] : logical
        )

        return_val  :  Array of type list containing four quantities. See below.

Arguments

   u
   v
   t

   Arrays containing zonal (u) and meridional (v) wind components (m/s) abd temperatures (K). The arrays must be
   three-dimensional (plvl,lat,lon) or, more commonly, four-dimensional (time,plvl,lat,lon). Note: The grid structure must
   be rectilinear.
   plvl

   Array containing isobaric pressure levels (Pa or hPa [mb]).
   lat

   A one-dimensional array specifying the latitudes associated with the rectilinear grid.
   opt

   If opt=False, default options will always be used. If opt=True, assorted options are activated.
     * opt@raw ; Default is opt@raw=False. If opt@raw=True, return variables prior to any scaling.
     * opt@scale_sqrt_p ; Default is opt@scale_sqrt_p=True. Scale by sqrt(P0/plvl).
     * opt@magf ; Magnify (scale) Fphi and Fp at plvl.le.100 hPa; Default is no magnification.
         Return value
            A variable of type list containing four (4) variables with shape (plvl,nlat). The type is the same as u. The
            variables are the meridional (Fphi) and vertical (Fp) components of the EP-flux; the EP flux divergence (EPdiv)
            and the acceleration (dudt) from EP flux divergence. NOTE: The variables within the list can be accessed
            directly via NCL's list syntax. However, many users find it clearer to explicitly extract the variables from the
            list and subsequently delete the returned list variable. See examples.
            Description
            The Glossary of Meteorology defines the Eliassen-palm_flux as follows:
 A vector quantity with nonzero components in the latitudeâheight plane,
 the direction and magnitude of which determine the relative importance
 of eddy heat flux and momentum flux.

 When the Eliassen-Palm flux (EP) vector points upward, the meridional heat flux
 dominates; when the EPF vector points in the meridional direction, the meridional
 flux of zonal momentum dominates. The divergence of the Eliassen-Palm flux is more
 frequently used as a diagnostic tool, as it is proportional to the eddy potential
 vorticity flux. In the special case when the EP divergence is zero, as for steady,
 frictionless, linear waves, thermal wind balance is maintained in an idealized
 zonally symmetric atmosphere through the induction of a mean meridional circulation,
 even though the waves produce significant eddy heat and momentum fluxes.

            References:
 EP-Flux computations
  Guide: http://www.met.reading.ac.uk/~pn904784/snap/ep_flux_calculations.html
  Test:  http://www.met.reading.ac.uk/~pn904784/snap/ssw20122013.html

  Edmon,H.J., B.J. Hoskins,and M.E. McIntyre,1980:
  Eliassen-Palm cross sections for the troposphere.
  J. Atmos. Sci., 37:2600-2616
  doi: http://dx.doi.org/10.1175/1520-0469(1980)037<2600:EPCSFT>2.0.CO;2

            Acknowledgement:
The NCL function was based upon code developed by J. Barsugli (NOAA/PSD) and
adapted by C. Smith (NOAA/PSD).

         See Also
            static_stability, pot_temp
            Examples
            Example 1: Click Example which uses NCEP Reanalysis data.

            ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:17:44 +0800
# vim:set fdm=indent foldlevel=0:
