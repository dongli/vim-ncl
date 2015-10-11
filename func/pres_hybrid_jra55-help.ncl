THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/pres_hybrid_jra55.shtml
THE_TITLE:pres_hybrid_jra55

pres_hybrid_jra55

   Calculates the "full" hybrid levels for the 60-level Japanese ReAnalysis.

   [new.gif] Available in version 6.3.1 and later.

Prototype

        function pres_hybrid_jra55 (
                ps       : numeric,
                hyai [*] : numeric,
                hybi [*] : numeric
        )

        return_val  :  numeric

Arguments

   ps

   An array of at least 2 dimensions equal to surface pressure (Pa) data. The rightmost dimensions must be latitude and
   longitude.
   hyai

   A one-dimensional array containing the hybrid A interface coefficients.
   hybi

   A one-dimensional array containing the hybrid B interface coefficients.

Return value

   If ps is two-dimensional [e.g. (nlat,mlon)] or three-dimensional [e.g. (ntim,nlat,mlon)] then the return array will have
   an additional level dimension of size sixty (60,nlat,mlon) or (ntim,60,nlat,mlon). The returned type will be double if ps
   is double, float otherwise.

Description

   This function is being tested. Contact ncl-talk@ucar.edu if you wish to try it.

   Calculates full pressure levels using the formula found on page 17 of the "JRA-55 Product User's Handbook".

   Nominally, the formula is:

   p(k) = exp( (1/dp(k))*(p(k-0.5)*log(p(k-0.5)) - p(k+0.5)*log(p(k+0.5))-1.0))

   where the p(k-05) and p(k+0.5) represent the interface coefficients. The levels are expected to be ordered from bottom to
   top.

   The original reference for the above equation is:

    Simmons. A.J., and D. M. Burridge:
    An Energy and Angular-Momentum Conserving Vertical Finite-Difference Scheme
       and Hybrid Vertical Coordinates
    MON WEATHER REV , vol. 109, no. 4, 1981
    http://dx.doi.org/10.1175/1520-0493(1981)109<0758:AEAAMC>2.0.CO;2

Examples

   For JRA55, hyai and hybi are one-dimensional arrays of size 61 and ps is a two- or three-dimensional array of size
   (nlat,mlon) or (ntim,nlat,mlon) in units of pascals. The full pressure levels (pm) will be returned as a
   three-dimensional array of size (60,nlat,nlon) or a four-dimensional array of size (ntim,60,nlat,nlon).

   Example 1 The simplest case is illustrated.

  nlat  = 1                                 ; function expects (..,nlat,mlon) structure
  mlon  = 1
  ps    = new((/nlat,mlon/), "double")
  ps    = 100000.                           ; ps(1,1): surface pressure [Pa]

  dirhy = "./"
  filhy = "JRA55.hybrid_levels.nc"          ; contains 61 hybrid interface coef
  finhy = addfile(dirhy+filhy,"r")
  hyai  = finhy->hyai
  hybi  = finhy->hybi

  p     = pres_hybrid_jra55(ps,hyai,hybi)   ; [60] x [1] x [1] ; (klev,nlat,mlon)

          ; verification when ps=100000
  lev   = finhy->lev
  diff  = p(:,0,0)-lev
  print(lev+"    "+p(:,0,0)+"    "+diff)


   The edited output looks like

              lev                  p              diff
(0)     99849.96244364697    99849.96244364697    0
(1)     99549.96233052592    99549.96233052592    0
(2)     99149.89494018865    99149.89494018865    0
(3)     98549.7928287735     98549.7928287735     0
(4)     97699.57352197972    97699.57352197972    0
(5)     96599.37887679219    96599.37887679219    0
(6)     95299.14304700246    95299.14304700246    0
(7)     93698.55920278581    93698.55920278979    3.987224772572517e-09
(8)     91798.18441228721    91798.18441228606    -1.149601303040981e-09
(9)     89697.75169188292    89697.75169188037    -2.546585164964199e-09
(10)    87347.01856643189    87347.01856643189    0
(11)    84696.14302236082    84696.14302236518    4.365574568510056e-09
(12)    81795.41531387174    81795.41531386811    -3.623426891863346e-09
(13)    78694.5780828073     78694.5780828073     0
(14)    75443.98546020423    75443.98546020543    1.193257048726082e-09
(15)    72042.91489346673    72042.91489346455    -2.182787284255028e-09
(16)    68441.66534734554    68441.66534734869    3.157765604555607e-09
(17)    64741.1889174707     64741.18891747024    -4.583853296935558e-10
(18)    60990.13453779992    60990.13453779992    0
(19)    57189.47883614307    57189.47883614226    -8.076312951743603e-10
(20)    53388.72974167685    53388.72974167523    -1.615262590348721e-09
(21)    49587.86576445695    49587.86576445792    9.749783203005791e-10
(22)    45837.55467777611    45837.55467777644    3.274180926382542e-10
(23)    42187.19874312158    42187.19874312113    -4.511093720793724e-10
(24)    38636.78800522001    38636.78800522021    2.037268131971359e-10
(25)    35186.30936535118    35186.30936535118    0
(26)    31886.61757076395    31886.61757076395    0
(27)    28736.06368117695    28736.06368117695    0
(28)    25736.38222305299    25736.38222305299    0
(29)    22885.72350887325    22885.72350887309    -1.637090463191271e-10
(30)    20186.04356927362    20186.04356927405    4.292814992368221e-10
(31)    17686.42714647552    17686.42714647502    -5.020410753786564e-10
(32)    15386.89025254726    15386.8902525474     1.364242052659392e-10
(33)    13287.45328330309    13287.45328330316    7.09405867382884e-11
(34)    11388.14185796683    11388.14185796685    2.000888343900442e-11
(35)    9688.987180267748    9688.987180267834    8.549250196665525e-11
(36)    8164.265567858072    8164.265567858072    0
(37)    6763.767298472668    6763.767298472656    -1.182343112304807e-11
(38)    5515.002875033884    5515.002875033893    9.094947017729282e-12
(39)    4466.576216266381    4466.576216266381    0
(40)    3608.149325172584    3608.14932517259     6.366462912410498e-12
(41)    2914.501376923828    2914.501376923823    -5.002220859751105e-12
(42)    2352.981404124263    2352.981404124263    0
(43)    1898.89882407333     1898.89882407333     0
(44)    1532.036534874198    1532.036534874198    0
(45)    1235.129618271835    1235.129618271835    0
(46)    997.1208628290149    997.1208628290149    0
(47)    804.9498872016828    804.9498872016828    0
(48)    649.2593496916936    649.2593496916936    0
(49)    524.0019775689651    524.0019775689651    0
(50)    422.1641249658988    422.1641249658988    0
(51)    338.288125071407     338.288125071407     0
(52)    268.363593649281     268.363593649281     0
(53)    208.8961054950331    208.8961054950331    0
(54)    158.4429547310325    158.4429547310325    0
(55)    115.9526640886324    115.9526640886324    0
(56)    80.46871791830324    80.46871791830324    0
(57)    51.45078427193928    51.45078427193928    0
(58)    28.97808727180794    28.97808727180794    0
(59)    10                   10                   0


   Example 2 Read from JRA55 GRIB file and interpolate to user specified isobaric levels. Also, create a netCDF file.

;*****************************************************************
; Two local utility routines: created for convenience
;*****************************************************************

undef ("changeDimNames")
procedure changeDimNames(v3:numeric, v4:numeric)
; convenience: change fron NCL generated names to more 'common' (friendly) names
begin
  v3!0 = "time"
  v3!1 = "lat"
  v3!2 = "lon"

  v4!0 = "time"
  v4!1 = "lev"
  v4!2 = "lat"
  v4!3 = "lon"
end
;--
undef ("deleteSelectedAtts")
procedure deleteSelectedAtts(v4:numeric)
; esthetics: these pertain more to the original GRIB file; not to pressure data
begin
  delete([/ v4@sub_center, v4@level_indicator, v4@parameter_table_version \
          , v4@parameter_table_version, v4@parameter_number, v4@gds_grid_type /])
end

; ---------------------------> MAIN DRIVER <----------------------

;*****************************************************************
; User specified levels
;*****************************************************************

   plvl   = (/10.,20.,30.,50.,70.,100.,150.,200.,250.,300.,400.,500.,700.,850.,925.,1000./)*100
   plvl   = plvl(::-1)    ; reorder ... make same vertical order as JRA55
   plvl!0 = "plvl"
   plvl@units = "Pa"
   plvl@long_name = "pressure level"
   plvl&plvl  = plvl
   printVarSummary(plvl)
   nplvl  = dimsizes(plvl)

   netCDF = True
   vari   = "TMP_GDS4_HYBL"
   varo   = "TMP"

   linlog = -1               ; type vertical interpolation (see: int2p_n)

   dirx   = "./"
   filx   = systemfunc("cd "+dirx+" ; ls fcst_mdl*")
   nfilx  = dimsizes(filx)
   print(filx)

   dirps  = "./"
   filps  = systemfunc("cd "+dirps+" ; ls jra55PS6hr*")
   nfilps = dimsizes(filx)
   print(filps)

;*****************************************************************
; end user input
;*****************************************************************
; input error checks
;*****************************************************************

   if (nfilx.ne.nfilps) then
       print("number of files do not match: nfilx="+nfilx+"  nfilps="+nfilps)
       exit
   end if

;*****************************************************************
; Read hybrid information; external file containg hyai and hybi coefficients
;*****************************************************************

   dirhy = "./"                        ; read file with interface hybrid info
   filhy = "JRA55.hybrid_levels.nc"
   finhy = addfile(dirhy+filhy,"r")
   hyai  = finhy->hyai
   hybi  = finhy->hybi
   P0    = finhy->P0

   ilev  = finhy->ilev
   lev   = finhy->lev

;*****************************************************************
; loop over all GRIB files
;*****************************************************************
   fext  = ".grb"                             ; all the input are GRIB

  do nf=0,nfilx-1
     loopTime = get_cpu_time()
     print("-------------------------------------------------")
     print("nf="+nf+"  dirx+filx(nf)+fext="+dirx+filx(nf)+fext)

     finx  = addfile(dirx+filx(nf)+fext,"r")
   ;;x := finx->$vari$(0:4,:,:,:)         ; x( 5, lv_HYBL1, g4_lat_2, g4_lon_3 )   ; testing
     x := finx->$vari$                    ; x( initial_time0_hours, lv_HYBL1, g4_lat_2, g4_lon_3 )
     printVarSummary(x)

     finps = addfile(dirps+filps(nf)+fext,"r")
   ;;ps := finps->PRES_GDS4_SFC(0:4,:,:)  ;  ( 5 , g4_lat_2, g4_lon_3 )
     ps := finps->PRES_GDS4_SFC           ; x( initial_time0_hours, g4_lat_2, g4_lon_3 )
     printVarSummary(ps)

;*****************************************************************
; error checking
;*****************************************************************

     dimx  = dimsizes(x)
     rankx = dimsizes(dimx)
     if (rankx.ne.4)then
         print("FATAL: rank of variable must be 4: rankx="+rankx)
         exit
     end if

     dimps = dimsizes(ps)
     rankps= dimsizes(dimps)
     if (rankps.ne.3)then
         print("FATAL: rank of PS must be 3: rankps="+rankps)
         exit
     end if

     ntimx = dimx(0)
     ntimps= dimps(0)
     if (ntimx.ne.ntimps) then
         print("FATAL: number of time steps do not match: ntimx="+ntimx+"  ntimps="+ntimps)
         exit
     end if
     if (.not.all(x&initial_time0_hours .eq. ps&initial_time0_hours)) then
         print("FATAL: time mismatch between variable and sfc pressure")
         exit
     end if

;*****************************************************************
; Miscellaneous
;*****************************************************************
     changeDimNames(ps, x)   ; convenience ... user friendly names

     xMin = min(x)   ; source min
     xMax = max(x)   ;        max

     ntim = dimx(0)
     klev = dimx(1)
     nlat = dimx(2)
     mlon = dimx(3)

     klevi= klev+1   ; number of interface levels

;*****************************************************************
; derive interface pressure levels at each grid point
;*****************************************************************

     p    = pres_hybrid_jra55(ps,hyai,hybi)   ; (ntim,60,nlat,mlon)

;*****************************************************************
; Interpolate from hybrid pressure levels to isobaric levels ('plvl' )
;*****************************************************************

     x_p := int2p_n_Wrap(p,x,plvl,linlog,1)   ; (ntim,nplvl,nlat,mlon)
     deleteSelectedAtts(x_p)
     x_p@info = "interpolated to pressure levels via NCL script"
     x_p = where(x_p.lt.xMin .or. x_p.gt.xMax, x_p@_FillValue, x_p)  ; extrapolated values

     delete(p)
;*****************************************************************
; Write netCDF
;*****************************************************************

     if (netCDF) then
         diro  = "./"
         filo  = "jra55_2_so."+filx(nf)+".nc"          ; arbitrary
         ptho  = diro+filo
         system("/bin/rm -f "+ ptho)
         ncdf = addfile(ptho,"c")
         ncdf->$varo$  = x_p
     end if

     print("LOOP time: " + (get_cpu_time() - loopTime))
  end do


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:10:00 +0800
# vim:set fdm=indent foldlevel=0:
