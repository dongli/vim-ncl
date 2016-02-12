THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/ListIndex.shtml
THE_TITLE:ListIndex

ListIndex

   Queries the index of a variable in a list.

   [new.gif] Available in version 6.1.0 and later.

Prototype

        function ListIndex (
                f [1] : list,
                v [1] : variable
        )

        return_val [1] :  int

Arguments

   f

   Variable of type list.
   v

   Variable of an element in the list.

Return value

   Returns a variable of type int.

Description

   This function returns the index of this variable in the list (or -1, if this variable is not in the list).

See Also

   ListAppend, ListCount, ListGetType, ListIndex, ListIndexFromName, ListPop, ListPush, ListSetType, NewList

Examples

   Example 1

     x = (/1,2,3,4/)
     x@attr = "integer array"
     y = (/6.,7.,8.,9./)
     y@attr = "float array"
     s = (/"one","two","three"/)
     s@attr = "string array"

     my_list = NewList("lifo")

     ListPush(my_list,x)
     ListPush(my_list,y)
     ListPush(my_list,s)

     cnt = ListCount(my_list)
     print(cnt)

     idx = ListIndex(my_list, x)
     print(idx)

   The print procedure yields:
Variable: cnt
Type: integer
Total Size: 4 bytes
            1 values
Number of Dimensions: 1
Dimensions and sizes:   [1]
Coordinates:
(0)     3


Variable: idx
Type: integer
Total Size: 4 bytes
            1 values
Number of Dimensions: 1
Dimensions and sizes:   [1]
Coordinates:
(0)     2


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:07:29 +0800
# vim:set fdm=indent foldlevel=0:
