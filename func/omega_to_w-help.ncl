THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/omega_to_w.shtml
THE_TITLE:omega_to_w

omega_to_w

   Convert omega vertical velocity (Pa/s) to (m/s).

   [new.gif] Available in version 6.2.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function omega_to_w (
                omega  : numeric,  ; float, double, integer only
                p      : numeric,
                t      : numeric
        )

Arguments

   omega

   A variable of any dimensionality containing omega (Pa/s) Array size and shape must match p and t.
   p

   A variable containing pressure values (Pa). Array size and shape must match omega and t.
   t

   A variable containing temperature (K). Array size and shape must match omega and p.

Return value

   A double array is returned if omega is double, otherwise a float array of the same size and shape as omega is returned.

Description

   Converts vertical velocity (Pa/s), commonly denoted as omega to vertical velocity (m/s), commonly denoted as w. The
   approximate relationship used is:

       rgas = 287.058            ; J/(kg-K) => m2/(s2 K)
       g    = 9.80665            ; m/s2
       rho  = p/(rgas*t)         ; density => kg/m3
       w    = -omega/(rho*g)     ; array operation


See Also

   w_to_omega, wind_direction, wind_component

Examples

   Example 1: If (a) omega[*], p[*] and t[*]; (b) omega[*][*][*], p[*][*][*] and t[*][*][*]; (c) omega[*][*][*][*],
   p[*][*][*][*] and t[*][*][*][*] and all have the desired units then
       wa = omega_to_w(omega, p, t)         ; wa[*] (m/s)
       wb = omega_to_w(omega, p, t)         ; wb[*][*][*] (m/s)
       wc = omega_to_w(omega, p, t)         ; wc[*][*][*][*] (m/s)

   Example 2: Let omega(time,lev,lat,lon) and t(time,lev,lat,lon) and plevel(lev) have units hPa/day, degC and hPa,
   respectively.
                                         ; change units: hPa/day to Pa/s
       omega = omega*100./86400.         ; hPa=100Pa, day=86400s ; (hPa/day)(day/86400s)(100Pa/hPa)
       omega@units = "Pa/s

       t       = t + 273.15              ; degC -> degK
       t@units = "degK"
                                         ; make p[*] conform to omega[*][*][*][*]
       P       = conform(omega, p, 1)   ; P(:,:,:,:)
       P       = P*100                   ; hPa -> Pa
       P@units = "Pa"

       w       = omega_to_w(omega, P, t)      ; w[*][*][*][*] (m/s)

       delete(P)                          ; no longer needed


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:19:15 +0800
# vim:set fdm=indent foldlevel=0:
