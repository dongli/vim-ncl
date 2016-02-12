THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/getfilevaratts.shtml
THE_TITLE:getfilevaratts

getfilevaratts

   Returns all attribute names associated with a variable on a supported file.

Prototype

        function getfilevaratts (
                thefile [1] : file,
                varname [1] : string
        )

        return_val [*] :  string

Arguments

   thefile

   The file reference containing the variable. It is created using addfile. Thus, it must be a supported file format.
   varname

   The name of the variable, in single string format.

Return value

   Returns a one-dimensional array of attributes for a file variable. getfilevaratts returns a missing value if no dimension
   names exist or the variable is not defined.

Description

   Accesses attributes of a user-specified variable in a supported file format.

See Also

   getvaratts, isfilevaratt

Examples

   Example
    g       = addfile("foo.nc" ,"r")   ; create file reference
    slpAtts = getfilevaratts(g,"slp")
    print(slpAtts)

Variable: slpAtts
Type: string
Total Size: 56 bytes
            14 values
Number of Dimensions: 1
Dimensions and sizes:   [14]
Coordinates:

(0)     long_name
(1)     valid_range
(2)     actual_range
(3)     units
(4)     add_offset
(5)     scale_factor
(6)     missing_value
(7)     precision
(8)     least_significant_digit
(9)     var_desc
(10)    dataset
(11)    level_desc
(12)    statistic
(13)    parent_stat


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:05:28 +0800
# vim:set fdm=indent foldlevel=0:
