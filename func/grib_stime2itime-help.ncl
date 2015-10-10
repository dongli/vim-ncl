THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/grib_stime2itime.shtml
THE_TITLE:grib_stime2itime

grib_stime2itime

   Converts grib initial_time (string) to time (integer).

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function grib_stime2itime (
                stime [*] : string
        )

        return_val [dimsizes(stime)] :  integer

Arguments

   stime

   An array of strings.

Return value

   An integer array of the same dimensionality as stime is returned. In addition, the attributes "long_name" and "units"
   will be set, and the return value will be made a coordinate variable. (That is, dimension "0" will be given the same name
   as the variable itself.)

Description

   The function grib_stime2itime converts grib initial_time (string) to time (integer). The return values will be of the
   form YYYYMMDDHH.

See Also

   yyyymmddhh_time

Examples

   No examples are currently available for this function. Check the examples for other time functions such as
   yyyymmddhh_time and cd_calendar.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:18:22 +0800
# vim:set fdm=indent foldlevel=0:
