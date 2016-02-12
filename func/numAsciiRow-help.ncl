THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/numAsciiRow.shtml
THE_TITLE:numAsciiRow

numAsciiRow

   Returns the number of rows in an ASCII file.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function numAsciiRow (
                file_name  : string
        )

        return_val [1] :  integer

Arguments

   file_name

   The filename to read (can be a path name).

Description

   This function returns the number of rows in a file.

See Also

   numAsciiCol, readAsciiHead, readAsciiTable, asciiread, asciiwrite, write_matrix

Examples

   Example 1

   Assume you have the file "test.dat":
1 2 3
4 5 6
7 8 9
10 11 12
13 14 15
16 17 18

   Then nrow and ncol will be 6 and 3 respectively:
  nrow = numAsciiRow("test.dat")
  ncol = numAsciiCol("test.dat")


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:19:09 +0800
# vim:set fdm=indent foldlevel=0:
