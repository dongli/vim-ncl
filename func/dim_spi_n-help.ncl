THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/dim_spi_n.shtml
THE_TITLE:dim_spi_n

dim_spi_n

   Calculates the standardized precipitation index (SPI) by fitting a gamma or a Pearson Type III distribution to monthly
   precipitation values.

   [new.gif] Available in version 6.1.0 and later.

Prototype

        function dim_spi_n (
                x        : numeric,  ; float, double
                nrun [1] : integer,
                opt      : logical,
                dims [*] : integer
        )

        return_val  :  float or double

Arguments

   x

   Monthly precipitation of type 'float' or 'double' and any dimensionality. The size of the specified dims must be
   divisible by 12. Since a distribution is being fit, there should be a 'reasonably' large sample size. At least 30 years
   of monthly data (360=12*30) is recommended.
   nrun

   A scalar that specifies the number of months over which the standardized precipitation index is to be calculated. Common
   values are 3, 6, 12, 24,36.
   opt

   Options parameter.

   As of NCL version 6.3.0, if opt=True, you can set opt@spi_type = 3 to have this function calculate the standardized
   precipitation index (SPI) using the Pearson type III distribution.
   dims

   The dimension(s) of x to be used to estimate the SPI. Usually, this is the record ('time') dimension.

Return value

   The returned SPI will be the same shape, size and type as x.

Description

   This function calculates the Standardized Precipitation Index (SPI), a probability index that gives a better
   representation of abnormal wetness and dryness than the Palmer Severe Drought Index (PSDI).

   The World Meteorological Organization (WMO) recommends, that all national meteorological and hydrological services should
   use the SPI for monitoring of dry spells. Some advantages of the SPI:
     * It requires only monthly precipitation.
     * It can be compared across regions with markedly different climates.
     * The standardization of the SPI allows the index to determine the rarity of a current drought.
     * It can be created for differing periods of 1-to-36 months.

   A shortcoming of the SPI, as noted by Trenberth et al (2014):

    "the SPI are based on precipitation alone and provide a measure only for water supply.
     They are very useful as a measure of precipitation deficits or meteorological drought
     but are limited because they do not deal with the ET [evapotranspiration] side of the issue."

   As of NCL version 6.3.0, this function will calculate the SPI using two possible methods:

    1. Applying a 2-parameter gamma distribution fit (default).
    2. Applying a Pearson type III distribution (opt@spi_type = 3).

   The default implementation of dim_spi_n uses a 2-parameter gamma distribution fit (dim_gamfit_n) where the shape and
   scale parameters are maximum likelihood estimates as described in

        A Note on the Gamma Distribution
        Thom (1958): Monthly Weather Review, pp 117-122.
                     specifically: eqn 22 for gamma; just above eqn 21


   However, there is some variation in the methods used to derive the SPI. Guttman (1998, 1999) recommends that the Pearson
   III distribution be used, which is available in NCL V6.3.0 by setting opt@spi_type=3. This option uses code made
   available at the National Climate Data Center (NCDC). See spi.f

   Generally, the Pearson III distribution is likely to give essentially equivalent results to the 2-parameter gamma
   distribution fit. In some instances, where monthly and seasonal precipitation of zero is common, it will give slightly
   better results.

   Generally, monthly precipitation is not normally distributed so a transformation is performed such that the derived SPI
   values follow a normal distribution. The SPI is the number of standard deviations that the observed value would deviate
   from the long-term mean, for a normally distributed random variable. One interpretation of the resultant values is:

         [+,-]2.00 and above/below: exceptionally [wet,dry]
         [+,-]1.60 to 1.99: extremely [wet,dry]
         [+,-]1.30 to 1.59: severely [wet,dry]
         [+,-]0.80 to 1.29: moderately [wet,dry]
         [+,-]0.51 to 0.79: abnormally [wet,dry]
         [+,-]0.50:  near normal


   An explanation of the SPI at different lengths and sample spatial pattterns over the USA at different run times are
   available.

   More information can be obtained at the ClimateDataGuide.

References:

      McKee, T.B., N.J. Doesken, and J. Kleist, 1993.
      The relationship of drought frequency and duration ot time scales.
      Eighth Conference on Applied Climatology, American Meteorological Society
      Jan 17-23, 1993, Anaheim CA, pp. 179-186.

      McKee, T.B., N.J. Doesken, and J. Kleist, 1995.
      Drought monitoring with multiple time scales.
      Ninth Conference on Applied Climatology, American Meteorological Society
      Jan 15-20, 1995, Dallas TX, pp. 233-236.

      Guttman, N.B., 1998.
      Comparing the Palmer Drought Index and the Standardized Precipitation Index.
      Journal of the American Water Resources Association, 34(1), 113-121.

      Guttman, N.B., 1999. Accepting the Standardized Precipitation Index: A calculation algorithm.
      Journal of the American Water Resources Association, 35(2), 311-322.

      Trenberth et al (2014)
      Global warming and changes in drought
      Nature Climate Change 4, 17-22;   doi:10.1038/nclimate2067


See Also

   dim_gamfit_n

Examples

   Several applications of the SPI with figures are here.

   Example 1

   Read an ASCII file containing 117 years of monthly precipitation at Boulder, Colorado (source:
   http://www.esrl.noaa.gov/psd/boulder/). Compute 12-month estimates of the SPI.
   fili   = "Boulder.precip.1894-2010.txt"

   ncol   = 14
   nrow   = numAsciiRow(diri+fili)      ; contributed.ncl
   data   = asciiread(diri+fili,(/nrow,ncol/), "float")

   prc           = ndtooned(data(:,1:ncol-2))   ; make one dimensional
   prc@units     = "inches"
   prc@long_name = "Boulder Precipitation"

   printVarSummary(prc)
   print("min="+min(prc)+"  max="+max(prc))

   nprc   = dimsizes(prc)              ; check size
   if ((nprc%12).ne.0) then
        print("prc size must be divisible by 12")         ; full 12-month years only
        exit
   end if

   spi    = dim_spi_n(prc, 12, False, 0)

          ; create a yyyymm array for printing purposes

   year   = toint(data(:,0))
   nyear  = dimsizes(year)
   yrStrt = year(0)
   yrLast = year(nyear-1)
   yyyymm = yyyymm_time(yrStrt, yrLast, "integer")   ; contributed.ncl

   print(yyyymm+sprintf("%8.2f", prc)+sprintf("%8.2f", spi))

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

   Same as Example 1 but compute SPI for 3, 6, 12, 24, 36 and 48 lengths.
   f      = addfile("Boulder.precip.1894-2010.nc", "r")
   prc    = f->PRECIP                                     ; PRECIP(time)
   nprc   = dimsizes(prc)              ; # monthly precipitation values

   len    = (/3, 6, 12, 24, 36, 48 /)
   klen   =  dimsizes(len)
   spi    =  new( (/klen, nprc/) , typeof(prc), prc@_FillValue)

   do k=0,klen-1
      spi(k,:) = dim_spi_n(prc, len(k), False, 0)   ; spi(nlen,nprc)
   end do

   print(yyyymm+sprintf("%8.2f", prc)   \
               +sprintf("%8.2f", spi(0,:))+sprintf("%8.2f", spi(1,:)) \
               +sprintf("%8.2f", spi(2,:))+sprintf("%8.2f", spi(3,:)) \
               +sprintf("%8.2f", spi(4,:))+sprintf("%8.2f", spi(5,:)) )

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

   Consider prc(time,lat,lon) and PRC(lat,lon,time), calculate a 12-month SPI. Note that the dims changes depending upon
   order of the variable dimensions.
   prc    = f->prc                   ; prc(time,lat,lon)     => (0,1,2)
   run    = 12
   spi    = dim_spi_n(prc, run, False, 0) => (ntim,nlat,mlon)

   PRC    = f->PRC                   ; PRC(lat,lon,time)     => (0,1,2)
   SPI    = dim_spi_n(PRC, run, False, 2) => (nlat,mlon,ntim)

; optional ... add meta data

   spi@long_name = "spi: run="+run
   copy_VarCoords(prc, spi)          ; contributed.ncl

   SPI@long_name = "SPI: run="+run
   copy_VarCoords(PRC, SPI)          ; contributed.ncl


   Example 4

   An example of the SPI derived from Global Precipitation Climatology Project (GPCP) data spanning 1979-2010 is here.

   Example 5

   Consider prc(time,lat,lon) where the sizes are (384,72,144); calculate multiple SPI.
   f      = addfile("V22_GPCP.1979-2010.nc","r")
   prc    = f->PREC                    ; PREC(time,lat,lon)
   printVarSummary(prc)

   dimp   = dimsizes(prc)              ; # monthly precipitation values
   ntim   = dimp(0)
   nlat   = dimp(1)
   mlon   = dimp(2)

   len    = (/3, 6, 12, 24, 36, 48 /)
   klen   =  dimsizes(len)
   spi    =  new((/klen,ntim,nlat,mlon/) ,float,prc@_FillValue)

   do k=0,klen-1
      spi(k,:,:,:) = dim_spi_n(prc, len(k), False, 0)
   end do

   copy_VarCoords(prc,spi(0,:,:,:))
   spi@long_name = "SPI"
   spi!0         = "len"
   spi&len       =  len
   printVarSummary(spi)    ; [len | 6] x [time | 384] x [lat | 72] x [lon | 144]

; print values at one location

   LAT = 45.5
   LON = 292.5

   yyyymm = cd_calendar(f->time, -1)  ; time@units = "days since ..."

   print(yyyymm+sprintf("%8.2f", prc)   \
               +sprintf("%8.2f", spi(0,:,{LAT},{LON}))   \
               +sprintf("%8.2f", spi(1,:,{LAT},{LON}))   \
               +sprintf("%8.2f", spi(2,:,{LAT},{LON}))   \
               +sprintf("%8.2f", spi(3,:,{LAT},{LON}))   \
               +sprintf("%8.2f", spi(4,:,{LAT},{LON}))   \
               +sprintf("%8.2f", spi(5,:,{LAT},{LON}))   )


   Example 6

   Read an ascii file containing 117 years of monthly precipitation at Boulder, Colorado (source:
   http://www.esrl.noaa.gov/psd/boulder/). Compute 12-month estimates of the SPI.
   fili   = "Boulder.precip.1894-2010.txt"

   ncol   = 14
   nrow   = numAsciiRow(diri+fili)      ; contributed.ncl
   data   = asciiread(diri+fili,(/nrow,ncol/), "float")

   prc           = ndtooned(data(:,1:ncol-2))   ; make one dimensional
   prc@units     = "inches"
   prc@long_name = "Boulder Precipitation"

   printVarSummary(prc)
   print("min="+min(prc)+"  max="+max(prc))

   nprc   = dimsizes(prc)              ; check size
   if ((nprc%12).ne.0) then
        print("prc size must be divisible by 12")         ; full 12-month years only
        exit
   end if

   opt = True opt@spi_type = 3 ; calculate using Pearson III
   distribution

   spi    = dim_spi_n(prc, 12, opt, 0)

          ; create a yyyymm array for printing purposes

   year   = toint(data(:,0))
   nyear  = dimsizes(year)
   yrStrt = year(0)
   yrLast = year(nyear-1)
   yyyymm = yyyymm_time(yrStrt, yrLast, "integer")   ; contributed.ncl

   print(yyyymm+sprintf("%8.2f", prc)+sprintf("%8.2f", spi))

   The output has _FillValue at the beginning (nrun-1) temporal locations.

        yyyymm       12

(0)     189401   -999
(1)     189402   -999
(2)     189403   -999
(3)     189404   -999
(4)     189405   -999
(5)     189406   -999
(6)     189407   -999
(7)     189408   -999
(8)     189409   -999
(9)     189410   -999
(10)    189411   -999
(11)    189412   -0.35
(12)    189501   -0.30
(13)    189502   -0.37
(14)    189503   -0.19
(15)    189504   -0.36
(16)    189505   -0.45
(17)    189506    0.24
[SNIP]
(1391)  200912   0.80
(1392)  201001   0.72
(1393)  201002   0.94
(1394)  201003   1.19
(1395)  201004   0.72
(1396)  201005   0.63
(1397)  201006   0.81
(1398)  201007   1.05
(1399)  201008   1.25
(1400)  201009   1.20
(1401)  201010   0.68
(1402)  201011   0.60
(1403)  201012   0.41


   Example 7

   Same as Example 7 but compute SPI for 3, 6, 12, 24, 36 and 48 lengths.
   f      = addfile("Boulder.precip.1894-2010.nc", "r")
   prc    = f->PRECIP                                     ; PRECIP(time)
   nprc   = dimsizes(prc)              ; # monthly precipitation values

   len    = (/3, 6, 12, 24, 36, 48 /)
   klen   =  dimsizes(len)
   spi    =  new( (/klen, nprc/) , typeof(prc), prc@_FillValue)

   opt    = True
   opt@spi_type = 3       ; calculate using Pearson III distribution

   do k=0,klen-1
      spi(k,:) = dim_spi_n(prc, len(k), opt, 0)   ; spi(nlen,nprc)
   end do

   print(yyyymm+sprintf("%8.2f", prc)   \
               +sprintf("%8.2f", spi(0,:))+sprintf("%8.2f", spi(1,:)) \
               +sprintf("%8.2f", spi(2,:))+sprintf("%8.2f", spi(3,:)) \
               +sprintf("%8.2f", spi(4,:))+sprintf("%8.2f", spi(5,:)) )

   The output has _FillValue at the beginning (nrun-1) temporal locations.

        yyyymm    prc      3       6      12      24      36      48
(0)     189401    -999.00    -999.00    -999.00    -999.00    -999.00    -999.00
(1)     189402    -999.00    -999.00    -999.00    -999.00    -999.00    -999.00
(2)     189403      -0.53    -999.00    -999.00    -999.00    -999.00    -999.00
(3)     189404      -0.20    -999.00    -999.00    -999.00    -999.00    -999.00
(4)     189405       0.42    -999.00    -999.00    -999.00    -999.00    -999.00
(5)     189406       0.14      -0.12    -999.00    -999.00    -999.00    -999.00
(6)     189407       0.72       0.38    -999.00    -999.00    -999.00    -999.00
(7)     189408      -0.19       0.13    -999.00    -999.00    -999.00    -999.00
(8)     189409       0.59       0.39    -999.00    -999.00    -999.00    -999.00
(9)     189410      -0.67       0.07    -999.00    -999.00    -999.00    -999.00
(10)    189411      -0.77      -0.62    -999.00    -999.00    -999.00    -999.00
(11)    189412      -1.76      -0.31      -0.35    -999.00    -999.00    -999.00
(12)    189501      -1.02      -1.11      -0.30    -999.00    -999.00    -999.00
(13)    189502      -0.52      -0.95      -0.37    -999.00    -999.00    -999.00
[SNIP]
(1391)  200912       1.38      -0.07       0.80       0.21      -0.13      -0.10
(1392)  201001       0.29      -0.09       0.72       0.17      -0.29      -0.12
(1393)  201002       0.98       0.73       0.94       0.30      -0.22      -0.04
(1394)  201003       1.41       1.66       1.19       0.62       0.01       0.14
(1395)  201004       1.41       1.28       0.72       0.93       0.26       0.47
(1396)  201005       0.88       1.10       0.63       0.77       0.38       0.69
(1397)  201006       0.80       1.21       0.81       1.05       0.86       0.92
(1398)  201007       0.72       1.35       1.05       1.34       1.04       0.87
(1399)  201008       0.66       1.01       1.25       1.11       0.86       0.84
(1400)  201009      -0.53       0.31       1.20       0.91       0.66       0.77
(1401)  201010      -1.14      -0.15       0.68       0.87       0.61       0.43
(1402)  201011      -1.23      -0.19       0.60       0.93       0.60       0.40
(1403)  201012      -0.74      -0.88       0.41       0.76       0.33       0.02


   Example 8

   Consider prc(time,lat,lon) and PRC(lat,lon,time), calculate a 12-month SPI. Note that the dims changes depending upon
   order of the variable dimensions.
   prc    = f->prc                   ; prc(time,lat,lon)     => (0,1,2)
   run    = 12
   spi    = dim_spi3_n(prc, run, False, 0) => (ntim,nlat,mlon)

   opt    = True
   opt@spi_type = 3       ; calculate using Pearson III distribution

   PRC    = f->PRC                   ; PRC(lat,lon,time)     => (0,1,2)
   SPI    = dim_spi_n(PRC, run, opt, 2) => (nlat,mlon,ntim)

; optional ... add meta data

   spi@long_name = "spi: run="+run
   copy_VarCoords(prc, spi)          ; contributed.ncl

   SPI@long_name = "SPI: run="+run
   copy_VarCoords(PRC, SPI)          ; contributed.ncl


   Example 9

   Consider prc(time,lat,lon) where the sizes are (384,72,144); calculate calculate multiple SPI.
   f      = addfile("V22_GPCP.1979-2010.nc","r")
   prc    = f->PREC                    ; PREC(time,lat,lon)
   printVarSummary(prc)

   dimp   = dimsizes(prc)              ; # monthly precipitation values
   ntim   = dimp(0)
   nlat   = dimp(1)
   mlon   = dimp(2)

   len    = (/3, 6, 12, 24, 36, 48 /)
   klen   =  dimsizes(len)
   spi    =  new((/klen,ntim,nlat,mlon/) ,float,prc@_FillValue)

   opt    = True
   opt@spi_type = 3       ; calculate using Pearson III distribution

   do k=0,klen-1
      spi(k,:,:,:) = dim_spi_n(prc, len(k), opt, 0)
   end do

   copy_VarCoords(prc,spi(0,:,:,:))
   spi@long_name = "SPI"
   spi!0         = "len"
   spi&len       =  len
   printVarSummary(spi)    ; [len | 6] x [time | 384] x [lat | 72] x [lon | 144]

; print values at one location

   LAT = 45.5
   LON = 292.5

   yyyymm = cd_calendar(f->time, -1)  ; time@units = "days since ..."

   print(yyyymm+sprintf("%8.2f", prc)   \
               +sprintf("%8.2f", spi(0,:,{LAT},{LON}))   \
               +sprintf("%8.2f", spi(1,:,{LAT},{LON}))   \
               +sprintf("%8.2f", spi(2,:,{LAT},{LON}))   \
               +sprintf("%8.2f", spi(3,:,{LAT},{LON}))   \
               +sprintf("%8.2f", spi(4,:,{LAT},{LON}))   \
               +sprintf("%8.2f", spi(5,:,{LAT},{LON}))   )



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:02:06 +0800
# vim:set fdm=indent foldlevel=0:
