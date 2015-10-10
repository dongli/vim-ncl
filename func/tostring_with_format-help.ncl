THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/tostring_with_format.shtml
THE_TITLE:tostring_with_format

tostring_with_format

   Converts values of any snumeric data type to values of type string, with specified format.

   [new.gif] Available in version 5.2.0 and later.

Prototype

        function tostring_with_format (
                input_val , : snumeric data type,
                format      : format string
        )

        return_val [dimsizes(input_val)] :  string

Arguments

   input_val

   A variable of any snumeric data type of any dimension.
   format

   A variable of type string that describes the format of the output.

Return value

   Returns strings. The dimensionality of the output matches that of the input.

Description

   This function converts any snumeric data to string values, with a string to specify the format of the output string.

   Attributes, with the exception of _FillValue, are not propagated by the conversion functions.

See Also

   tochar, tobyte, toshort, toushort, toint, touint, tolong, toulong, toint64, touint64, tostring, totype

Examples

   Example

 short_array = new((/2,2/), short)
 short_array = 215h
 print(short_array)
 short2string = tostring_with_format(short_array, "%4.4d")
 print(short2string)

 ushort_array = new((/2,2/), ushort)
 ushort_array = 8924H
 print(ushort_array)
 ushort2string = tostring_with_format(ushort_array, "%6.6u")
 print(ushort2string)

 int_array = new((/2,2/), integer)
 int_array = 2147483640
 print(int_array)
 int2string = tostring_with_format(int_array, "%12.12d")
 print(int2string)

 uint_array = new((/2,2/), uint)
 uint_array = 2147483649I
 print(uint_array)
 uint2string = tostring_with_format(uint_array, "%10.10u")
 print(uint2string)

 long_array = new((/2,2/), long)
 long_array = 2147483641l
 print(long_array)
 long2string = tostring_with_format(long_array, "%16.16l")
 print(long2string)

 ulong_array = new((/2,2/), ulong)
 ulong_array = 2147483649L
 print(ulong_array)
 ulong2string = tostring_with_format(ulong_array, "%16.16ul")
 print(ulong2string)

 int64_array = new((/2,2/), int64)
 int64_array = 9223372028264841214q
 print(int64_array)
 int642string = tostring_with_format(int64_array, "%16.16ll")
 print(int642string)

 uint64_array = new((/2,2/), uint64)
 uint64_array = 9223372028264841219Q
 print(uint64_array)
 uint642string = tostring_with_format(uint64_array, "%16.16ull")
 print(uint642string)

 float_array = new((/2,2/), float)
 float_array = 1.2384
 print(float_array)
 float2string = tostring_with_format(float_array, "%12.5f")
 print(float2string)


 double_array = new((/2,2/), double)

 double_array = 12.94
 print(double_array)
 double2string = tostring_with_format(double_array, "%12.5g")
 print(double2string)

 double_array = 1238278456.02394
 print(double_array)
 double2string = tostring_with_format(double_array, "%12.2f")
 print(double2string)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:13:51 +0800
# vim:set fdm=indent foldlevel=0:
