THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/getFillValue.shtml
THE_TITLE:getFillValue

getFillValue

   Retrieves the _FillValue of a variable, if present, for use in a new statement.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function getFillValue (
                x  : numeric
        )

Arguments

   x

   A numeric array of any dimensionality.

Description

   This function is only intended to be used within the new statement. It returns three possible values:

     * x@_FillValue, if x@_FillValue is present
     * x@missing_value, if x@_FillValue is not present and x@missing_value is
     * "No_FillValue" if neither x@_FillValue or x@missing_value are present

   The string "No_FillValue" has a special meaning for the new statement, and that is that no _FillValue attribute should be
   set.

   Note: this function cannot not be used in the following manner:

  q@_FillValue = getFillValue(w)

   because if the variable "w" has no _FillValue associated with it, then you will be effectively trying to set q@_FillValue
   = "No_FillValue", which will cause a fatal error if "q" is a numeric variable.

   Important backwards-incompatibility change

   Prior to version 4.3.0, if a variable did not have a _FillValue or missing_value attribute set, then this function would
   return the default _FillValue for the given type instead of "No_FillValue". In some cases this result was not desired, so
   this function was updated in NCL V4.3.0 to instead return the string "No_FillValue".

See Also

   There are many metadata tools for dealing with missing values.

Examples

   Example 1

   Assume xf is a float array with a _FillValue of 1e20. The following code:
     q = new( 10, float, getFillValue(xf))
     printVarSummary(q)

   will produce the following output:

Variable: q
Type: float
Total Size: 40 bytes
            10 values
Number of Dimensions: 1
Dimensions and sizes:[10]
Coordinates:
Number Of Attributes: 1
_FillValue :1e+20

   Example 2

   Assume xd is a double array with a missing_value of 9.969209968386869e+36. The following code:

     qd = new( (/10,20/), double, getFillValue(xd))
     printVarSummary(qd)

   will produce the following output:

Variable: qd
Type: double
Total Size: 1600 bytes
            200 values
Number of Dimensions: 2
Dimensions and sizes:[10] x [20]
Coordinates:
Number Of Attributes: 1
_FillValue :9.969209968386869e+36

   Example 3

   Assume xi is an integer array with no metadata whatsoever. The following code:

     qi = new( (/10,20/), integer, getFillValue(xi))
     printVarSummary(qi)

   will produce the following output:

Variable: qi
Type: integer
Total Size: 800 bytes
            200 values
Number of Dimensions: 2
Dimensions and sizes:[10] x [20]
Coordinates:


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:18:18 +0800
# vim:set fdm=indent foldlevel=0:
