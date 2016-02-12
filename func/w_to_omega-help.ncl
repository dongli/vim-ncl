THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/w_to_omega.shtml
THE_TITLE:w_to_omega

w_to_omega

   Convert vertical velocity with units (m/s) to Pa/s.

   [new.gif] Available in version 6.2.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function w_to_omega (
                w  : numeric,  ; float, double, integer only
                p  : numeric,
                t  : numeric
        )

Arguments

   w

   A variable of any dimensionality containing vertical velocity with units (m/s) Array size and shape must match p and t.
   p

   A variable containing pressure values (Pa). Array size and shape must match omega and t.
   t

   A variable containing temperature (K). Array size and shape must match omega and p.

Return value

   A double array is returned if w is double, otherwise a float array of the same size and shape as w is returned.

Description

   Converts vertical velocity (m/s), commonly denoted as w to vertical velocity (Pa/s), commonly denoted as omega. The
   approximate relationship used is:

       rgas  = 287.058            ; J/(kg-K) => m2/(s2 K)
       g     = 9.80665            ; m/s2
       rho   = p/(rgas*t)         ; density => kg/m3
       omega = -w*rho*g           ; array operation


See Also

   omega_to_w, wind_direction, wind_component

Examples

   Example 1: If (a) w[*], p[*] and t[*]; (b) w[*][*][*], p[*][*][*] and t[*][*][*]; (c) w[*][*][*][*], p[*][*][*][*] and
   t[*][*][*][*] and all have the desired units then:
       oa = w_to_omega(w, p, t)         ; oa[*] (Pa/s)
       ob = w_to_omega(w, p, t)         ; ob[*][*][*] (Pa/s)
       oc = w_to_omega(w, p, t)         ; oc[*][*][*][*] (Pa/s)

   Example 2: Let w(time,lev,lat,lon) and t(time,lev,lat,lon) and plevel(lev) have units mm/day, degC and hPa, respectively.
                                     ; change units: mm/day to Pa/s
       w       = w*/(1000.*86400.)   ; 1m/1000mm, 86400s/day; (mm/day)(day/86400s)(m/1000mm)
       omega@units = "Pa/s

       t       = t + 273.15          ; degC -> degK
       t@units = "degK"
                                     ; make p[*] conform to w[*][*][*][*]
       P       = conform(w, p, 1)     ; P(:,:,:,:)
       P       = P*100               ; hPa -> Pa
       P@units = "Pa"

       omega   = w_to_omega(w, P, t)         ; omega[*][*][*][*] (Pa/s)

       delete(P)        ; no longer needed


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:32 +0800
# vim:set fdm=indent foldlevel=0:
