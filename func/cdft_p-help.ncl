THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/cdft_p.shtml
THE_TITLE:cdft_p

cdft_p

   Calculates the one-sided probability given a t-value and the degrees of freedom.

Prototype

        function cdft_p (
                t   : numeric,
                df  : numeric
        )

        return_val  :  numeric

Arguments

   t

   A scalar or array containing t-values.
   df

   A scalar or array of the same size as t containing the number of degrees of freedom.

Return value

   A array of the same size as t. Double if any of the input arguments are double, float otherwise.

Description

   Using the cumulative distribution function for the T distribution, calculate the one-sided probability associated with
   one or more t-values and degrees of freedom. Technically, this is the integral from -infinity to t of the t-density
   distribution.

   The source code is from source routine "CDFT" from DCDFLIB (Double precision Cumulative Distribution Function LIBrary).

See Also

   cdft_t, betainc

Examples

   Example 1

     t  = 2.12
     df = 16

     P = cdft_p(-t, df)   ; P = 0.025
     P = cdft_p( t, df)   ; P = 0.975

   Note: the following could be used to calculate the two-sided significance given t and df:
     prob = betainc( df/(df+t^2), df/2.0, 0.5)    ; prob=0.05   [PROB=1-prob=0.95]


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 22:59:49 +0800
# vim:set fdm=indent foldlevel=0:
