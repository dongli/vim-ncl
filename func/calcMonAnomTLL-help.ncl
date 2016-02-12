THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/calcMonAnomTLL.shtml
THE_TITLE:calcMonAnomTLL

calcMonAnomTLL

   Calculates monthly anomalies by subtracting the long term mean from each point (time,lat,lon version)

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function calcMonAnomTLL (
                x     [*][*][*] : float or double,
                xAve [12][*][*] : numeric
        )

        return_val [dimsizes(x)] :  numeric

Arguments

   x

   A three-dimensional array of any numeric type. Dimensions must be time,lat,lon The time dimension must be a multiple of
   12.
   xAve

   A three-dimensional array equal to the monthly averages of x. The leftmost two dimensions are lat and lon, while the
   leftmost must be of size 12.

Return value

   An array of the same size and type as x.

Description

   Calculates climatological anomalies by subtracting the long term mean from each point. Assumes monthly data. If the input
   data contains metadata (e.g. coordinate variables and attributes), these will be retained.

See Also

   calcMonAnomLLLT, calcMonAnomLLT, calcMonAnomTLLL, clmMonLLT, clmMonLLLT, clmMonTLL, clmMonTLLL

Examples

   Example 1


;---Get data
  fa     = addfile("air.mean.nc","r")
  fb     = addfile("air.nobs.nc","r")

  air  = short2flt( fa->air)                           ; air temp
  nobs = short2flt( fb->air)                           ; # obs for air
; filter out geographic locations that have < nMin observations
  nMin   = 2                                           ; min # obs
  air    = mask(air,nobs.ge.nMin,True)

;---Compute the climatology using a function in contributed.ncl
  yrStrt = 1950
  yrLast = 1979
  moStrt = (yrStrt-1800)*12              ; start subscript
  moLast = (yrLast-1800)*12 + 11         ; last  subscript
  clm = clmMonTLL (air(moStrt:moLast,:,:)) ; monthly climatology

;---Compute the anomalies from the climatology just computed
  xAnom = calcMonAnomTLL (air,clm)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:31 +0800
# vim:set fdm=indent foldlevel=0:
