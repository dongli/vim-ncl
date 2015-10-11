THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/isfilevardim.shtml
THE_TITLE:isfilevardim

isfilevardim

   Checks if file variable dimensions are defined for a file variable.

Prototype

        function isfilevardim (
                thefile [1] : file,
                varname [1] : string,
                dimnames    : string
        )

        return_val [dimsizes(dimnames)] :  logical

Arguments

   thefile

   A reference to a file created using addfile. Thus, it must be a supported file format.
   varname

   A single string variable name.
   dimnames

   An array of any dimensionality containing strings.

Return value

   The output of isfilevardim is a logical array with the same dimensions as the dimnames parameter.

Description

   For each element in the dimnames parameter, isfilevardim returns True if the element is a dimension of the file variable
   varname in the file thefile and False if not. If the parameter thefile is not a valid file or varname isn't a defined
   file variable, then a single missing value is returned.

See Also

   getfilevardims, getvardims

Examples

   Example 1

   Check to see if the variable "TEMP" has dimension names time, level, lev, latitude, lat, longitude, lon associated with
   it.

    f        = addfile ("foo.nc" , "r")     ; create a file reference
                                            ; list of dimension names
    dimNames = (/"time","level","lev","latitude","lat","longitude","lon"/)

    tf       = isfilevardim(f, "TEMP", dimNames)    ; ==> tf(7)

    print(tf)   ; each element will be True or False


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:06:27 +0800
# vim:set fdm=indent foldlevel=0:
