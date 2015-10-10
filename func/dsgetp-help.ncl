THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/dsgetp.shtml
THE_TITLE:dsgetp

dsgetp

   Gets parameters for Dsgrid routines.

Prototype

        function dsgetp (
                pnam [1] : string
        )

        return_val [1] :  numeric

Arguments

   pnam

   The name of the parameter you want to retrieve.

Return value

   Returns a numeric type according to the parameters for Dsgrid routines.

Description

   This procedure retrieves values for parameters for Dsgrid routines.

   The NCL language affords a convenient implementation of the parameter setting and retrieval functions.

See Also

   dssetp

Examples

   Example 1

begin
  gexp = dsgetp("exp")
  print(gexp)
end

Variable: gexp
Type: float
Total Size: 4 bytes
            1 values
Number of Dimensions: 1
Dimensions and sizes:   [1]
Coordinates:
(0)     0.5



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:02:36 +0800
# vim:set fdm=indent foldlevel=0:
