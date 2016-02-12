THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/cdfnor_x.shtml
THE_TITLE:cdfnor_x

cdfnor_x

   Calculates the upper limit of integration of a cumulative normal distribution function.

Prototype

        function cdfnor_x (
                p     : numeric,
                mean  : numeric,
                sd    : numeric
        )

        return_val  :  numeric

Arguments

   p

   A multi-dimensional array or scalar value equal to the integral of the distribution from -infinity to return_val.(0,1)
   mean

   A multi-dimensional array or scalar value equal to the mean of the distribution (-infinity to +infinity).
   sd

   A multi-dimensional array or scalar value equal to the standard deviation of the distribution (0 to +infinity).

Return value

   A array of the same size as p. Double if any of the input arguments are double, float otherwise.

Description

   Calculates the upper limit of integration of a cumulative normal distribution function.

   The source code is from source routine "CDFNOR" from DCDFLIB (Double precision Cumulative Distribution Function LIBrary)

See Also

   cdfnor_p

Examples

   Example 1

     p     = 0.95
     mean  = 0.0
     sd    = 1.0

     x = cdfnor_x(p,mean,sd)
     print("x="+x)                ; x = 1.64485


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 22:59:48 +0800
# vim:set fdm=indent foldlevel=0:
