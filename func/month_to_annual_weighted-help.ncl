THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/month_to_annual_weighted.shtml
THE_TITLE:month_to_annual_weighted

month_to_annual_weighted

   Converts monthly values to annual values weighted by the number of days in a month.

   [new.gif] Available in version 4.2.0.a033 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function month_to_annual_weighted (
                yyyymm [*] : numeric,
                x          : numeric,
                opt    [1] : integer
        )

Arguments

   yyyymm

   Year-month dates [e.g., 198401,198402,...]. This must be the same size as the "time" dimension of x.
   x

   An array containing monthly values. The "time" dimension must be the leftmost dimension if there are multiple dimensions.
   Ideally, the size of the "time" dimension is evenly divisible by 12.
   opt

   option:
       opt=0 returns the weighted sum
       opt=1 return the weighted annual mean
       opt=2 return the weighted sum divided by 12 to get monthly mean value

Return value

   Returns an array where the "time" dimension is decimated by a factor of 12.

Description

   Typical usage is that an array of monthly precipitation rate (e.g., mm/day) or monthly mean temperatures are input. For
   precipitation, generally opt=0, and the weighted average is returned. For temperature, generally opt=1, and the weighted
   annual average is returned.

   The weights are the appropriate number days for a month. February of leap years uses 29 days.

   This function does not check for January (mm=1) to be the first month of the yyyymm. Thus, if yyyymm(0)=198103 [say],
   then the 12-month year will be March 1983 to April 1984.

   If the time span is not divisible by 12 then the 'extra' months are ignored. For example, if yyyymm spans 199101 to
   199603, weighted annual means will be calculated for 1991 to 1995. There will be no value returned for 1996.

   Caveat: This function works as expected for one-dimensional arrays. Also, it works fine when all grid points have 12
   non-missing monthly values for any year. However, if any grid point does not have 12 valid values, then the annual values
   will be returned as missing for all grid points for that year.

See Also

   month_to_annual

Examples

   Example 1

   A one-dimensional array of monthly precipitation [mm/day] is to be converted to an annual total. If prc(time), and the
   size of time is 240 monthly values, than 20 (=240/12) values (years) will be returned.
        prc_annual_total = month_to_annual_weighted(yyyymm, prc, 0)  ; prc_annual_total(20)

   If the array contains, say, monthly mean temperatures (tmp), then
        tmp_annual_mean = month_to_annual_weighted(yyyymm, tmp, 1)   ; tmp_annual_mean(20)

   Example 2

   A multi-dimensional array of monthly precipitation totals [mm/day] is to be converted to an annual total. If
   prc(time,lat,lon), and the size of time is 1200 monthly values, than 100 (=120/12) values (years) will be returned.
        PRC = month_to_annual_weighted(yyyymm, prc, 0)  ; PRC(100,nlat,mlon)

   If the array contains, say, monthly mean temperatures [tmp(time,lev,lat,lon)], then
        TMP = month_to_annual_weighted(yyyymm, tmp, 1)  ; TMP(100,klev,nlat,mlon)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:18:57 +0800
# vim:set fdm=indent foldlevel=0:
