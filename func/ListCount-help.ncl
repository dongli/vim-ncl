THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/ListCount.shtml
THE_TITLE:ListCount

ListCount

   Queries the number of element(s) in a list.

   [new.gif] Available in version 6.1.0 and later.

Prototype

        function ListCount (
                f [1] : list
        )

        return_val [1] :  int

Arguments

   f

   Variable of type list.

Return value

   Returns a variable of type int.

Description

   This function returns the number of element(s) in a list.

See Also

   ListAppend, ListCount, ListGetType, ListIndex, ListIndexFromName, ListPop, ListPush, ListSetType, NewList

Examples

   Example 1

   x = 1234 ; a integer
   y = 5.67 ; a float
   z = "ab" ; a string
   lst  = [/x, y, z/]    ; note use of square brackets, NOT round brackets.

   n = ListCount (lst)
   print(n)

   The print procedure yields:
Variable: n
Type: integer
Total Size: 4 bytes
            1 values
Number of Dimensions: 1
Dimensions and sizes:   [1]
Coordinates:
(0)     3

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
2015-10-03 23:07:27 +0800
# vim:set fdm=indent foldlevel=0:
