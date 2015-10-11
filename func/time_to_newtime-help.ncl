THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/time_to_newtime.shtml
THE_TITLE:time_to_newtime

time_to_newtime

   Change a "udunits" recognized time unit to a new (different) "udunits" recognized time unit.

   [new.gif] Available in version 5.2.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function time_to_newtime (
                time              : numeric,  ; float or double
                new_time_unit [1] : string
        )

        return_val [dimsizes(time)] :  double or float

Arguments

   time

   A "udunits" recognized time variable. Must be type "float" or "double".
   new_time_unit

   A "udunits" recognized string indicating the unit of the new time variable.

Return value

   An array of the same size as time: double if time is double; float if time is float. is double

Description

   This function converts the time units using cd_calendar. Useful for making the time variables associated with different
   variables and files consistent.

See Also

   cd_calendar, cd_inv_calendar, calendar_decode2

Examples

   Example 1

   Create a new time variable.
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

  TIME = f->time                                ; hours since 1-1-1 00:00:0.0
  DATE = cd_calendar (TIME, 0)

  new_time_units = "hours since 1800-01-01 00:00"

  time = time_to_newtime(TIME, new_time_units)

  printVarSummary(TIME)
  printVarSummary(time)

   The edited output from the above:

Variable: TIME
Type: double
Total Size: 5968 bytes
            746 values
Number of Dimensions: 1
Dimensions and sizes:   [time | 746]
Coordinates:
            time: [17067072..17611320]
Number Of Attributes: 6
  units :       hours since 1-1-1 00:00:0.0

-------------------------------------------------


Variable: time
Type: double
Total Size: 5968 bytes
            746 values
Number of Dimensions: 1
Dimensions and sizes:   [time | 746]
Coordinates:
            time: [1297320..1841568]
Number Of Attributes: 2
  units :       hours since 1800-01-01 00:00
  calendar :    gregorian

   Example 2

   Overwrite the current time variable.
    time = time_to_newtime(time, "hours since 1800-01-01 00:00") ; time(time)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:20 +0800
# vim:set fdm=indent foldlevel=0:
