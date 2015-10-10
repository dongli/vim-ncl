THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/yyyymmddhh_time.shtml
THE_TITLE:yyyymmddhh_time

yyyymmddhh_time

   Creates a one-dimensional array containing year-month-day [yyyymmddhh] values.

   [new.gif] Available in version 6.1.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function yyyymmddhh_time (
                yrStrt [1] : integer,
                yrLast [1] : integer,
                hrStep [1] : integer,
                TYPE       : string
        )

Arguments

   yrStrt

   An integer specifying the initial year. If the attribute "noLeapYear" is associated with yrStrt and it is set to True,
   then February will only have 28 days.
   yrLast

   An integer specifying the last year.
   hrStep

   An integer specifying the hourly increment. This must be evenly divisable into 24. Common hrStep values are 1, 3, 4, 6,
   8, 12, 24.
   TYPE

   A string specifyin the numeric type to be returned ["integer", "float", "double"].

Return value

   A one dimensional array containing values of the form yyyymmddhh. The first value will correspond to January 1 of yrStrt.
   The last value will correspond to December 31 of yrLast. In addition, the attributes "long_name" and "units" will be set,
   and the return value will have a named dimension "time".

Description

   For each year-month-day-hour of each year, the value yyyymmddhh = (yyyy*1000000 + mm*10000 + dd*100 + hh) is returned.
   The 'mm' start at 1 [January] and end at 12 [December]. Leap years will have a 29 February.

See Also

   List of "date" and "calendar" functions

Examples

   The following require that contributed.ncl be loaded prior to invoking the function.
       load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

   Example 1

   Create a one dimensional [1D] array of type intger spanning 1991 through 2012.
      yyyymmddhh = yyyymmddhh_time(1991, 2012, 6, "integer")
      print(yyyymmddhh)

   The above returns a 1D array of length 32144 values.
Variable: time
Type: integer
Total Size: 128576 bytes
            32144 values
Number of Dimensions: 1
Dimensions and sizes:   [time | 32144]
Coordinates:
            time: [1991010100..2012123118]
Number Of Attributes: 2
  long_name :   time
  units :       YYYYMMDDHH
(0)     1991010100
(1)     1991010106
(2)     1991010112
(3)     1991010118
(4)     1991010200
(5)     1991010206
(6)     1991010212
(7)     1991010218
[snip]
(32136) 2012123000
(32137) 2012123006
(32138) 2012123012
(32139) 2012123018
(32140) 2012123100
(32141) 2012123106
(32142) 2012123112
(32143) 2012123118

   Example 2

   Create a yyyymmddhh variable named "time" that spans April 15 1901 at 3Z thru September 21 2001 15Z. Make the yrStrt and
   yrLast span the required years. Then use NCL's Coordinate subscripting to subset the returned 1D array.
      TIME = yyyymmddhh_time(1901, 2001, 3, "integer")
      time = TIME({1901041503:2001092115})    ; coordinate subscripting
      print(time)

   The above returns a 1D array of length 293477 values.
Variable: time
Type: integer
Total Size: 1173908 bytes
            293477 values
Number of Dimensions: 1
Dimensions and sizes:   [time | 293477]
Coordinates:
            time: [1901041503..2001092115]
Number Of Attributes: 2
  units :       YYYYMMDDHH
  long_name :   time
(0)     1901041503
(1)     1901041506
(2)     1901041509
(3)     1901041512
(4)     1901041515
(5)     1901041518
(6)     1901041521
(7)     1901041600
(8)     1901041603
(9)     1901041606
(10)    1901041609
(11)    1901041612
(12)    1901041615
(13)    1901041618
(14)    1901041621
[snip]
(293463)        2001092000
(293464)        2001092003
(293465)        2001092006
(293466)        2001092009
(293467)        2001092012
(293468)        2001092015
(293469)        2001092018
(293470)        2001092021
(293471)        2001092100
(293472)        2001092103
(293473)        2001092106
(293474)        2001092109
(293475)        2001092112
(293476)        2001092115


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:52 +0800
# vim:set fdm=indent foldlevel=0:
