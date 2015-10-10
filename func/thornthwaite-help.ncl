THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/thornthwaite.shtml
THE_TITLE:thornthwaite

thornthwaite

   Estimate the potential evapotranspiration (PET) via the Thornthwaite method.

   [new.gif] Available in version 6.3.0 and later.

Prototype

        function thornthwaite (
                t       : numeric,
                lat     : numeric,
                opt [1] : logical,
                dim [1] : integer
        )

        return_val  :  float or double

Arguments

   t

   Monthly near surface temperature (C). The number of months (ntim) must be a multiple of 12. Further, it is assumed that
   the data start in January. Common dimensionalities include: t(ntim), t(ntim,ncol), t(ntim,nlat,mlon), t(ncase,ntim),
   t(ncase,ntim,nlat,mlon), t(ncase,ntim,klon).
   lat

   Latitude(s) of the current station or grid point(s).
     * t(ntim), then lat is a scalar and dim=0
     * t(ntim,ncol), and the grid is unstructured (eg: spectral element); then lat(ncol) and dim=0
     * t(ntim,nlat,mlon), and the grid is rectilinear, then lat(nlat) and dim=0
     * t(ntim,nlat,mlon), and the grid is curvilinear, then lat(nlat,mlon) and dim=0
     * t(ncase,ntim), then lat is a scalar and dim=1
     * t(ncase,ntim,ncol), and the grid is unstructured (eg: spectral element); then lat(ncol) and dim=1
     * t(ncase,ntim,nlat,mlon), and the grid is curvilinear, then lat(nlat,mlon) and dim=1
     * t(ncase,ntim,nlat,mlon), and the grid is curvilinear, then lat(nlat,mlon) and dim=1

   opt

   Not used. Set to False.
   dim

   The dimension of t to be used to estimate the potential evapotranspiration (PET). This is the time dimension.

Return value

   The returned PET will be the same shape, size and type as t. The units are millimeters/month (ie: monthly total).

Description

   Potential evapotranspiration (PET) is estimated via the method of Thornthwaite. The only variable used is monthly
   temperature [t (C)]. The calculated climatological means are used to calculate an annual temperature efficiency index.
   The latitude is used to adjust the number of sunlight hours over the course of the year.

   This method has been the subject of many criticisms. Generally, the Thornthwaite method underestimates PET in the arid
   areas and over estimates PET in the humid areas.

   Also, there is confusion about the difference between potential evapotranspiration (PET) and reference evapotranspiration
   (ETo). Irmak and Haman (2014) provide a nice description in their paper entitled Evapotranspiration: Potential or
   Reference?. [UF: IFAS Extension: ABE 343].

References:

C.W. Thornthwaite (1948):
An approach toward a rational classification of climate, Geographical Review 38 (1): 55-94.
        http://dx.doi.org/10.2307/21073

A.R. Pereira, Ã. Paes De Camargo (1989):
An analysis of the criticism of thornthwaite's equation for estimating potential evapotranspiration
Agricultural and Forest Meteorology, Volume 46, Issue 1, Pages 149-157
        http://dx.doi.org/10.1016/0168-1923(89)90118-4

F. Hashemi, M.T. Habibian (1979):
Limitations of temperature-based methods in estimating crop evapotranspiration
in arid-zone agricultural development projects
Agricultural Meteorology, Volume 20, Issue 3, June 1979, Pages 237-247
        http://dx.doi.org/10.1016/0002-1571(79)90025-6


See Also

   dim_spi_n, dim_spi3_n, dim_gamfit_n, speidx

Examples

   Example 1

   Sellers (1969), Physical Climatology, pg 173 includes an example for one year at Aspendale, Australia. Compute potential
   evapotranspiration (mm/month) and compare with Sellers Table 23 which are in units of mm/day.

   tmp           = (/23.3, 21.1, 19.6, 17.2, 12.6, 10.9 \
                    ,10.0, 11.0, 13.0, 15.8, 17.8, 20.1/)
   tmp@units     = "degC"
   tmp@long_name = "Sellers, Physical Climatology; 1969, p173"

   printVarSummary(tmp)
   print("min="+min(tmp)+"  max="+max(tmp))

   latAsp = -38.0                                        ; Latitude of Aspendale, Australia
   pet    = thornthwaite(tmp, latAsp, False, 0)
   pet@long_name = "PET: Aspendale, Australia"
   pet@units     = "mm/month"                            ; ie, monthly total

; Compare with Sellers Table 23, pg 173 which are in units of mm/day

   dymo   = (/31,28,31,30,31,30,31,31,30,31,30,31/)
   pet    = pet/dymo                                     ; mm/month =>  mm/day
   pet@units    = "mm/day"

   pet_sellers = (/4.47, 3.51, 2.80, 2.04, 1.09, 0.80 \
                  ,0.74, 0.89, 1.50, 2.09, 2.73, 3.47 /)
   pet_sellers@long_name = "PET: Sellers Table 23"
   pet_sellers@units     = "mm/day"

   printVarSummary(pet_sellers)
   print("min="+min(pet_sellers)+"  max="+max(pet_sellers))

   print(" ")
   print(pet_sellers+"  "+sprintf("%6.2f",pet) )


   The (edited) output looks like:


     Variable: pet_sellers
     Type: float
     Total Size: 48 bytes
                 12 values
     Number of Dimensions: 1
     Dimensions and sizes:   [12]
     Coordinates:
     Number Of Attributes: 2
       units :       mm/day
       long_name :   PET: Sellers Table 23

     (0)     min=0.74  max=4.47

             Sellers     NCL
     (0)        4.47    4.32
     (1)        3.51    3.46
     (2)        2.80    2.81
     (3)        2.04    2.03
     (4)        1.09    1.11
     (5)        0.80    0.83
     (6)        0.74    0.74
     (7)        0.89    0.94
     (8)        1.50    1.37
     (9)        2.09    2.09
     (10)       2.73    2.73
     (11)       3.47    3.45

   Example 2

   Read an ascii file containing 117 years of monthly temperatures at Boulder, Colorado (source:
   http://www.esrl.noaa.gov/psd/boulder/). Compute potential evapotranspiration (mm/month).
   dirt   = "./"
   filt   = "Boulder.temp.1897-2013.txt"

   ncol   = 14  ; due to the structure of the data, it is better to read as 2D
   nrow   = numAsciiRow(dirt+filt)      ; contributed.ncl
   tmp2   = asciiread(dirt+filt,(/nrow,ncol/), "float")

   tmp           = ndtooned(tmp2(:,1:ncol-2))              ; make one dimensional
   tmp@units     = "degF"
   tmp@long_name = "Boulder Temperature"

   tmp    = (5.0/9.0)*(tmp-32)                           ; Convert F=>C
   tmp@units     = "degC"

   printVarSummary(tmp)
   print("tmp: min="+min(tmp)+"  max="+max(tmp))

   TMP    = ndtooned( tmp )                          ; create a time series                           ;


   latBld = 40.0                                         ; Boulder is at 40N latitude
   pet    = thornthwaite(TMP, latBld, False, 0)
   pet@long_name = "PET"
   pet@units     = "mm/month"                            ; ie, monthly total

   printVarSummary(pet)
   print("pet: min="+min(tmp)+"  max="+max(tmp))

   write_matrix (onedtond(pet,(/nyrs,12/)), "12f7.1", False) ; requires 2D



   The (edited) output

     Variable: pet
     Type: float
     Total Size: 11232 bytes
                 1404 values
     Number of Dimensions: 1
     Dimensions and sizes:   [1404]
     Coordinates:
     Number Of Attributes: 3
       units :       mm/month
       long_name :   PET: Boulder, CO
       _FillValue :  -9999

(0)  tmp: min=-8.66667  max=25.7222
---
     Variable: pet
     Type: float
     Total Size: 5616 bytes
                 1404 values
     Number of Dimensions: 1
     Dimensions and sizes:   [1404]
     Coordinates:
     Number Of Attributes: 3
       units :       mm/month
       long_name :   PET
       _FillValue :  9.96921e+36
(0)     pet: min=0  max=162.275
---

          J      F      M      A      M      J      J      A      S      O      N      D

         0.0    0.2    7.4   38.6   86.6  103.7  129.9  115.6   94.0   44.4   16.0    0.0
         0.0   10.1    6.0   42.2   56.5  111.6  136.5  131.1   78.7   35.9    6.3    0.0
         0.0    0.0    3.0   41.9   74.7  108.8  123.3  121.0   91.3   39.9   28.4    4.9
         7.1    0.0   23.1   32.2   85.1  123.5  130.3  128.0   77.1   58.2   21.7   10.2
         6.0    0.0   15.3   36.0   83.9  109.2  149.1  124.5   76.4   48.2   28.7    3.7
         0.1    8.7   13.2   41.0   82.8  112.4  124.1  126.4   74.5   52.0   16.4    6.0
     [SNIP]
         0.0    5.5   17.2   38.0   75.1  109.6  148.2  117.9   74.8   28.3   24.7    0.0
         9.2   11.8   25.9   36.6   83.2   97.5  125.8  117.9   81.9   24.7   20.1    0.0
         1.0    0.0   21.9   41.0   63.5  112.8  137.7  128.8   93.3   52.0   12.1    7.2
         1.1    0.0   28.3   41.3   62.8  115.5  141.9  139.4   82.8   46.3   17.0    0.1
        10.5    0.2   43.6   58.0   86.6  142.3  147.4  131.9   91.3   40.7   24.9    1.8
         1.0    0.1   16.5   26.6   77.3  124.7  136.5  128.0   88.4   32.9   18.8    0.0

   Example 3

   Read the Wichita data used by the R-SPEI package. Calculate the Thornthwaite estimates via NCL's thornthwaite function
   and compare with those on the file. NOTE: The values are basically identical.

   dirw   = "./"
   filw   = "Wichita.Rspei.198001-201112.nc"
   fw     = addfile(dirw+filw, "r")

   tavg   = fw->TAVG

   printVarSummary(tavg)
   print("tavg: min="+min(tavg)+"  max="+max(tavg))

   lat    = fw@latitude                                  ; Wichita: 37.65N
   pet    = thornthwaite(tavg, lat, False, 0)
   pet@long_name = "PET: Wichita"
   pet@units     = "mm/month"                            ; ie, monthly total
   pet@tag       = "NCL: thormthwaite"
   copy_VarCoords(tavg, pet)

   printVarSummary(pet)
   print("pet: min="+min(pet)+"  max="+max(pet))

   ntim = dimsizes(tavg)
   nyrs = ntim/12
   write_matrix (onedtond(pet,(/nyrs,12/)), "12f7.1", False)

; Read SPEI-R values from R-SPEI file for comparison.
; Note the last 2 months contain missing values.

   pet_spei = fw->PET_TW

   pet_diff = max( abs(pet - pet_spei) )
   print("maximum difference: pet_diff="+pet_diff)

   The output is:

     Variable: tavg
     Type: float
     Total Size: 1536 bytes
                 384 values
     Number of Dimensions: 1
     Dimensions and sizes:   [time | 384]
     Coordinates:
                 time: [198001..201112]
     Number Of Attributes: 3
       long_name :   average temperature
       units :       degC
       _FillValue :  -999
     (0)     tavg: min=-8.71  max=32.46

     Variable: pet
     Type: float
     Total Size: 1536 bytes
                 384 values
     Number of Dimensions: 1
     Dimensions and sizes:   [time | 384]
     Coordinates:
                 time: [198001..201112]
     Number Of Attributes: 4
       tag : NCL: thormthwaite
       units :       mm/month
       long_name :   PET: Wichita
       _FillValue :  -999
     (0)     pet: min=0  max=226.929

          J      F      M      A      M      J      J      A      S      O      N      D

         0.0    0.0   10.9   44.2   84.4  163.2  226.9  184.8  117.6   51.7   18.3    3.1
         0.8    6.9   23.7   76.9   80.7  152.6  186.5  147.6  104.2   43.2   18.3    0.2
[SNIP]
         0.0    0.1   22.6   66.6   94.2  167.7  181.6  175.5  113.6   62.8   17.4    0.9
         0.0    0.1   24.6   58.7   97.2  171.7  220.2  183.3   93.7   81.3 -999.0 -999.0

(0)     maximum difference: pet_diff=1.52588e-05




   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:13:36 +0800
# vim:set fdm=indent foldlevel=0:
