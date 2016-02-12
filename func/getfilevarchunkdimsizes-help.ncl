THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/getfilevarchunkdimsizes.shtml
THE_TITLE:getfilevarchunkdimsizes

getfilevarchunkdimsizes

   Returns the chunk dimension sizes of variable on a file (which has chunk dimensions).

Prototype

        function getfilevarchunkdimsizes (
                thefile [1] : file,
                varname [1] : string
        )

        return_val [*] :  long

Arguments

   thefile

   A reference to a file. It is created using addfile or addfiles. Thus, it must be a supported file format.
   varname

   The string name of the variable whose chunk dimension sizes are desired.

Return value

   Returns a one-dimensional array of chunk dimension sizes for a file variable.

Description

   The getfilevarchunkdimsizes function should be used exclusively when querying the dimensionality of variables in files.

See Also

   dimsizes, filevardimsizes, isfilevardim

Examples

   Example 1 Consider a netCDF file where "ncl_filedump nc4uvt.nc" yields:
Variable: f
Type: file
filename:       nc4uvt
path:   nc4uvt.nc
Number of Attributes:3
    Conventions :       None
    source_file :       nc4uvt.nc
    title       :       NCL generated netCDF file

dimensions:
    time        = 1 // unlimited
    lev = 14
    lat = 64
    lon = 128

chunk dimensions:
    time        = 1 // unlimited
    lev = 7
    lat = 32
    lon = 64

variables:
......

  a    = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/nc4uvt.nc","r")
  dimt = getfilevarchunkdimsizes(a,"t")
  print(dimt)

   This produces the following output:
Variable: dimt
Type: long
Total Size: 32 bytes
            4 values
Number of Dimensions: 1
Dimensions and sizes:   [4]
Coordinates:
(0)     1
(1)     7
(2)     32
(3)     64


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:05:29 +0800
# vim:set fdm=indent foldlevel=0:
