THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/totype.shtml
THE_TITLE:totype

totype

   Converts values of any snumeric data type or string to values of the given type.

   [new.gif] Available in version 6.1.1 and later.

Prototype

        function totype (
                input_val    ,
                type_val [1] : string
        )

        return_val [dimsizes(input_val)] :  same as required by type_val.

Arguments

   input_val

   A variable of any snumeric data type or string of any dimensionality.
   type_val

   A scalar string representing the type user wants to convert to. It has to be NCL type strings, such as: "integer",
   "float", "double", etc.

Return value

   A variable of type type_val is returned, with the same dimensionality as input_val.

   If the input variable has bits longer than the output, then there may be some precision lost. (For example, converting
   from a double to an integer.)

   Any input value that is out-of-range of the required type will be returned as a missing value.

Description

   This function converts any snumeric data or string to values indicated by the user. If the input is out the range of
   required type, there may be some precision lost.

   Any input value that is out-of-range of required type will be returned as a missing value.

   Attributes, with the exception of _FillValue, are not propagated by the conversion functions.

   Special considerations apply to how missing values and out-of-range values are handled in the conversion functions. For
   this function an out-of-range value could be valid in its original type, but not in the valid range of the required type.

   An out-of-range value is converted to a missing value, but what that missing value is depends on the circumstances of the
   particular conversion being performed. For example, a determination has to be made whether a missing value for a variable
   to be converted is in the range of the type of the target variable.

See Also

   tochar, tobyte, toshort, toushort, toint, touint, tolong, toulong, toint64, touint64, tofloat todouble, tostring

Examples

   Example 1

 i = 12
 f = totype(i, "float")
 print(f)

   Output:
Variable: f
Type: float
Total Size: 4 bytes
            1 values
Number of Dimensions: 1
Dimensions and sizes:   [1]
Coordinates:
(0)     12

   Example 2

   Note the truncation that takes place when you convert from a double to an integer. Also see what happens to the missing
   value.

;---Create array of doubles
 d = fspan(-10.8d,20.2d,10)

;---Set one of them to the default missing value for a double
 d@_FillValue = default_fillvalue("double")
 d(0)         = d@_FillValue
 print(d)

;--See what happens to the missing value when converted to an integer
 i =  totype(d, "integer")
 print(i)

   Output, note the warning message:

Variable: d
Type: double
Total Size: 80 bytes
            10 values
Number of Dimensions: 1
Dimensions and sizes:   [10]
Coordinates:
Number Of Attributes: 1
  _FillValue :  9.969209968386869e+36
(0)     9.969209968386869e+36
(1)     -7.355555555555556
(2)     -3.911111111111111
(3)     -0.4666666666666668
(4)     2.977777777777778
(5)     6.422222222222221
(6)     9.866666666666667
(7)     13.31111111111111
(8)     16.75555555555556
(9)     20.2

warning:toint: there are 1 doubles larger than INT_MAX, which has been flagged missing.

Variable: i
Type: integer
Total Size: 40 bytes
            10 values
Number of Dimensions: 1
Dimensions and sizes:   [10]
Coordinates:
Number Of Attributes: 1
  _FillValue :  -2147483647
(0)     -2147483647
(1)     -7
(2)     -3
(3)     0
(4)     2
(5)     6
(6)     9
(7)     13
(8)     16
(9)     20


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:13:52 +0800
# vim:set fdm=indent foldlevel=0:
