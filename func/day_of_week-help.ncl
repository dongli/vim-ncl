THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/day_of_week.shtml
THE_TITLE:day_of_week

day_of_week

   Calculates the day of the week given month, day, and year (Gregorian calendar).

Prototype

        function day_of_week (
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

   A integer array of the same size as year with values between 0 and 6, where 0=Sunday, 1=Monday, ..., 6=Saturday.

Description

   Calculates the day of the week given month, day, and year. Gregorian calendar only.

   In V6.1.0. this function was upgraded to recognize missing values.

See Also

   day_of_year, days_in_month, day_of_week, monthday, isleapyear

Examples

   Example 1

dow = day_of_week((/1996,1990/),(/3,3/),(/1,1/))
; dow = (/5,4/)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:01:18 +0800
# vim:set fdm=indent foldlevel=0:
