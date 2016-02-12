THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/isfilevaratt.shtml
THE_TITLE:isfilevaratt

isfilevaratt

   Checks if specified file variable attributes are defined for a file variable.

Prototype

        function isfilevaratt (
                thefile [1] : file,
                varname [1] : string,
                attnames    : string
        )

        return_val [dimsizes(attnames)] :  logical

Arguments

   thefile

   A reference to a file. This must be created via addfile. This must be a supported file format.
   varname

   A single string variable name.
   attnames

   An array type string of any dimensionality.

Return value

   The output of isfilevaratt is a logical array with the same dimensions as the attnames parameter. If the parameter
   thefile is not a valid file or varname isn't a defined file variable, then a single missing value is returned.

Description

   For each element in the attnames parameter, isfilevaratt returns True if the element is an attribute of the file variable
   varname in the file thefile and False if not.

See Also

   isatt

Examples

   Example 1 Before reading a variable ("TEMP") to memory, check to see if it has specific attributes.
    f = addfile ("foo.nc", "r")

    attNames = (/"long_name", "description", "units", "scale_factor"/)
    tf       = isfilevaratt(f, "TEMP", attNames)    ; ==> tf(4)

    print(tf)   ; each element will be True or False


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:06:25 +0800
# vim:set fdm=indent foldlevel=0:
