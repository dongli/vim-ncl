THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/NewList.shtml
THE_TITLE:NewList

NewList

   Create a list (type variable).

   [new.gif] Available in version 6.1.0 and later.

Prototype

        function NewList (
                s [1] : string
        )

        return_val [1] :  list

Arguments

   s

   String of list type (can only be one of "fifo"(First In, First Out) or "lifo" (Last In, First Out)).

Return value

   Returns a variable of type list.

Description

   This function returns a list.

See Also

   ListAppend, ListCount, ListGetType, ListIndex, ListIndexFromName, ListPop, ListPush, ListSetType, NewList

Examples

   Example 1

     my_list = NewList("lifo")

     print(my_list)

   The print procedure yields:
Variable: my_list
Type: list
Total Size: 4 bytes
            1 values
Number of Dimensions: 1
Dimensions and sizes:   [1]
Coordinates:

   Example 2

   This example pushes three different types of NCL variables onto a new list.

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

   Example 3

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
2015-10-03 23:08:18 +0800
# vim:set fdm=indent foldlevel=0:
