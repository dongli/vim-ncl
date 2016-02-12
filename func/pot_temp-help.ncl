THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/pot_temp.shtml
THE_TITLE:pot_temp

pot_temp

   Compute potential temperature.

   [new.gif] Available in version 6.3.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function pot_temp (
                p       : numeric,  ; float, double, integer only
                t       : numeric,
                dim [1] : integer,
                opt [1] : logical
        )

        return_val [dimsizes(t)] :  float or double

Arguments

   p

   Array containing pressure levels.
   t

   Array containing temperatures (K).
   dim

   The dimension of t which corresponds to p. NOTE: If the rank and sizes of t are the same as those of p this argument is
   ignored. A suggested placeholder is dim=-1.
   opt

   option. Currently not used. Set to False

Return value

   A multi-dimensional array of the same size and shape as t. The output will be double if t is of type double.

Description

   Calculate the potential temperature (theta) via the standard meteorological formula:

         theta = t*(p0/p)^0.286


   The function does check units (if present) to make sure they are correct.

   Also, the equivalent temperature (teqv) could be input. The equivalent temperature represents an air parcel from which
   all the water vapor has been extracted by an adiabatic process. It may be calculated via:
         cpd  = 1004. or 1005.7 ; specific heat dry air [J/kg/K]
         Lv   = 2.5104e6        ; [J/kg]=[m2/s2]  Latent Heat of Vaporization of Water
         r    = mixing_ratio    ; [kg/kg]; same size and shape as t
         teqv = t + (Lv/cpd)*r  ;

   From Wikipedia: "Potential temperature is a more dynamically important quantity than the actual temperature. This is
   because it is not affected by the physical lifting or sinking associated with flow over obstacles or large-scale
   atmospheric turbulence. A parcel of air moving over a small mountain will expand and cool as it ascends the slope, then
   compress and warm as it descends on the other side- but the potential temperature will not change in the absence of
   heating, cooling, evaporation, or condensation (processes that exclude these effects are referred to as dry adiabatic).
   Since parcels with the same potential temperature can be exchanged without work or heating being required, lines of
   constant potential temperature are natural flow pathways."

See Also

   static_stability, wind_component, wind_direction

Examples

   Example 1

; PRESSURE
     p1  =(/ 1008.,1000.,950.,900.,850.,800.,750.,700.,650.,600., \
               550.,500.,450.,400.,350.,300.,250.,200., \
               175.,150.,125.,100., 80., 70., 60., 50., \
                40., 30., 25., 20. /)*100
     p1@units = "Pa"

; TEMPERATURE (C)
     t1  =(/  29.3,28.1,23.5,20.9,18.4,15.9,13.1,10.1, 6.7, 3.1,   \
              -0.5,-4.5,-9.0,-14.8,-21.5,-29.7,-40.0,-52.4,   \
             -59.2,-66.5,-74.1,-78.5,-76.0,-71.6,-66.7,-61.3, \
             -56.3,-51.7,-50.7,-47.5 /)

     t1  = t1 + 273.15
     t1@units = "degK"

     dim = 0
     pt1 = pot_temp(p1, t1, 0, False)  ; dim=0


   would yield

     Variable: pt1
     Type: float
     Total Size: 120 bytes
                 30 values
     Number of Dimensions: 1
     Dimensions and sizes:   [30]
     Coordinates:
     Number Of Attributes: 2
       long_name :   potential temperature
       units :       K

              p(Pa)   t(K)    pot(K)
     (0)     100800  302.45  301.762
     (1)     100000  301.25  301.25
     (2)      95000  296.65  301.034
     (3)      90000  294.05  303.045
     (4)      85000  291.55  305.421
     (5)      80000  289.05  308.098
     (6)      75000  286.25  310.798
     (7)      70000  283.25  313.669
     (8)      65000  279.85  316.543
     (9)      60000  276.25  319.706
     (10)     55000  272.65  323.491
     (11)     50000  268.65  327.553
     (12)     45000  264.15  331.919
     (13)     40000  258.35  335.753
     (14)     35000  251.65  339.777
     (15)     30000  243.45  343.521
     (16)     25000  233.15  346.597
     (17)     20000  220.75  349.789
     (18)     17500  213.95  352.211
     (19)     15000  206.65  355.528
     (20)     12500  199.05  360.783
     (21)     10000  194.65  376.058
     (22)      8000  197.15  405.988
     (23)      7000  201.55  431.206
     (24)      6000  206.45  461.598
     (25)      5000  211.85  499.026
     (26)      4000  216.85  544.465
     (27)      3000  221.45  603.697
     (28)      2500  222.45  638.883
     (29)      2000  225.65  690.782


   Example 2: Calculate the potential temperature for each. Some examples:

Let p1 be a one-dimensional array containing isobaric levels: p1(klev);
Let p2 be a two-dimensional array with pressure levels: p2(klev,ncol);
Let p3 be a three-dimensional array with pressure levels: p3(klev,nlat,mlon);
Let p4 be a four-dimensional  array with pressure levels: p4(ntim,klev,nlat,mlon);
Let p5 be a four-dimensional  array with pressure levels: p5(ncase,ntim,klev,nlat,mlon);

Let P3 be a three-dimensional array with pressure levels: P3(ntim,klev,ncol);
Let P4 be a  four-dimensional array with pressure levels: P4(ncase,ntim,klev,ncol);

let t1 be a   one-dimensional t1(klev);                    (0)
let t2 be a   two-dimensional t2(klev,ncol);               (0,1)
let t3 be a three-dimensional t3(klev,nlat,mlon);          (0,1,2)
let t4 be a four-dimensional  t4(ntim,klev,nlat,mlon);     (0,1,2,3)
let t5 be a five-dimensional  t5(nens,ntim,klev,nlat,mlon) (0,1,2,3,4)

Let T3 be a three-dimensional array: T3(ntim,klev,ncol);        (0,1,2)
Let T4 be a  four-dimensional array: T4(ncase,ntim,klev,ncol);  (0,1,2,3)


          ; isobaric
     pt1  = pot_temp(p1 ,t1 , 0, False)
     pt2  = pot_temp(p1 ,t2 , 0, False)
     pt3  = pot_temp(p1 ,t3 , 0, False)
     pt4  = pot_temp(p1 ,t4 , 1, False)
     pt5  = pot_temp(p1 ,t5 , 2, False)

     pT3  = pot_temp(p1 ,T3 , 1, False)
     pT4  = pot_temp(p1 ,T4 , 2, False)

          ; non-isobaric (variable ranks match)
     pt11 = pot_temp(p1 ,t1 ,-1, False)   ; same as pt1
     pt22 = pot_temp(p2 ,t2 ,-1, False)
     pt33 = pot_temp(p3 ,t3 ,-1, False)
     pt44 = pot_temp(p4 ,t4 ,-1, False)
     pt55 = pot_temp(p5 ,t5 ,-1, False)

     PT33 = pot_temp(P3 ,T3 ,-1, False)
     PT44 = pot_temp(P4 ,T4 ,-1, False)



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:19:26 +0800
# vim:set fdm=indent foldlevel=0:
