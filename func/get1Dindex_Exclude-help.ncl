THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/get1Dindex_Exclude.shtml
THE_TITLE:get1Dindex_Exclude

get1Dindex_Exclude

   Returns a one dimensional array of subscript indices that DO NOT match the values contained in a user specified list.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function get1Dindex_Exclude (
                x             [*] : numeric,
                exclude_value [*] : numeric
        )

        return_val  :  integer or long

Arguments

   x

   A one-dimensional array.
   exclude_value

   A scalar value or integer one-dimensional array of the same type as x. Must exist in x.

Return value

   A one-dimensional array containing index subscripts excluding those specified by exclude_value.

Description

   Finds the indices in a one-dimensional array which do not match a user specified list of values. The values must exist in
   the array to be checked.

Examples

   Example 1

   Find the subscript indices which do not correspond to years specified by the user.
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
       ;
       ;
  year      = ispan(1985,2006,1)

  year_exc  = (/1985, 1989, 1999, 2005, 2006/)
  i         = get1Dindex_Exclude(year,year_exc)

  print(i)

   The output would be:

Variable: i
Type: integer
Total Size: 68 bytes
            17 values
Number of Dimensions: 1
Dimensions and sizes:   [17]
Coordinates:
                                       no 0
(0)     1
(1)     2
(2)     3
                                       no 4
(3)     5
(4)     6
(5)     7
(6)     8
(7)     9
(8)     10
(9)     11
(10)    12
(11)    13
                                      no 14
(12)    15
(13)    16
(14)    17
(15)    18
(16)    19
                                      no 20
                                      no 21


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:18:13 +0800
# vim:set fdm=indent foldlevel=0:
