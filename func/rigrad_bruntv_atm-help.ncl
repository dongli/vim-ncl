THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/rigrad_bruntv_atm.shtml
THE_TITLE:rigrad_bruntv_atm

rigrad_bruntv_atm

   Compute the gradient Richardson number and, optionally, the Brunt-Vaisala, buoyancy and shear.

   [new.gif] Available in version 6.3.1 or 6.4.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function rigrad_bruntv_atm (
                thv     : numeric,  ; float, double, integer only
                u       : numeric,
                v       : numeric,
                z       : numeric,
                opt [1] : integer,
                dim [1] : integer
        )

        return_val [dimsizes(z)] :  float or double

Arguments

   thv

   Virtual potential temperature (K): thv = theta*(1+0.61w) where w is the dimensionless mixing ratio. Potential temperature
   could also be used if the mixing ratio (kg/kg) is not available.
   u

   Zonal wind (m/s). Same dimensionality as thv.
   u

   Meridional wind (m/s). Same dimensionality as thv.
   z

   Geometric height (m). Same dimensionality as thv.

Return value

   A multi-dimensional array of the same size and shape as thv. The output will be double if t is of type double.

Description



 AMS Glossary:
 BruntV: http://glossary.ametsoc.org/wiki/Brunt-v%C3%A4is%C3%A4l%C3%A4_frequency
 Ri_Num: http://glossary.ametsoc.org/wiki/Gradient_richardson_number
         The latter uses Tv and not THETAv in denominator. This is an approximation
         used by boundary layer people where Tv ~ theta,

         http://en.wikipedia.org/wiki/Richardson_number

   Gradient Richardson Number: RI = buoyancy/shear_flow A dimensionless ratio, Ri, related to the buoyant production or
   consumption of turbulence divided by the shear production of turbulence. It is used to indicate dynamic stability and the
   formation of turbulence. The critical Richardson number, Ric, is about 0.25 (although reported values have ranged from
   roughly 0.2 to 1.0), and flow is dynamically unstable and turbulent when Ri < Ric. Such turbulence happens either when
   the wind shear is great enough to overpower any stabilizing buoyant forces (numerator is positive), or when there is
   static instability (numerator is negative). If the Richardson number is much less than unity, buoyancy is unimportant in
   the flow. If it is much greater than unity, buoyancy is dominant (in the sense that there is insufficient kinetic energy
   to homogenize the fluids). Large values of Ri indicate very stable conditions while low values *may* indicate dynamic
   stability (subcritical region). Brunt-Vaisala: The frequency at which a displaced air parcel will oscillate when
   displaced vertically within a statically stable environment.

See Also

   static_stability, pot_temp

Examples

   Example 1: Read data from a WRF file and calculate assorted quantities.
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

;----------------------------------------------------------
;                      MAIN
;----------------------------------------------------------
;                     WRF DATA
;----------------------------------------------------------

   a  = addfile("wrfout_d01_2013-05-17_12","r")  ;[Time|1]x[bottom_top|40]x[south_north|324]x[west_east|414]
                                                ;    0            1              2              3

   q  = a->QVAPOR                          ; mixing ratio (kg/kg)
   q  = where(q.lt.0, 0, q)               ; no negative mixing ratios
   printVarSummary(q)                    ; (Time, bottom_top, south_north, west_east)
   printMinMax(q,0)

   th = wrf_user_getvar(a,"theta",-1)     ; potential temperature (degK)

   th = th*(1.0 + 0.61*q)                  ; replace with virtual potential temperature

   z  = wrf_user_getvar(a,"z",-1)          ; model height
   printVarSummary(z)
   printMinMax(z,0)

   ua = wrf_user_getvar(a,"ua"   ,-1)      ; u at mass grid points
   printVarSummary(ua)
   printMinMax(ua,0)

   va = wrf_user_getvar(a,"va"   ,-1)      ; v at mass grid points
   printVarSummary(va)
   printMinMax(va,0)

 ;;Ri   = rigrad_bruntv_atm(th, ua, va, z, 0, 1 )
 ;;BV   = rigrad_bruntv_atm(th, ua, va, z, 1, 1 )
 ;;RiBV = rigrad_bruntv_atm(th, ua, va, z, 2, 1 )
   All  = rigrad_bruntv_atm(th, ua, va, z, 3, 1 )

   Ri   = All[0]     ; explicitly extract from list variable  for convenience
   BV   = All[1]
   BUOY = All[2]
   SHR2 = All[3]
   print("*****************************************")
   printVarSummary(Ri)
   printMinMax(Ri,0)
   print("-----------------------------------------")
   printVarSummary(BV)
   printMinMax(BV,0)
   print("-----------------------------------------")


   pr = wrf_user_getvar(a, "pressure", -1)   ; for printing purposes only
   ix = 20        ; arbitrary
   jy = 21
   dimTimes = getfilevardimsizes(a,"Times")
   ntim = dimTimes(0)
   print("sample:  pr="+   pr(ntim-1,:,jy,ix)  \
                       +"  th="+th(ntim-1,:,jy,ix)  \
                       +"  z="+ z(ntim-1,:,jy,ix)  \
                       +"  Ri="+Ri(ntim-1,:,jy,ix) \
                       +"  BUOY="+BUOY(ntim-1,:,jy,ix) \
                       +"  SHR2="+SHR2(ntim-1,:,jy,ix) )


   All input variables are 4D with dimensions:


    [Time | 1] x [bottom_top | 39] x [south_north | 324] x [west_east | 414]


   The (edited) output is:

Variable: Ri
Type: float
Total Size: 20925216 bytes
            5231304 values
Number of Dimensions: 4
Dimensions and sizes:   [Time | 1] x [bottom_top | 39] x [south_north | 324] x [west_east | 414]
Coordinates:
Number Of Attributes: 2
  long_name :   Gradient Richardson Number
  info :        http://glossary.ametsoc.org/wiki/Gradient_richardson_number
(0)     Gradient Richardson Number: min=-1.50836e+06   max=2.02878e+08
(0)     -----------------------------------------

Variable: BV
Type: float
Total Size: 20925216 bytes
            5231304 values
Number of Dimensions: 4
Dimensions and sizes:   [Time | 1] x [bottom_top | 39] x [south_north | 324] x [west_east | 414]
Coordinates:
Number Of Attributes: 3
  long_name :   Brunt‚Vaisala (buoyancy) frequency: atm
  units :       1/s
  info :        http://glossary.ametsoc.org/wiki/Brunt-v%C3%A4is%C3%A4l%C3%A4_frequency
(0)     Brunt‚Vaisala (buoyancy) frequency: atm: min=0   max=0.0748482




(0)     sample:  pr=1009.07  th=298.568  z=29.2222  Ri=-6.68898  BUOY=-2.94578e-05  SHR2=4.40393e-06
(1)     sample:  pr=1001.04  th=298.505  z=99.1009  Ri=-11.7403  BUOY=-1.79954e-05  SHR2=1.53279e-06
(2)     sample:  pr=990.345  th=298.478  z=192.852  Ri=-21.6728  BUOY=-6.56819e-06  SHR2=3.03061e-07
(3)     sample:  pr=976.758  th=298.462  z=312.979  Ri=-40.5252  BUOY=-3.60558e-06  SHR2=8.89713e-08
(4)     sample:  pr=959.971  th=298.449  z=462.985  Ri=0.398228  BUOY=3.52707e-06   SHR2=8.85689e-06
(5)     sample:  pr=939.585  th=298.498  z=647.381  Ri=0.839357  BUOY=8.86761e-05   SHR2=0.000105648
(6)     sample:  pr=915.313  th=299.553  z=871.986  Ri=1.36452   BUOY=0.000103775   SHR2=7.60522e-05
(7)     sample:  pr=886.679  th=300.07   z=1142.93  Ri=10.7162   BUOY=0.000152498   SHR2=1.42305e-05
(8)     sample:  pr=853.782  th=302.315  z=1463.44  Ri=5.25856   BUOY=0.000332136   SHR2=6.31609e-05
(9)     sample:  pr=817.171  th=307.162  z=1835.1   Ri=5.66496   BUOY=0.000304533   SHR2=5.37573e-05
(10)    sample:  pr=777.307  th=309.907  z=2258.79  Ri=30.1257   BUOY=0.000162975   SHR2=5.40983e-06
(11)    sample:  pr=734.615  th=311.793  z=2733.66  Ri=326.14    BUOY=0.000123034   SHR2=3.77242e-07
(12)    sample:  pr=689.618  th=313.823  z=3259.32  Ri=16.1766   BUOY=0.00010251    SHR2=6.33695e-06
(13)    sample:  pr=642.898  th=315.408  z=3834.95  Ri=7.4237    BUOY=9.18552e-05   SHR2=1.23732e-05
(14)    sample:  pr=596.312  th=317.321  z=4442.48  Ri=34.8061   BUOY=0.000133379   SHR2=3.83205e-06
(15)    sample:  pr=551.98   th=320.69   z=5057.86  Ri=20.6336   BUOY=0.000173283   SHR2=8.3981e-06
(16)    sample:  pr=510.399  th=324.308  z=5674.68  Ri=9.08171   BUOY=0.000132428   SHR2=1.45819e-05
(17)    sample:  pr=471.392  th=326.098  z=6292.03  Ri=4.43453   BUOY=7.0138e-05    SHR2=1.58163e-05
(18)    sample:  pr=434.801  th=327.186  z=6907.95  Ri=1.49337   BUOY=9.35486e-05   SHR2=6.26427e-05
(19)    sample:  pr=400.521  th=329.944  z=7523.28  Ri=4.89595   BUOY=0.000120182   SHR2=2.45471e-05
(20)    sample:  pr=368.429  th=332.168  z=8139.05  Ri=130.694   BUOY=0.000115528   SHR2=8.83954e-07
(21)    sample:  pr=338.401  th=334.769  z=8755.41  Ri=243.708   BUOY=0.000102435   SHR2=4.2032e-07
(22)    sample:  pr=310.327  th=336.482  z=9372.08  Ri=10.1918   BUOY=9.43362e-05   SHR2=9.25605e-06
(23)    sample:  pr=284.112  th=338.763  z=9988.7   Ri=2.4205    BUOY=0.000120959   SHR2=4.99728e-05
(24)    sample:  pr=259.659  th=341.643  z=10606.4  Ri=0.769499  BUOY=0.000128412   SHR2=0.000166878
(25)    sample:  pr=236.872  th=344.301  z=11225.7  Ri=0.575455  BUOY=0.000101774   SHR2=0.000176858
(26)    sample:  pr=215.656  th=346.075  z=11845.9  Ri=1.02892   BUOY=6.35681e-05   SHR2=6.17812e-05
(27)    sample:  pr=195.923  th=347.085  z=12465.8  Ri=5.00818   BUOY=7.16623e-05   SHR2=1.4309e-05
(28)    sample:  pr=177.589  th=349.223  z=13085.9  Ri=6.29492   BUOY=0.000107959   SHR2=1.71502e-05
(29)    sample:  pr=160.579  th=351.863  z=13707.9  Ri=1.21501   BUOY=0.000178242   SHR2=0.0001467
(30)    sample:  pr=144.813  th=357.216  z=14335    Ri=3.27184   BUOY=0.000283195   SHR2=8.65553e-05
(31)    sample:  pr=130.22   th=364.911  z=14971.9  Ri=4.61385   BUOY=0.000322755   SHR2=6.99536e-05
(32)    sample:  pr=116.733  th=372.674  z=15621.2  Ri=2.47913   BUOY=0.000402609   SHR2=0.000162399
(33)    sample:  pr=104.281  th=385.061  z=16288    Ri=4.04293   BUOY=0.000456014   SHR2=0.000112793
(34)    sample:  pr=92.8054  th=396.952  z=16976.2  Ri=8.26195   BUOY=0.000424389   SHR2=5.13667e-05
(35)    sample:  pr=82.2499  th=409.099  z=17686.4  Ri=9.69597   BUOY=0.000407501   SHR2=4.20278e-05
(36)    sample:  pr=72.5572  th=421.515  z=18420.1  Ri=18.797    BUOY=0.000497202   SHR2=2.64511e-05
(37)    sample:  pr=63.6743  th=441.157  z=19185.4  Ri=23.1549   BUOY=0.000630205   SHR2=2.7217e-05
(38)    sample:  pr=54.7147  th=469.014  z=20094.5  Ri=17.3186   BUOY=0.000640324   SHR2=3.69732e-05
(0)     *****************************************


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:19:48 +0800
# vim:set fdm=indent foldlevel=0:
