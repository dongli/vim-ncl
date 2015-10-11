THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/yyyyddd_to_yyyymmdd.shtml
THE_TITLE:yyyyddd_to_yyyymmdd

yyyyddd_to_yyyymmdd

   Given concatenated year and day-of-year (yyyyddd) create a one-dimensional array containing concatenated year, month and
   day-of-month [yyyymmdd] values.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function yyyyddd_to_yyyymmdd (
                yyyyddd [*] : integer
        )

Return value

   A one dimensional array of type integer containing values of the form yyyymmdd (year-month-day_of_month).

Description

   The return integer is constructed via
[ yyyy*10000 + mm*100 + dd ]

See Also

   List of "date" and "calendar" functions

Examples

   The following require that contributed.ncl be loaded prior to invoking the function.
       load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

   Example 1

               ; all have the form 'yyyyddd'
      yearday  = (/ 2003001, 2003032, 2003060 \
                  , 2004061, 2004366          \    ; leap year
                  , 2005060, 2005365/)
      yyyymmdd = yyyyddd_to_yyyymmdd( yearday  )
      print(yearday+"   "+yyyymmdd)

   The above yields:
        yearday
        yyyyddd   yyyymmdd
(0)     2003001   20030101
(1)     2003032   20030201
(2)     2003060   20030301
(3)     2004061   20040301
(4)     2004366   20041231
(5)     2005060   20050301
(6)     2005365   20051231



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:45 +0800
# vim:set fdm=indent foldlevel=0:
