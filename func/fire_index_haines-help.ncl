THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/fire_index_haines.shtml
THE_TITLE:fire_index_haines

fire_index_haines

   Computes the Haines fire index (aka: Lower Atmosphere Severity Index) from a sounding.

   [new.gif] Available in version 6.3.1 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function fire_index_haines (
                p   [*] : numeric,
                t   [*] : numeric,
                td  [*] : numeric,
                opt [1] : logical
        )

        return_val [3] :  float or double

Arguments

   p

   A one-dimensional array containing pressures (hPa).
   t
   td

   A one-dimensional array containing temperatures (degC) and dew point temperatures (degC), respectively
   opt

   Currently not used. Set to False.

Return value

   The return is a one-dimensional array of length 3. Elements 0, 1, 2 pertain to low, mid and high elevation.

Description

   See: Haines paper and Haines Index.

   The Haines_Index is technically the "Low Atmosphere Severity Index" ==> LASI. It consists of two parts:

     * (i) Stability Term: (Tpl - Tp2)
     * (ii) Moisture Term : (Tp1 - TDp1)

   The Haines Index can range between 2 and 6. The drier and more unstable the lower atmosphere the higher the index. Let
   ROS mean 'Risk Of Spread'. Then a Haines Severity Index of
     * 2-3= a very low ROS
     * 4= low ROS
     * 5= moderate ROS, and
     * 6= high ROS

   The Climate Analysis Center uses the low-level Haines for the Coastal and Midlands zones, and the mid-level Haines for
   the Upstate zones.

   The Haines Index is intended to be used all over the United States it is adaptable for three elevation regimes: Low
   Elevation, Middle Elevation and High Elevation. [See http://www.k3jae.com/wxHaines.php]
     * Low Elevation is for fires occurring at or very near sea level.
     * Middle Elevation is for fires burning in the 1000-3000 foot elevation range.
     * High Elevation is intended for fires burning above 3000 feet elevation.

Examples

     ; PRESSURE (MB; hPa)
       p  =(/ 1008.,1000.,950.,900.,850.,800.,750.,700.,650.,600., \
               550.,500.,450.,400.,350.,300.,250.,200., \
               175.,150.,125.,100., 80., 70., 60., 50., \
                40., 30., 25., 20. /)

     ; TEMPERATURE (C)
       t  =(/  29.3,28.1,23.5,20.9,18.4,15.9,13.1,10.1, 6.7, 3.1,   \
               -0.5,-4.5,-9.0,-14.8,-21.5,-29.7,-40.0,-52.4,   \
              -59.2,-66.5,-74.1,-78.5,-76.0,-71.6,-66.7,-61.3, \
              -56.3,-51.7,-50.7,-47.5 /)

     ; MIXING RATIO (g/kg)
       q  =(/  20.38,19.03,16.14,13.71,11.56,9.80,8.33,6.75,6.06,5.07, \
                3.88, 3.29, 2.39, 1.70,1.00,0.60,0.20,0.00,0.00, \
                0.00, 0.00, 0.00, 0.00,0.00,0.00,0.00,0.00,0.00, \
                0.00, 0.00 /)

     ; Haines Index (HI) requires dew point temperature so it must be derived

                                   ; Change units to those requires by 'relhum' function
       q    = q/1000.              ; (kg/kg)
       t    = t+273.15             ; K

       rh   = relhum(t, q, p*100)  ; p*100 => mb => Pa
       td   = dewtemp_trh(t,rh)    ; dew pt temperature [K]
       td   = td-273.15            ; [C] ; return to units required by 'haines_index_rawin'
       t    = t -273.15            ; [C]

      ;print(p+"  "+t+"  "+q+"  "+rh+"   "+td)

     ; assign meta data

     ; units [ @ ]
       p@units = "hPa"
       t@units = "degC"

     ; name dimensions [ ! ]
       p!0     = "p"
       t!0     = "p"
       td!0    = "p"

     ; assign coordinate values [ & ] to named dimensions
       p&p     = p
       t&p     = p
       td&p    = p

     ; look at data
     ; printVarSummary(p)
     ; printVarSummary(t)
     ; printVarSummary(td)

       printMinMax(t,0)

       HI   = fire_index_haines(p, t, td, False)
       print(HI)


   A sample output

     Variable: HI
     Type: float
     Total Size: 12 bytes
                 3 values
     Number of Dimensions: 1
     Dimensions and sizes:      [elevation | 3]
     Coordinates:
     Number Of Attributes: 5
       long_name :      Haines Index
       reference :      http://www.nwas.org/digest/papers/1988/Vol13-Issue2-May1988/Pg23-Haines.pdf
       info :   Low Atmosphere Stability Index (LASI)
       elevation :      ( Low, Medium, High )
       details :        http://www.erh.noaa.gov/cae/haines.htm

     (0)         3
     (1)         3
     (2)         2


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:17:57 +0800
# vim:set fdm=indent foldlevel=0:
