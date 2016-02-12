THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/potmp_insitu_ocn.shtml
THE_TITLE:potmp_insitu_ocn

potmp_insitu_ocn

   Calculate seawater potential temperature at an arbitrary reference pressure given insitu temperature, salinity and depth.

   [new.gif] Available in version 6.1.0 and later.

Prototype

        function potmp_insitu_ocn (
                t        : numeric,
                s        : numeric,
                pres     : numeric,
                pref [1] : numeric,
                dims     : integer,
                opt  [1] : logical
        )

        return_val  :  numeric

Arguments

   t

   A scalar or array containing insitu temperature (degC). This must be the same size and shape as s.
   s

   A scalar or array containing salinity (g/kg). This must be the same size and shape as t.
   pres

   Ocean pressure (decibars) corresponding to each t and s.
   pref

   Ocean reference pressure (decibars). Usually, this is 0.0
   dims

   The dimension(s) of t to which pres correspond. Must be consecutive and monotonically increasing.
   opt

   Options. When calculating potential temperature, this should be set to False. If opt=True and the attribute
   opt@reverse=True then the input temperatures are potential temperatures and the returned temperatures will be 'observed'
   temperature.

Return value

   If any t, s, pres or pref are double, the returned array will be double; otherwise, type float.

Description

   Calculate seawater potential temperature at an arbitrary reference pressure given insitu temperature and salinity.

   NOTE: This is not the method used used in the POP model. Rather, the method used in the following reference is used.
   References
     Computation of Potential Temperature of Seawater for an Arbitrary Reference Pressure
     N.P. Fofonoff
     Deep Sea Res. 1977, 24, 489-491

See Also

   depth_to_pres

Examples

   Example 1: Given insitu t and s calculate ocean potential temperature. The dims argument is 0 since a scalar is a
   one-dimensional array of size one.

       t    = 2.0              ; degC; insitu temperature
       s    = 35.0             ; g/kg
       pres = 1000             ; decibars
       pref = 0.0              ; user specified reference pressure (dbars)
       pot  = potmp_insitu_ocn(t,s,pres,pref, 0 ,False)       ; pot=1.939

   Example 2: Read observed ocean depths, temperatures and salinities and calculate ocean potential temperatures. These are
   one-dimensional so the dims argument is 0.
       dat  = asciiread("bath_ocean.txt", (/klev,3/), "float")
       d    = dat(:,0)          ; depth; meters;  (klev)
       t    = dat(:,1)          ; temp ; degC  ;  (klev)
       s    = dat(:,2)          ; salinity; g/kg; (klev)

       pref = 0.0               ; user specified reference pressure (dbars)
       pres@units = "decibar"   ; must be decibar units

       pd   = depth_to_pres( d, False )*10   ; bars*10 => decibars

       pot  = potmp_insitu_ocn(t,s,pd,pref, 0 ,False) ; pot(ntim,klev,nlat,nlon)

   Example 3: Read gridded insitu ocean temperatures and salinities and calculate ocean potential temperatures. The pres
   corresponds to the klev dimension of t and s, hence, dims should be set to 1.
       f    = addfile("OCEAN.nc", "r")
       t    = f->T              ; degC; (ntim,klev,nlat,nlon)
       s    = f->S              ; g/kg; ( 0  , 1  , 2  , 3  )
       zcm  = f->depth          ; cm  ;      (klev)
                                ; calculate pressure depth; convert input (cm) to meters
       pd   = depth_to_pres( zcm*0.01, False ) ; decibars

       pref = 0.0               ; user specified reference pressure (dbars)
       pres@units = "decibar"   ; must be decibar units

       pot  = potmp_insitu_ocn(t,s,pd,pref, 1 ,False) ; pot(ntim,klev,nlat,nlon)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:09:55 +0800
# vim:set fdm=indent foldlevel=0:
