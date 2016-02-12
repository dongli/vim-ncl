THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/touint.shtml
THE_TITLE:touint

touint

   Converts values of any snumeric data type or string to values of type unsigned integer.

   [new.gif] Available in version 5.2.0 and later.

Prototype

        function touint (
                input_val  : snumeric data type or string
        )

        return_val [dimsizes(input_val)] :  unsigned integer

Arguments

   input_val

   A variable of any snumeric data type or string of any dimension.

Return value

   Returns unsigned integers. If the input variable is float or double, then any fractional part of the input values is
   truncated. The dimensionality of the output matches that of the input.

   Any input value that is out of range for an unsigned integer will be returned as a missing value.

Description

   This function converts any snumeric data or string to unsigned integer values. If the input is float or double, then the
   fractional part is truncated.

   Any input value that is out of range for an unsigned integer will be returned as a missing value.

   Attributes, with the exception of _FillValue, are not propagated by the conversion functions.

   Special considerations apply to how missing values and out-of-range values are handled in the conversion functions. For
   this function an out-of-range value could be valid in its original type, but not in the valid range of an unsigned
   integer. An out-of-range value is converted to a missing value, but what that missing value is depends on the
   circumstances of the particular conversion being performed. For example, determination has to be made whether a missing
   value for a variable to be converted is in the range of the type of the target variable.

See Also

   tochar, tobyte, toshort, toushort, toint, tolong, toulong, toint64, touint64, tostring, totype

Examples

   Example

 a = 3464H
 b = 1431H
 c = a - b
 d = a + b
 e = a * b
 f = e / c
 g = (/a, b, c, d/)

 print(a)
 print(b)
 print(c)
 print(d)
 print(e)
 print(f)
 print(g)

 h = abs(a)
 print(h)

 i = min(g)
 print(i)

 j = max(g)
 print(j)

 short_array = new((/2,2/), short)
 short_array = 215h
 print(short_array)
 short2uint = touint(short_array)
 print(short2uint)

 ushort_array = new((/2,2/), ushort)
 ushort_array = 8924H
 print(ushort_array)
 ushort2uint = touint(ushort_array)
 print(ushort2uint)

 int_array = new((/2,2/), integer)
 int_array = 2147483640
 print(int_array)
 int2uint = touint(int_array)
 print(int2uint)

 uint_array = new((/2,2/), uint)
 uint_array = 2147483649I
 print(uint_array)
 uint2uint = touint(uint_array)
 print(uint2uint)

 long_array = new((/2,2/), long)
 long_array = 2147483641l
 print(long_array)
 long2uint = touint(long_array)
 print(long2uint)

 ulong_array = new((/2,2/), ulong)
 ulong_array = 2147483649L
 print(ulong_array)
 ulong2uint = touint(ulong_array)
 print(ulong2uint)

 int64_array = new((/2,2/), int64)
 int64_array = 9223372028264841214q
 print(int64_array)
 int642uint = touint(int64_array)
 print(int642uint)

 uint64_array = new((/2,2/), uint64)
 uint64_array = 9223372028264841219Q
 print(uint64_array)
 uint642uint = touint(uint64_array)
 print(uint642uint)

 str_array = new((/2,2/), string, "997452379")
 str_array = "123456"
 print(str_array)
 str2uint = touint(str_array)
 print(str2uint)

 float_array = new((/2,2/), float)
 float_array = 1.2384
 print(float_array)
 float2uint = touint(float_array)
 print(float2uint)

 double_array = new((/2,2/), double)
 double_array = 1238278456.02394
 print(double_array)
 double2uint = touint(double_array)
 print(double2uint)



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:13:55 +0800
# vim:set fdm=indent foldlevel=0:
