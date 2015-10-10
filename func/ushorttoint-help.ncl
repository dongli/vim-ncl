THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/ushorttoint.shtml
THE_TITLE:ushorttoint

ushorttoint

   Coerces values of type unsigned short to values of type integer.

Prototype

        function ushorttoint (
                short_val  : short
        )

        return_val [dimsizes(short_val)] :  integer

Arguments

   short_val

   A short variable of any dimension. This argument is treated as an "unsigned short". That is, it is in the range 0 to
   65535 on most machines. The type "ushort" is not officially supported in NCL, so be careful to check your results when
   you use this function.

Return value

   Returns integers obtained by treating the input as an unsigned short value.

Description

   This function converts short values to integer values by treating the input short as an "unsigned short," i.e. a short in
   the range 0 to 65535 on most machines. This function performs coercion that is definitely not automatically available
   through the NCL grammar. See the section on coercion of types for details on NCL's automatic type conversions.

See Also

   integertobyte

Examples

   Example 1

   Converts an array of unsigned shorts to integers.

begin
;
;  Create an array of unsigned shorts to convert.
;
  a = (/5H, 3H, 100H, 490H/)
;
;  Convert the unsigned shorts to integers.
;
  b = ushorttoint(a)
  print(b)
end



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:14:13 +0800
# vim:set fdm=indent foldlevel=0:
