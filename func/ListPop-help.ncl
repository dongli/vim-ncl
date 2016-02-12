THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/ListPop.shtml
THE_TITLE:ListPop

ListPop

   Pop (out) an element from a list.

   [new.gif] Available in version 6.1.0 and later.

Prototype

        function ListPop (
                f [1] : list
        )

        return_val [1] :  int

Arguments

   f

   Variable of type list.

Return value

   Returns a variable from the list (this variable will be the last one, if list type is "lifo", or the first one is list is
   "fifo" type).
   NOTE: the list is also changed as is will be one element less.

Description

   This function returns the next variable in the list, which is the first if the list type is "fifo", or the last if the
   list type is "lifo".

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

     a = ListPop(my_list)
     print(a)

     print(my_list)

   The print procedure yields:
Variable: a
Type: string
Total Size: 24 bytes
            3 values
Number of Dimensions: 1
Dimensions and sizes:   [3]
Coordinates:
Number Of Attributes: 1
  attr :        string array
(0)     one
(1)     two
(2)     three

Variable: my_list
Type: list
Total Size: 4 bytes
            1 values
Number of Dimensions: 1
Dimensions and sizes:   [1]
Coordinates:
List Item 0:    NclVarClass
Variable: y
Type: float
Total Size: 16 bytes
            4 values
Number of Dimensions: 1
Dimensions and sizes:   [4]
Coordinates:
Number Of Attributes: 1
  attr :        float array

List Item 1:    NclVarClass
Variable: x
Type: integer
Total Size: 16 bytes
            4 values
Number of Dimensions: 1
Dimensions and sizes:   [4]
Coordinates:
Number Of Attributes: 1
  attr :        integer array


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:07:31 +0800
# vim:set fdm=indent foldlevel=0:
