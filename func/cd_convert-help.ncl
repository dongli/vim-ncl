THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/cd_convert.shtml
THE_TITLE:cd_convert

cd_convert

   Converts a time variable from one set of units to another.

   [new.gif] Available in version 6.1.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function cd_convert (
                dateFrom  : numeric,
                unitsTo   : string
        )

        return_val [dimsizes(dateFrom)] :  double

Arguments

   dateFrom

   The original date(s) to convert. It must contain a "units" attribute in in the format "units since basetime". The
   following calendars are recognized:
standard
gregorian
proleptic_gregorian
julian
360_day, 360
365_day, 365
366_day, 366
noleap, no_leap
allleap, all_leap

   The following common calendaring systems are NOT recognized by cd_convert:
command_year
n kyr B.P.

   unitsTo

   The new date unit to convert to, which must adhere to the same restrictions on the input units.

Return value

   An array of type double and the same size as dateFrom.

Description

   This function converts dateFrom from its original Julian/Gregorian units to the new specified units, using the built-in
   functions cd_calendar and cd_inv_calendar.

   It is meant as a replacement for ut_convert, which uses functions that are no longer being supported (ut_calendar and
   ut_inv_calendar).

   If the input data does not contain a units attribute, then an error message will be printed and all missing values will
   be returned.

   To quote the Udunits man page:

     The cd_xxx functions use a mixed Gregorian/Julian calendar system. Dates prior to 1582-10-15 are assumed to use the
     Julian calendar, which was introduced by Julius Caesar in 46 BCE and is based on a year that is exactly 365.25 days
     long. Dates on and after 1582-10-15 are assumed to use the Gregorian calendar, which was introduced on that date and
     is based on a year that is exactly 365.2425 days long. (A year is actually approximately 365.242198781 days long.)

   The original version of this function was contributed by Carl J. Schreck, III, a graduate student at the University at
   Albany in the Department of Earth and Atmospheric Sciences.

See Also

   cd_string, cd_calendar, cd_inv_calendar

Examples

   The following require that contributed.ncl be loaded prior to invoking the function.
       load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

   Example 1

   Convert a time variable from hours to days:
  time_hours = cd_inv_calendar( 2000, 01, 01, 00, 00, 00,  "hours since 1800-01-01 00:00", 0 )
  print( time_hours )
  time_days = cd_convert( time_hours, "days since 1800-01-01 00:00" )
  print( time_days )

   The above will output:
Variable: time_hours
Type: double
Total Size: 8 bytes
            1 values
Number of Dimensions: 1
Dimensions and sizes:   [1]
Coordinates:
Number Of Attributes: 1
  units :       hours since 1800-01-01 00:00
(0)     1753152

Variable: time_days
Type: double
Total Size: 8 bytes
            1 values
Number of Dimensions: 1
Dimensions and sizes:   [1]
Coordinates:
Number Of Attributes: 1
  units :       days since 1800-01-01 00:00
(0)     73048

   Example 2

   Overlay on a Hovmueller two datasets that use different units for their time coordinates:
  data2&time = cd_convert( data2&time, data1&time@units )
  contour1 = gsn_csm_hov( wks, data1, res1 )
  contour2 = gsn_csm_hov( wks, data2, res2 )
  overlay( contour1, contour2 )


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:36 +0800
# vim:set fdm=indent foldlevel=0:
