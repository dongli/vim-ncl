THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/wallClockElapseTime.shtml
THE_TITLE:wallClockElapseTime

wallClockElapseTime

   Calculates and prints elapsed 'wall clock' time.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        procedure wallClockElapseTime (
                date   : string,
                title  : string,
                opt    : integer
        )

Arguments

   date

   The current date, for example:

date = systemfunc("date")

   The required format is:

Sun Aug 24 17:32:09 MDT 2014

   title

   A string that will become part of the output description.
   opt

   An integer, currently not used.

Description

   This procedure calculates and prints the elapsed 'wall clock' time in seconds. It will not handle the case where the year
   or month changes.

   In order for this procedure to work, the "date" string passed must be in the format:

Sun Aug 24 17:32:09 MDT 2014

   If "date" on your UNIX system doesn't return this format, then you can format it with:

    dq       = str_get_dq()
    date_cmd = "date +" + dq + "%a %b %d %H:%M:%S %Z %Y" + dq
    date     = systemfunc(date_cmd)

   Note: The Unix/Linux time can be used to time a script. It is invoked from the command line.
     %>  time ncl foo.ncl

   This is best done when the system is not being used by other users.

See Also

   get_cpu_time

Examples

   Example 1

   The following prints wall clock time for different code sections and the overall time. Using different "start times"
   allows different code sections to be timed. These are italicized for emphasis.
     wcStrt     = systemfunc("date")

     wcStrtClmP = systemfunc("date")
;                   :    ; one or more statements [usually a block of code]
     wallClockElapseTime(wcStrtClmP, "Processing", 0)

                    :

     wcStrtGraphics = systemfunc("date")
;                   :    ; graphics code
     wallClockElapseTime(wcStrtGraphics, "Graphics", 0)


     wallClockElapseTime(wcStrt, "Processing and Graphics", 0)


   The printed output will look like:

=====> Wall Clock Elapsed Time: Processing: 137 seconds <=====

=====> Wall Clock Elapsed Time: Graphics: 19 seconds <=====

=====> Wall Clock Elapsed Time: Processing and Graphics: 156 seconds <=====

   Example 2

   If your system doesn't return a date in the format of:
    Sun Aug 24 17:32:09 MDT 2014

   then the above code might look like this:

     dq         = str_get_dq()
     date_cmd   = "date +" + dq + "%a %b %d %H:%M:%S %Z %Y" + dq

     wcStrt     = systemfunc(date_cmd)

     wcStrtClmP = systemfunc(date_cmd)
;                   :    ; one or more statements [usually a block of code]
     wallClockElapseTime(wcStrtClmP, "Processing", 0)

                    :

     wcStrtGraphics = systemfunc(date_cmd)
;                   :    ; graphics code
     wallClockElapseTime(wcStrtGraphics, "Graphics", 0)


     wallClockElapseTime(wcStrt, "Processing and Graphics", 0)



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:33 +0800
# vim:set fdm=indent foldlevel=0:
