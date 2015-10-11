THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/ListIndexFromName.shtml
THE_TITLE:ListIndexFromName

ListIndexFromName

   Returns the index of a variable in a list given its name.

   [new.gif] Available in version 6.3.0 and later.

Prototype

        function ListIndexFromName (
                f  [1] : list,
                vn [1] : string
        )

        return_val [1] :  integer

Arguments

   f

   Variable of type list.
   vn

   The name of the variable that's an element in the list.

Description

   This function returns the index into a list variable of the given variable.

   If the variable is not in the list, then -1 is returned.

See Also

   ListAppend, ListCount, ListGetType, ListIndex, ListIndexFromName, ListPop, ListPush, ListSetType, NewList

Examples

   Example 1

undef("list_test")
function list_test(a:logical)
local k, x, y, x, retlist
begin
   if(a)
      x = fspan(0,10, 11)
      y = fspan(100,120,11)     ; an array of random numbers
      z = ispan(0,100,1)
      retlist = [/ x, y, z /]
   else
      k = ispan(10,15, 1)
      x = fspan(10,20, 11)
      y = fspan(200,220,11)
      retlist = [/ k, x, y /]
   end if

   return(retlist)
end

 firstlist = list_test(True)
;print(firstlist)

 xind = ListIndexFromName(firstlist, "x")
 print("firstlist x idx = " + xind)

 secondlist = list_test(False)
;print(secondlist)

 xind := ListIndexFromName(secondlist, "x")
 print("secondlist x idx = " + xind)

 a = "a"
 b = 2.0
 c = False

 thirdlist = [/a, b, c/]
 xind := ListIndexFromName(thirdlist, "x")
 print("thirdlist x idx = " + xind)

   The print statement yields:

        (0)     firstlist x idx = 0
        (0)     secondlist x idx = 1
        (0)     thirdlist x idx = -1


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:07:30 +0800
# vim:set fdm=indent foldlevel=0:
