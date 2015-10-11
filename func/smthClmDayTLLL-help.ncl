THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/smthClmDayTLLL.shtml
THE_TITLE:smthClmDayTLLL

smthClmDayTLLL

   Calculates a smooth mean daily annual cycle for an array nominally dimensioned (Time,Level,Lat,Lon).

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function smthClmDayTLLL (
                clmDay [366][*][*][*] : float or double,
                nHarm             [1] : integer
        )

        return_val [366][*][*][*] :  typeof(clmDay)

Arguments

   clmDay

   A four-dimensional array (366, lev, lat, lon) output by clmDayTLLL.
   nHarm

   The number of harmonics that will be used to construct the smoothed mean annual cycle. Usually, nHarm is 1 to 3 with 2
   being most common. A value of 2 means to use the annual and semi-annual harmonics only.

Return value

   A climatological time series where the leftmost dimension refers to the sequential day of the year.

Description

   Calculate a smooth annual cycle using the output from clmDayTLLL. A Fourier analysis is performed via an fft. Next, all
   harmonics greater than nHarm are set to zero and a backward transform is performed.

   In 6.2.1, this function was updated to work on daily SST data which have _FillValue over land.

See Also

   smthClmDayTLL, clmDayTLL, clmMonTLL, clmMonTLLL, clmMonLLLT, clmMonLLT

Examples

   Example 1

   Compute the smooth long term daily means at all 17 pressure levels. The input is daily geopotential heights. The values
   are packed as type short and must be unpacked.
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"    ; not needed after 6.1.0

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
   hgt     =  short2flt( f->hgt)  ; convert to float w meta data
   printVarSummary(hgt)

;***********************************************************
; Compute raw daily climatology
;***********************************************************
   hClmDay    = clmDayTLLL(hgt, yyyyddd)     ; daily climatology at each grid point

;***********************************************************
; Compute smoothed daily climatology using 2 harmonics
;***********************************************************
   hClmDay_sm = smthClmDayTLLL(hClmDay, 2)
   printVarSummary(hClmDay_sm)

   The (edited) output yields

Variable: hgt
Type: float
Total Size: 1305254016 bytes
            326313504 values
Number of Dimensions: 4
Dimensions and sizes:    [time | 1826] x [level | 17] x [lat | 73] x [lon | 144]
Coordinates:
            time: [17470320..17514120]
            level: [1000..10]
            lat: [90..-90]
            lon: [ 0..357.5]
Number Of Attributes: 17
  long_name :    mean Daily Geopotential height
  units :    m
[SNIP]


   The smoothed variable is:

Variable: hClmDay_sm
Type: float
Number of Dimensions: 3
Dimensions and sizes:   [year_day | 366] x [level | 17] [lat | 73] x [lon | 144]
Coordinates:
            year_day: [1..366]
            level: [1000..10]
            lat: [90..-90]
            lon: [ 0..357.5]
Number Of Attributes: 4
  smoothing :   FFT: 2 harmonics were retained.
  information : Smoothed daily climatological averages
  units :       m
  long_name :   Daily Climatology: mean Daily Geopotential height


   Example 2

   Example 5 of the Climatology Applications page shows how to apply the function(s) to 3-dimensional arrays. It is trivial
   to alter the script to handle 4-dimensional variables. For example, change clmDayTLL and smthClmDayTLL to clmDayTLLL and
   smthClmDayTLLL, respectively and make all array references 4-dimensional. For example, change
   x       =  short2flt( f->$var$(iStrt:iLast,:,:) )      ; convert to float

   to
   x       =  short2flt( f->$var$(iStrt:iLast,:,:,:) )    ; convert to float


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:07 +0800
# vim:set fdm=indent foldlevel=0:
