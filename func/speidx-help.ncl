THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/speidx.shtml
THE_TITLE:speidx

speidx

   Calculates the standardized precipitation evapotranspiration index (SPEI).

   [new.gif] Available in version 6.3.1 and later.

Prototype

        function speidx (
                p        : numeric,  ; float, double
                t        : numeric,
                lat      : numeric,
                lrun [1] : integer,
                optspei  : logical,
                dims [*] : integer
        )

        return_val  :  float or double

Arguments

   p

   Monthly precipitation of type 'float' or 'double' and any dimensionality. The size of the specified dims must be
   divisible by 12. Since a distribution is being fit, there should be a 'reasonably' large sample size. At least 30 years
   of monthly values (360 months) is recommended.
   t

   Monthly temperature with same type, shape and size as p. Since a distribution is being fit, there should be a
   'reasonably' large sample size. At least 30 years of monthly values (360 months) is recommended. Monthly values of 'water
   balance' values. See Examples.
   lat

   Latitudes.
   lrun

   A scalar that specifies the number of months over which the standardized precipitation evapotranspiration index is to be
   calculated. Common values are 3, 6, 12, 24, and 36.
   optspei

   Options parameter. Currently not used. Set to False.
   dims

   The dimension(s) of x to be used to estimate the SPEI. Usually, this is the record ('time') dimension.

Return value

   The returned SPEI will be the same shape, size and type as p.

Description

   The Standardized Precipitation Evapotranspiration Index (SPEI) is a probability based drought index that gives a
   representation of abnormal wetness and dryness. A major advantage of the SPEI over other multiscalar drought indices such
   as the Standardized Precipitation Index (SPI) is that it considers the role of temperature through its influence on
   potential evapotranspiration. Thus, the SPEI is adequate for assessing the impact of global warming on droughts. It
   requires less information than the Palmer Drought Severity Index.

Vicente-Serrano, Sergio M., Santiago Begueria, Juan I. Lopez-Moreno, 2010:
A Multiscalar Drought Index Sensitive to Global Warming:
The Standardized Precipitation Evapotranspiration Index
J. Climate, 23, 1696-1718.
doi: http://dx.doi.org/10.1175/2009JCLI2909.1

Begueria, Santiago,  Sergio M. Vicente-Serrano, Fergus Reig and Borja Latorre, 2013:
Standardized precipitation evapotranspiration index (SPEI) revisited:
parameter fitting, evapotranspiration models, tools, datasets and drought monitoring
International Journal of Climatology
doi: http://dx.doi.org/10.1002/joc.3887

McEvoy, D.J., and J. L. Huntington and J. T. Abatzoglou
A Comparison of the Standardized Precipitation Evapotranspiration Index
Using Thronthwaite and Penman-Monteith Parameterizations for Potential Evapotranspiration
https://ams.confex.com/ams/93Annual/webprogram/Paper222257.html

   More information can be obtained at:
     * ClimateDataGuide
     * SPEI home

See Also

   dim_spi_n, dim_gamfit_n, thornthwaite, dim_acumrun_n

Examples

   Example 1

   Read ASCII files containing 117 years of monthly precipitation (inches) and temperature (Fahrenheit) at Boulder, Colorado
   located at 40N latitude (data source: http://www.ersl.noaa.gov/psd/boulder/). Compute 12-month estimates of the SPEI.
   filp   = "Boulder.precip.1894-2013.txt"
   filt   = "Boulder.precip.1894-2013.txt"

   ncol   = 14  ; due to the structure of the data, it is better to read as 2D
   nrow   = numAsciiRow(dirp+filp)      ; contributed.ncl
   prc2   = asciiread(dirp+filp,(/nrow,ncol/), "float")
   temp2   = asciiread(dirt+filt,(/nrow,ncol/), "float")

   prc           = ndtooned(prc2(:,1:ncol-2))              ; make one dimensional
   prc@units     = "inches"
   prc@long_name = "Boulder Precipitation"

   printVarSummary(prc)
   print("min="+min(prc)+"  max="+max(prc))

   temp           = ndtooned(temp2(:,1:ncol-2))              ; make one dimensional
   temp@units     = "degF"
   temp@long_name = "Boulder Temperature"

   printVarSummary(tmp)
   print("min="+min(temp)+"  max="+max(temp))

   nprc   = dimsizes(prc)              ; check size
   if ((nprc%12).ne.0) then
        print("prc size must be divisible by 12")         ; full 12-month years only
        exit
   end if

   temp      = (temp-32)*0.555                                  ; units needed for thornthwaite
   temp@units= "degC"

   prc       = p*25.4                                        ; thornthwaite return PET as mm/month
   prc@units = "mm"

   lat       = 40.0                                          ; Boulder is at 40N latitude
   lrun      = 12

   pet_tw    = thornthwaite(t, 40.0, 0)
   pet_tw    = thornthwaite(t, 40.0, 0)                      ; PET via Thornthwaite method
   bal       = prc-pet_tw
   balcum = dim_acumrun_n(bal,lrun,0,0); accumulated sum

   spei   = speidx(prc, temp, lat, lrun, False, 0)

          ; create a yyyymm array for printing purposes

   year   = toint(prc2(:,0))
   nyear  = dimsizes(year)
   yrStrt = year(0)
   yrLast = year(nyear-1)
   yyyymm = yyyymm_time(yrStrt, yrLast, "integer")   ; contributed.ncl

   print(yyyymm+sprintf("%8.2f", prc) \
                                  +sprintf("%8.2f", tmp) \
                                  +sprintf("%8.2f", spei))

   The output has _FillValue at the beginning (nrun-1) temporal locations.

        yyyymm       12

(0)     189401    -999.00
(1)     189402    -999.00
(2)     189403    -999.00
(3)     189404    -999.00
(4)     189405    -999.00
(5)     189406    -999.00
(6)     189407    -999.00
(7)     189408    -999.00
(8)     189409    -999.00
(9)     189410    -999.00
(10)    189411    -999.00
(11)    189412      -0.39
(12)    189501      -0.34
(13)    189502      -0.39
(14)    189503      -0.24
(15)    189504      -0.33
(16)    189505      -0.37
(17)    189506       0.30
[SNIP]
(1391)  200912       0.80
(1392)  201001       0.72
(1393)  201002       0.96
(1394)  201003       1.21
(1395)  201004       0.75
(1396)  201005       0.67
(1397)  201006       0.83
(1398)  201007       1.04
(1399)  201008       1.23
(1400)  201009       1.20
(1401)  201010       0.67
(1402)  201011       0.59
(1403)  201012       0.39

   Example 2

   Same as Example 1 but compute SPEI for 3, 6, 12, 24, 36 and 48 lengths.
   f      = addfile("Boulder.precip.1894-2010.nc", "r")
   prc    = f->PRECIP                                     ; PRECIP(time)
   nprc   = dimsizes(prc)              ; # monthly precipitation values

   len    = (/3, 6, 12, 24, 36, 48 /)
   klen   =  dimsizes(len)
   spei   =  new( (/klen, nprc/) , typeof(prc), prc@_FillValue)

   do k=0,klen-1
      pet_tw = thornthwaite(t, 40.0, 0) ; PET via Thornthwaite method
      bal    = p-pet_tw
      balcum = dim_acumrun_n(bal,lrun,0,0); accumulated sum

      spei(k,:) = speidx(prc, temp, lat, len(k), False, 0)   ; spei(nlen,nprc)
   end do

   print(yyyymm+sprintf("%8.2f", prc)   \
               +sprintf("%8.2f", spei(0,:))+sprintf("%8.2f", spei(1,:)) \
               +sprintf("%8.2f", spei(2,:))+sprintf("%8.2f", spei(3,:)) \
               +sprintf("%8.2f", spei(4,:))+sprintf("%8.2f", spei(5,:)) )

   The output has _FillValue at the beginning (nrun-1) temporal locations.

        yyyymm    prc      3       6      12      24      36      48

(0)     189401    0.16 -999.00 -999.00 -999.00 -999.00 -999.00 -999.00
(1)     189402    0.82 -999.00 -999.00 -999.00 -999.00 -999.00 -999.00
(2)     189403    1.40   -0.45 -999.00 -999.00 -999.00 -999.00 -999.00
(3)     189404    2.30   -0.15 -999.00 -999.00 -999.00 -999.00 -999.00
(4)     189405    4.50    0.41 -999.00 -999.00 -999.00 -999.00 -999.00
(5)     189406    0.80    0.13   -0.14 -999.00 -999.00 -999.00 -999.00
(6)     189407    3.08    0.71    0.38 -999.00 -999.00 -999.00 -999.00
[SNIP]
(1398)  201007    2.31    0.71    1.39    1.04    1.42    0.98    0.92
(1399)  201008    1.07    0.67    1.03    1.23    1.16    0.88    0.88
(1400)  201009    0.25   -0.54    0.30    1.20    0.95    0.68    0.78
(1401)  201010    0.95   -1.17   -0.13    0.67    0.89    0.60    0.46
(1402)  201011    0.61   -1.29   -0.14    0.59    0.94    0.60    0.44
(1403)  201012    0.48   -0.76   -0.87    0.39    0.81    0.40    0.14


   Example 3

   An example of the SPEI derived from Global Precipitation Climatology Project (GPCP).

   Example 5

   Consider t(time,lat,lon),prc(time,lat,lon) where the sizes are (384,72,144); calculate multiple SPEI.
   f      = addfile("V22_GPCP.1979-2010.nc","r")
   prc    = f->PREC                    ; PREC(time,lat,lon)
   temp   = f->TEMP
   printVarSummary(prc)

   dimp   = dimsizes(prc)              ; # monthly precipitation values
   ntim   = dimp(0)
   nlat   = dimp(1)
   mlon   = dimp(2)

   len    = (/3, 6, 12, 24, 36, 48 /)
   klen   =  dimsizes(len)
   spei    =  new((/klen,ntim,nlat,mlon/) ,float,prc@_FillValue)

   do k=0,klen-1
      spei(k,:,:,:) = speidx(prc, temp, lat, len(k), False, 0)
   end do

   copy_VarCoords(prc,spei(0,:,:,:))
   spei@long_name = "SPEI"
   spei!0         = "len"
   spei&len       =  len
   printVarSummary(spei)    ; [len | 6] x [time | 384] x [lat | 72] x [lon | 144]

; print values at one location

   LAT = 45.5
   LON = 292.5

   yyyymm = cd_calendar(f->time, -1)  ; time@units = "days since ..."

   print(yyyymm+sprintf("%8.2f", prc)   \
               +sprintf("%8.2f", spei(0,:,{LAT},{LON}))   \
               +sprintf("%8.2f", spei(1,:,{LAT},{LON}))   \
               +sprintf("%8.2f", spei(2,:,{LAT},{LON}))   \
               +sprintf("%8.2f", spei(3,:,{LAT},{LON}))   \
               +sprintf("%8.2f", spei(4,:,{LAT},{LON}))   \
               +sprintf("%8.2f", spei(5,:,{LAT},{LON}))   )



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:11:39 +0800
# vim:set fdm=indent foldlevel=0:
