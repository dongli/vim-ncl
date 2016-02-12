THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/calcMonAnomLLT.shtml
THE_TITLE:calcMonAnomLLT

calcMonAnomLLT

   Calculates monthly anomalies by subtracting the long term mean from each point (lat,lon,time version)

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function calcMonAnomLLT (
                x     [*][*][*] : numeric,
                xAve [*][*][12] : numeric
        )

        return_val [dimsizes(x)] :  numeric

Arguments

   x

   A three-dimensional array of any numeric type. Dimensions must be lat, lon, time. The time dimension must be a multiple
   of 12.
   xAve

   A three-dimensional array equal to the monthly averages of x. The leftmost two dimensions are lat and lon, while the
   rightmost must be of size 12.

Return value

   An array of the same size and type as x.

Description

   Calculates climatological anomalies by subtracting the long term mean from each point. Assumes monthly data. If the input
   data contains metadata (e.g. coordinate variables and attributes), these will be retained.

See Also

   calcMonAnomLLLT, calcMonAnomTLL, clmMonLLT, clmMonLLLT, clmMonTLL, clmMonTLLL

Examples

   Example 1


;====================================
; Read data
;====================================
  in = addfile("zzp300.monthly.1948_1998.nc","r")
  tser_t  = in->ZZP({25:},:,:)
  tser    = tser_t(time|:,lat|:,lon|:)    ;1948-1998  (612)

  dimice=dimsizes(tser)
  ntim2=dimice(0)
  nlat2=dimice(1)
  mlon2=dimice(2)

;====================================
; Calculate the JFM Clim.
;====================================
  temptser = tser(lat|:,lon|:,time|:)
  jfmtemp  = temptser(:,:,:50)
  jfmclim  = temptser(:,:,0)
  soi1     = runave(temptser,3,0)
  jfmtemp  = (/ soi1(:,:,1:ntim2-1:12) /)
  jfmclim = (/ dim_avg(jfmtemp) /)
;====================================
; Calculate and Remove the Long-Term
; Monthly Means, + compute JFM Avg.
;====================================
  slp_clm = clmMonLLT (temptser)             ;Calculate LTMM's
  newslp  = calcMonAnomLLT(temptser,slp_clm) ;Calculate Anomalies from Means


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:30 +0800
# vim:set fdm=indent foldlevel=0:
