THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/static_stability.shtml
THE_TITLE:static_stability

static_stability

   Compute static stability.

   [new.gif] Available in version 6.3.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function static_stability (
                p        : numeric,  ; float, double, integer only
                t        : numeric,
                dim  [1] : integer,
                sopt [1] : integer
        )

        return_val [dimsizes(t)] :  float or double

Arguments

   p

   Array containing pressure levels (Pa).
   t

   Array containing temperatures (K).
   dim

   The dimension of t which corresponds to p.
   sopt

     * sopt=0, Return static stability only
     * sopt=1, Return static stability, theta, dthdp as type list
         Return value
            A multi-dimensional array of the same size and shape as t. The output will be double if t is of type double.
            Description

  Reference:
  Bluestein: Synoptic-Dynamic Meteorology in Midlatitudes
             pg 197
             s = -T*d[log(theta)]/dp = -(T/theta)*d(theta)/dp


            See Also
            wind_component, wind_direction, pot_temp
            Examples
            Example 1: Return static stability only.

; PRESSURE
     p1  =(/ 1008.,1000.,950.,900.,850.,800.,750.,700.,650.,600., \
               550.,500.,450.,400.,350.,300.,250.,200., \
               175.,150.,125.,100., 80., 70., 60., 50., \
                40., 30., 25., 20. /)*100
     p1@units = "Pa"

; TEMPERATURE (C)
     t1   =(/  29.3,28.1,23.5,20.9,18.4,15.9,13.1,10.1, 6.7, 3.1,   \
               -0.5,-4.5,-9.0,-14.8,-21.5,-29.7,-40.0,-52.4,   \
              -59.2,-66.5,-74.1,-78.5,-76.0,-71.6,-66.7,-61.3, \
              -56.3,-51.7,-50.7,-47.5 /)

     t1   = t1 + 273.15                   ; change to Kelvin
     t1@units = "K"

     s1   = static_stability (p1, t1, 0, 0)  ; dim=0, opt=0

     printVarSummary(s1)
     print(p1+"  "+t1+"  "+s1)


            would yield

     Variable: s1
     Type: float
     Total Size: 120 bytes
                 30 values
     Number of Dimensions: 1
     Dimensions and sizes:   [30]
     Coordinates:
     Number Of Attributes: 2
       long_name :   static stability
       units :       K/Pa

         p(Pa)   t(K)    s(K/Pa)
(0)     100800  302.45  -0.00064084
(1)     100000  301.25  -0.000125448
(2)      95000  296.65  0.000176932
(3)      90000  294.05  0.00042571
(4)      85000  291.55  0.000482328
(5)      80000  289.05  0.000504421
(6)      75000  286.25  0.000513097
(7)      70000  283.25  0.000518761
(8)      65000  279.85  0.000533717
(9)      60000  276.25  0.000600369
(10)     55000  272.65  0.00066135
(11)     50000  268.65  0.00069125
(12)     45000  264.15  0.000652553
(13)     40000  258.35  0.000604632
(14)     35000  251.65  0.000575345
(15)     30000  243.45  0.00048334
(16)     25000  233.15  0.000421649
(17)     20000  220.75  0.000472445
(18)     17500  213.95  0.000697178
(19)     15000  206.65  0.000996432
(20)     12500  199.05  0.00226535
(21)     10000  194.65  0.00519965
(22)      8000  197.15  0.00892678
(23)      7000  201.55  0.0129963
(24)      6000  206.45  0.0151663
(25)      5000  211.85  0.0175898
(26)      4000  216.85  0.0208443
(27)      3000  221.45  0.0230898
(28)      2500  222.45  0.0303216
(29)      2000  225.65  0.0339061



            Example 2
            Same as Example 1 but opt=1 so three variables are returned: static stability, potential temperature and
            d(theta)dp.

     opt = 1       ; return 3 varaibles as part of a list
     dim = 0
     S1  = static_stability (p1, t1, opt, dim)

     printVarSummary(S1)

     S1_s     = S1[0]   ; explicitly extract each variable from the list
     S1_pt    = S1[1]   ; not necessary but clearer
     S1_dthdp = S1[2]

     printVarSummary(S1_s)
     printVarSummary(S1_pt)
     printVarSummary(S1_dthdp)


            would yield

     Variable: S1
     Type: list
     Total items: 3


     Variable: S1_s
     Type: float
     Total Size: 120 bytes
                 30 values
     Number of Dimensions: 1
     Dimensions and sizes:   [30]
     Coordinates:
     Number Of Attributes: 2
       long_name :   static stability
       units :       K/Pa

     Variable: S1_pt
     Type: float
     Total Size: 120 bytes
                 30 values
     Number of Dimensions: 1
     Dimensions and sizes:   [30]
     Coordinates:
     Number Of Attributes: 2
       units :       K
       long_name :   potential temperature

     Variable: S1_dthdp
     Type: float
     Total Size: 120 bytes
                 30 values
     Number of Dimensions: 1
     Dimensions and sizes:   [30]
     Coordinates:
     Number Of Attributes: 2
       long_name :   vertical derivative of theta with pressure
       units :       K/Pa

         p(Pa)   t(K)    s(K/Pa)     Pot(K)    d(theta)dp
(0)     100800  302.45  -0.00064084  301.762   0.000639381
(1)     100000  301.25  -0.00012544  301.25    0.000125448
(2)      95000  296.65  0.000176932  301.034  -0.000179547
(3)      90000  294.05  0.00042571   303.045  -0.000438733
(4)      85000  291.55  0.000482328  305.421  -0.000505276
(5)      80000  289.05  0.000504421  308.098  -0.000537662
(6)      75000  286.25  0.000513097  310.798  -0.000557098
(7)      70000  283.25  0.000518761  313.669  -0.000574472
(8)      65000  279.85  0.000533717  316.543  -0.000603696
(9)      60000  276.25  0.000600369  319.706  -0.000694812
(10)     55000  272.65  0.00066135   323.491  -0.000784671
(11)     50000  268.65  0.00069125   327.553  -0.00084281
(12)     45000  264.15  0.000652553  331.919  -0.000819968
(13)     40000  258.35  0.000604632  335.753  -0.000785782
(14)     35000  251.65  0.000575345  339.777  -0.000776828
(15)     30000  243.45  0.00048334   343.521  -0.000682019
(16)     25000  233.15  0.000421649  346.597  -0.000626816
(17)     20000  220.75  0.000472445  349.789  -0.000748612
(18)     17500  213.95  0.000697178  352.211  -0.00114772
(19)     15000  206.65  0.000996432  355.528  -0.00171429
(20)     12500  199.05  0.00226535   360.783  -0.00410601
(21)     10000  194.65  0.00519965   376.058  -0.0100456
(22)      8000  197.15  0.00892678   405.988  -0.0183828
(23)      7000  201.55  0.0129963    431.206  -0.0278049
(24)      6000  206.45  0.0151663    461.598  -0.0339099
(25)      5000  211.85  0.0175898    499.026  -0.0414339
(26)      4000  216.85  0.0208443    544.465  -0.0523356
(27)      3000  221.45  0.0230898    603.697  -0.0629453
(28)      2500  222.45  0.0303216    638.883  -0.0870846
(29)      2000  225.65  0.0339061    690.782  -0.103797


            Example 3: Calculate the static stability for the following.
Let p1 be a one-dimensional array containing isobaric levels: p1(klev);
Let p2 be a two-dimensional array containing isobaric levels: p2(klev,ncol);
Let p3 be a three-dimensional array containing pressure levels: p3(klev,nlat,mlon);
Let p4 be a four-dimensional  array containing pressure levels: p4(ntim,klev,nlat,mlon);
Let p5 be a five-dimensional  array containing pressure levels: p5(nens,ntim,klev,nlat,mlon);

Let t1 be a one-dimensional array containing temperature: t1(klev);        (0)
Let t2 be a two-dimensional array containing temperature: t2(klev,ncol);   (0,1)
let t3 be a three-dimensional (klev,nlat,mlon);                            (0,1,2)
let t4 be a four-dimensional  (ntim,klev,nlat,mlon);                       (0,1,2,3)
let t5 be a five-dimensional  (nens,ntim,klev,nlat,mlon)                   (0,1,2,3,4)

     s1  = static_stability(p1,t1, 0, sopt)
     s3  = static_stability(p1,t2, 0, sopt)
     s3  = static_stability(p1,t3, 0, sopt)
     s4  = static_stability(p1,t4, 1, sopt)
     s5  = static_stability(p1,t5, 2, sopt)

     s33 = static_stability(p3,t3, 0, sopt)
     s44 = static_stability(p4,t4, 1, sopt)



            ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:10 +0800
# vim:set fdm=indent foldlevel=0:
