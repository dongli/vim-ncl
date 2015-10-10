THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/write_table.shtml
THE_TITLE:write_table

write_table

   Writes all elements from a list (to a file).

   [new.gif] Available in version 6.1.0 and later.

Prototype

        procedure write_table (
                filename [1] : string,
                option   [1] : string,
                alist    [1] : list,
                format   [1] : string
        )

        return_val [*] :  string

Arguments

   filename

   The file name to output the list.
   option

   The option of writing the file. "w" for (over-)writing; "a" for appending.
   alist

   The input list to write.
   format

   The format for of each (first) element of the list.

Description

   Writes/Overwrites or appends elements to a file.

See Also

   print_table, asciiwrite, write_matrix

Examples

   Example 1

 a = (/111, 222, 333, 444/)
 b = (/1.1, 2.2, 3.3/)
 c = (/"1", "22", "333", "aaaaaa", "bbbb", "cc"/)
 d = (/11h, 22h/)
 f = (/11l, 22l, 33l, 44l, 55l, 66l/)

 alist = [/a, b, c, d, f/]

 header = (/"--------------------------------", \
            "This is a file header", \
            "--------------------------------"/)
 footer = (/"--------------------------------", \
            "This is a file footer", \
            "--------------------------------"/)

 hlist = [/header/]
 flist = [/footer/]

 write_table("list.txt", "w", hlist, "%s")
 write_table("list.txt", "a", alist, "%d%16.2f%s%d%ld")
 write_table("list.txt", "a", flist, "%s")

   Where list.txt contains:

--------------------------------
This is a file header
--------------------------------
111             1.10 1      11 11
222             2.20 22     22 22
333             3.30 333       33
444                  aaaaaa    44
                     bbbb      55
                     cc        66
--------------------------------
This is a file footer
--------------------------------

   Example 2

 a = (/111, 222, 333, 444/)
 b = (/1.1, 2.2, 3.3/)
 c = (/"a", "b", "c"/)
 d = (/11h, 22h/)
 f = (/11l, 22l, 33l, 44l, 55l, 66l/)

 alist = [/a, b, c, d, f/]

 header = (/"--------------------------------", \
            "This is a file header", \
            "--------------------------------"/)
 footer = (/"--------------------------------", \
            "This is a file footer", \
            "--------------------------------"/)

 hlist = [/header/]
 flist = [/footer/]

 write_table("list.txt", "w", hlist, "%s ")
 write_table("list.txt", "a", alist, "%d,%16.2f,%s,%d,%ld")
 write_table("list.txt", "a", flist, "%s ")

   Output will be:

--------------------------------
This is a file header
--------------------------------
111,            1.10,a,11,11
222,            2.20,b,22,22
333,            3.30,c,  ,33
444,                , ,  ,44
   ,                , ,  ,55
   ,                , ,  ,66
--------------------------------
This is a file footer
--------------------------------

   Example 3

 i = ispan(101,105,1)
 j = ispan(201,205,1)

 write_table("file.txt","w",[/i,j/],"first_%05i second_%05i")

   Output will be:

first_00101 second_00201
first_00102 second_00202
first_00103 second_00203
first_00104 second_00204
first_00105 second_00205


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:13 +0800
# vim:set fdm=indent foldlevel=0:
