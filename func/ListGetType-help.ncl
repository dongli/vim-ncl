THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/ListGetType.shtml
THE_TITLE:ListGetType

ListGetType

   Queries the manner in which a variable of type list was created.

Prototype

        function ListGetType (
                f [1] : list
        )

        return_val [2] :  string

Arguments

   f

   Variable of type list as created by the addfiles function.

Return value

   Returns a variable of length 2 and of type string.

Description

   The first element specifies "join" or "cat". The second element specifies "fifo" (first-in/first-out, the default) or
   "lifo" (last-in/first-out) which describes manner in which the files are accessed.

See Also

   ListAppend, ListCount, ListGetType, ListIndex, ListIndexFromName, ListPop, ListPush, ListSetType, NewList

Examples

   Example 1

   Let "fils" be a one-dimensional array of strings containing the full or relative path of the data files to be referenced.
   The file(s) pointed to by the file_path string must be a supported file format.
   f    = addfiles (fils, "r")

   ListSetType (f, "cat")     ; concatenate (=default)
      .
      .
      .
   strList = ListGetType (f)
   print(strList)

   The print procedure yields:
Variable: strList
Type: string
Total Size: 16 bytes
            2 values
Number of Dimensions: 1
Dimensions and sizes:   [2]
Coordinates:
(0)     cat
(1)     fifo


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:07:28 +0800
# vim:set fdm=indent foldlevel=0:
