THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/ListPush.shtml
THE_TITLE:ListPush

ListPush

   Push a variable into the list.

   [new.gif] Available in version 6.1.0 and later.

Prototype

        procedure ListPush (
                f [1] : list,
                v [1] : variable
        )

        return_val [1] :  int

Arguments

   f

   Variable of type list.
   v

   Variable of an element (to be pushed into the list).

Description

   This procedure pushes one variable into the list. The last variable pushed into list will always be at the beginning of
   the list.

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

     print(my_list)

   The print procedure yields:
Variable: my_list
Type: list
Total Size: 4 bytes
            1 values
Number of Dimensions: 1
Dimensions and sizes:   [1]
Coordinates:
List Item 0:    NclVarClass
Variable: s
Type: string
Total Size: 24 bytes
            3 values
Number of Dimensions: 1
Dimensions and sizes:   [3]
Coordinates:
Number Of Attributes: 1
  attr :        string array

List Item 1:    NclVarClass
Variable: y
Type: float
Total Size: 16 bytes
            4 values
Number of Dimensions: 1
Dimensions and sizes:   [4]
Coordinates:
Number Of Attributes: 1
  attr :        float array

List Item 2:    NclVarClass
Variable: x
Type: integer
Total Size: 16 bytes
            4 values
Number of Dimensions: 1
Dimensions and sizes:   [4]
Coordinates:
Number Of Attributes: 1
  attr :        integer array

   Example 2

   This example opens a NetCDF file, reads each variable and pushes it onto a list, and then prints information about each
   variable on the list.

;---Open file and read variable names
  a        = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/uv300.nc","r")
  varnames = getfilevarnames(a)
  nvars    = dimsizes(varnames)

  my_list = NewList("fifo")       ; Create a new list.
  do nv=0,nvars-1
    print("-------------------------------------------------------")
    print("Pushing variable '" + varnames(nv) + "' onto list...")

    ListPush(my_list,a->$varnames(nv)$)  ; Push variable onto list.

    print("ListCount currently is " + ListCount(my_list))
  end do

  lcount = ListCount(my_list)   ; Get total list count
  print("======================================================================")
  print("There are " + lcount + " items in the list (there should be " + nvars + ").")
  print("======================================================================")

;---Print information about each variable on the list
  print("")
  do lc=0,lcount-1
    print("--------------------List element " + lc + "----------------------")
    printVarSummary(my_list[lc])
    if(isnumeric(my_list[lc])) then
      printMinMax(my_list[lc],0)
    end if
  end do


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:07:32 +0800
# vim:set fdm=indent foldlevel=0:
