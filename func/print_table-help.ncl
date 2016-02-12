THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/print_table.shtml
THE_TITLE:print_table

print_table

   Prints all elements from a list (to stdout).

   [new.gif] Available in version 6.1.0 and later.

Prototype

        procedure print_table (
                alist  [1] : list,
                format [1] : string
        )

        return_val [*] :  string

Arguments

   alist

   The input list to print.
   format

   The format for of the (first) element of the list.

Description

   This procedure prints all the elements from the list to stdout.

See Also

   write_table, asciiwrite, write_matrix

Examples

   Example 1

 a = (/111, 222, 333, 444/)
 b = (/1.1, 2.2, 3.3/)
 c = (/"a", "b", "c"/)
 d = (/11h, 22h/)
 f = (/11l, 22l, 33l, 44l, 55l, 66l/)

 alist = [/a, b, c, d, f/]

 print_table(alist, "%d,%16.2f,%s,%d,%ld")

   Output will be:

111,            1.10,a,11,11
222,            2.20,b,22,22
333,            3.30,c,  ,33
444,                , ,  ,44
   ,                , ,  ,55
   ,                , ,  ,66

   Example 2

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

 print_table(hlist, "%s")
 print_table(alist, "%d%16.2f%s%d%ld")
 print_table(flist, "%s")

   Output will be:

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

   Example 3

 i = ispan(1,5,1)
 j = ispan(1000,5000,1000)
 print_table([/i,j/],"low_%05i high_%05i")

   Output will be:

low_00001 high_01000
low_00002 high_02000
low_00003 high_03000
low_00004 high_04000
low_00005 high_05000


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:10:03 +0800
# vim:set fdm=indent foldlevel=0:
