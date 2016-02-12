THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/smthClmDayTLL.shtml
THE_TITLE:smthClmDayTLL

smthClmDayTLL

   Calculates a smooth mean daily annual cycle for an array nominally dimensioned (Time,Lat,Lon).

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function smthClmDayTLL (
                clmDay [366][*][*] : float or double,
                nHarm          [1] : integer
        )

        return_val [366][*][*] :  typeof(clmDay)

Arguments

   clmDay

   A three-dimensional array (366, lat, lon) output by clmDayTLL.
   nHarm

   The number of harmonics that will be used to construct the smoothed mean annual cycle. Usually, nHarm is 1 to 3 with 2
   being most common. A value of 2 means to use the annual and semi-annual harmonics only.

Return value

   A climatological time series where the leftmost dimension refers to the sequential day of the year.

Description

   Calculate a smooth annual cycle using the output from clmDayTLL. A Fourier analysis is performed via an fft. Next, all
   harmonics greater than nHarm are set to zero and a backward transform is performed.

   In 6.2.1, this function was updated to work on daily SST data which have _FillValue over land.

See Also

   smthClmDayTLLL, clmDayTLL, clmMonTLL, clmMonTLLL, clmMonLLLT, clmMonLLT

Examples

   Example 1

   Compute the smooth long term daily means. The input is daily 500 hPa heights spanning 1990-1999. The values are packed as
   type short and the time is in units "hours since 1-1-1 00:00:0".
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
   :
   :
   diri    = "./"                             ; input directory
   fili    = "HGT.nc"                         ; input file
   f       = addfile (diri+fili , "r")
;***********************************************************
; Read time and create required yyyyddd
;***********************************************************
   time    = f->time                          ; time:units = "hours since 1-1-1 00:00:0.0"
   TIME    = cd_calendar(time, 0)          ; type float
   year    = toint( TIME(:,0) )
   month   = toint( TIME(:,1) )
   day     = toint( TIME(:,2) )
   ddd     = day_of_year(year, month, day)
   yyyyddd = year*1000 + ddd                                  ; needed for input
;***********************************************************
; Read data: short2flt
;***********************************************************
   hgt     =  short2flt( f->hgt(:,0,:,:) )    ; convert to float
;***********************************************************
; Compute raw daily climatology
;***********************************************************
   hClmDay    = clmDayTLL(hgt, yyyyddd)     ; daily climatology at each grid point
;***********************************************************
; Compute smoothed daily climatology using 2 harmonics
;***********************************************************
   hClmDay_sm = smthClmDayTLL(hClmDay, 2)
   printVarSummary(hClmDay_sm)

   The (edited) output yields
Variable: hClmDay_sm
Type: float
Number of Dimensions: 3
Dimensions and sizes:   [year_day | 366] x [lat | 73] x [lon | 144]
Coordinates:
            year_day: [1..366]
            lat: [90..-90]
            lon: [ 0..357.5]
Number Of Attributes: 4
  smoothing :   FFT: 2 harmonics were retained.
  information : Smoothed daily climatological averages
  units :       m
  long_name :   Daily Climatology: mean Daily Geopotential height


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:06 +0800
# vim:set fdm=indent foldlevel=0:
