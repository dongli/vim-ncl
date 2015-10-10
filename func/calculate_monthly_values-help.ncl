THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/calculate_monthly_values.shtml
THE_TITLE:calculate_monthly_values

calculate_monthly_values

   Calculate monthly values [avg, sum, min, max] from high frequency temporal values.

   [new.gif] Available in version 6.2.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function calculate_monthly_values (
                x         : numeric,
                arith [1] : string,
                nDim  [1] : integer,
                opt   [1] : logical
        )

        return_val  :  float or double array with with the same rank as x.

Arguments

   x

   Array containing the high frequency data. The rank of x must be <= 4.
   arith

   A scalar string value which specifies the operation to be performed. Valid values are: "avg" [also, "ave"], "sum", "min",
   "max". It is required that x have associated with it a coordinate variable named time (ie, x&time) where "time" is
   recognized by cd_calendar.
   nDim

   The dimension of x on which to calculate the statistic.
   opt

   Currently not used. Set to False.

Return value

   An array of the same rank as x.

Description

   The function uses cd_calendar to extract the year, month, day and hour. The values for a particular month are used.

See Also

   dim_avg_n, dim_sum_n, dim_min_n, dim_max_n

Examples

   The following require that contributed.ncl be loaded prior to invoking the function.
       load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

   Example 1

   Let x(time,lat,lon) where x&time is recognized by cd_calendar. The values of x may contain (say) n-hourly or daily data.
              xMonthAvg = calculate_monthly_values(x, "avg", 0, False)
              xMonthSum = calculate_monthly_values(x, "sum", 0, False)
              xMonthMin = calculate_monthly_values(x, "min", 0, False)
              xMonthMax = calculate_monthly_values(x, "max", 0, False)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:34 +0800
# vim:set fdm=indent foldlevel=0:
