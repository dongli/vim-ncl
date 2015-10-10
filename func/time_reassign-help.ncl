THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/time_reassign.shtml
THE_TITLE:time_reassign

time_reassign

   Reassign (replace) a Cf-conforming "time" variable by calculating the mid-time values using the "bounds" attribute.

   [new.gif] Available in version 6.3.1 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function time_reassign (
                f            ,
                timeName [1] : string
        )

        return_val [dimsizes(timeName)]

Arguments

   f

   A variable of type 'file' or 'list'. The file(s) must be CF-concorming.
   timeName

   A string specifying the name of the time variable on the file(s). Most commonly the name is "time". This must a
   CF-conforming variable with units such as "seconds/minutes/hours/days since ...". It must have a bounds attribute. If not
   the original time will be returned.

Return value

   An array of the same size and type as the variable specified by timeName containing values computed using the variable
   specified

Description

   Some models output a 'time' (timeName) that is not consistent with the date(s) indicated within the file name. Consider a
   model file named (say) FOO.2012-01.nc. This contains monthly averages for January 2012. However, the 'time' variable
   points to February 2012. Specifically,

     f    = addfile("FOO.2012-01.nc","r")     ; 'f' is type 'file'
     time = f->time                           ; "days since 2011-01-01 00:00:00"
     date = cd_calendar(time, 0)             ; (/ 2012,2, 1, 0, 0, 0 /)


   Note that the month is 'off-by-one'. It indicates February 2012 rather than January 2012. The reason is that the model
   accumulates statistcs until the time switches months (here from January to February). Unfortunately, the statistic (eg,
   monthly mean) is 'tagged' with the current model time (February) and not the previous month (January). Actually, the time
   'should be' the center-of-times of the previous month (eg, January 16).

   To address this issue, the CF conforming bounds attribute associated with the specified timeName variable is used to
   access the temporal bounds used to calculate the mean. These boundary times are averaged.

     time = f->time                        ; timeName => "time"
     if (isatt(time,"bounds")) then        ; CF attribute
         tbnd = f->time@bounds             ; (ntim,2)
         time = (tbnd(:,0)+tbnd(:,1))*0.5  ; center of 'time' bounds
     end if
     date = cd_calendar(time, 0)          ; (/ 2012, 1,16,12, 0, 0 /)


   Using the correct times can be particulary important when doing (say) compositing.

See Also

   time_reassign_cv2var, cd_calendar

Examples

   Example 1

   Read one or more times from a file containing monthly means. Create a new time variable containing the center of the
   bounds related variable.

     fil  = "FOO.2012-01.nc"
     f    = addfile(fil,"r")           ; f is type 'file'
     time = time_reassign(f, "time")  ; new time created

   Example 2

   Read time from multiple files containing monthly means. Create a new time variable containing the center of the bounds
   related variable.

     dir  = "./"
     fils = systemfunc("cd "+dir+"     ; ls FOO.*.nc")
     f    = addfiles(dir+fils,"r")      ; f is type 'list'
     time = time_reassign(f, "time")    ; 'new' time created

   Example 3

   This CAM file has monthly means from 1850-01 to 2005-12. Perform two tasks: (a) reassign (replace) the "time" values with
   the temporal monthly time means; (b) reassign (replace) the coordinate variable (cv) associated with the specified
   variable.

     dir    = "./"
     fil    = "b40.20th.track1.2deg.001.cam2.h0.PSL.1850-01_cat_2005-12.nc"
     f      = addfile(dir+fil, "r")

     time   = time_reassign(f, "time")                 ; 'new' time
     printVarSummary(time)

     psl    = time_reassign_cv2var(f, "time", "PSL")   ; 'new' time coordinate variable (cv)
     printVarSummary(psl)

   The (edited) output from the above would be:

     Variable: time
     Type: double
     Dimensions and sizes:      [time | 1872]
     Coordinates:
                 time: [15.5..56924.5]    <=== reassigned    original: time: [  31..56940]
     Number Of Attributes: 5
       bounds : time_bnds
       calendar :       noleap
       units :  days since 1850-01-01 00:00:00
       long_name :      time
       NCL :    function time_reassign used to reassign time to mid-value of bounds


     Variable: psl
     Dimensions and sizes:      [time | 1872] x [lat | 96] x [lon | 144]
     Coordinates:
                 time: [15.5..56924.5]      <=== reassigned    original: time: [  31..56940]
                 lat: [ -90..89.99999999999999]
                 lon: [   0..357.5]
     Number Of Attributes: 4
       cell_methods :   time: mean
       long_name :      Sea level pressure
       units :  Pa
       NCL :    function time_reassign used to reassign time coordinate variable to mid-value of bounds

   If the original and reassigned yyyy/mm/dd/hh were printed, you would readily see the more appropriate dates.

         --ORIGINAL--      --REASSIGNED-
(0)     1850 02 01 00      1850 01 16 12
(1)     1850 03 01 00      1850 02 15 00
(2)     1850 04 01 00      1850 03 16 12
(3)     1850 05 01 00      1850 04 16 00
(4)     1850 06 01 00      1850 05 16 12
(5)     1850 07 01 00      1850 06 16 00
(6)     1850 08 01 00      1850 07 16 12
(7)     1850 09 01 00      1850 08 16 12
(8)     1850 10 01 00      1850 09 16 00
(9)     1850 11 01 00      1850 10 16 12
(10)    1850 12 01 00      1850 11 16 00
(11)    1851 01 01 00      1850 12 16 12
(12)    1851 02 01 00      1851 01 16 12
[SNIP]
(1857)  2004 11 01 00      2004 10 16 12
(1858)  2004 12 01 00      2004 11 16 00
(1859)  2005 01 01 00      2004 12 16 12
(1860)  2005 02 01 00      2005 01 16 12
(1861)  2005 03 01 00      2005 02 15 00
(1862)  2005 04 01 00      2005 03 16 12
(1863)  2005 05 01 00      2005 04 16 00
(1864)  2005 06 01 00      2005 05 16 12
(1865)  2005 07 01 00      2005 06 16 00
(1866)  2005 08 01 00      2005 07 16 12
(1867)  2005 09 01 00      2005 08 16 12
(1868)  2005 10 01 00      2005 09 16 00
(1869)  2005 11 01 00      2005 10 16 12
(1870)  2005 12 01 00      2005 11 16 00
(1871)  2006 01 01 00      2005 12 16 12


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:18 +0800
# vim:set fdm=indent foldlevel=0:
