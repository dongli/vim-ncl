THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/day_of_year.shtml
THE_TITLE:day_of_year

day_of_year

   Calculates the day of the year (sometimes erroneously referred to as 'julian day') given Gregorian calendar month, day,
   and year.

Prototype

        function day_of_year (
                year   : integer,
                month  : integer,
                day    : integer
        )

        return_val [dimsizes(year)] :  integer

Arguments

   year

   A multi-dimensional integer array or scalar value representing years. Values must be >= 0.
   month

   An integer array of the same size as year representing months of the year. Values must be 1 to 12.
   day

   An integer array of the same size as year representing days of the month. Values must be 1 to 31.

Return value

   A integer array of the same size as year where each value represents the day of the year. NOTE: This is not the same as
   the classic Julian day as returned by greg2jul.

Description

   This function calculates the day of the year given month, day, and year (Gregorian calendar).

   The following is from here:
     * The day of year is often but erroneously called Julian Date, when in fact it is a Gregorian Date expressed as number
       of days in the year. This is a grossly misleading practice that was introduced by some who were simply ignorant and
       too careless to learn the proper terminology. It creates a confusion which should not be taken lightly. Moreover, a
       continuation of the use of expressions "Julian" or "J" day in the sense of a Gregorian Date will make matters even
       worse. It will inevitably lead to dangerous mistakes, increased confusion, and it will eventually destroy whatever
       standard practices exist.

   In V6.1.0, this function was upgraded to look for a "calendar" attribute attached to the "year" variable. Valid calendars
   include:
     * "standard" (the default)
     * "gregorian"
     * "julian"
     * "360_day", "360"
     * "365_day", "365"
     * "366_day", "366"
     * "noleap", "no_leap"
     * "allleap", "all_leap"
     * "none"

   Also in V6.1.0, this function was upgraded to recognize missing values.

See Also

   day_of_week, days_in_month, monthday, isleapyear

Examples

   Example 1

doy = day_of_year((/1900,1990,1996/),(/3,3,3/),(/1,1,1/)) ; doy = (/60,60,61/)

   Example 2

   Same as example 1, but using different calendars, which are only recognized in NCL version 6.1.0.

year  = (/1900,1990,1996/)
month = (/3,3,3/)
day   = (/1,1,1/)

;---No calendar
doy = day_of_year(year,month,day)  ; doy = (/60,60,61/)

year@calendar = "standard"
doy = day_of_year(year,month,day)  ; doy = (/60,60,61/)

year@calendar = "julian"
doy = day_of_year(year,month,day)  ; doy = (/61,60,61/)

year@calendar = "noleap"           ; also "365"
doy = day_of_year(year,month,day)  ; doy = (/61,60,60/)

year@calendar = "allleap"          ; also "366"
doy = day_of_year(year,month,day)  ; doy = (/61,61,61/)

year@calendar = "360"
doy = day_of_year(year,month,day)  ; doy = (/61,61,61/)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:01:20 +0800
# vim:set fdm=indent foldlevel=0:
