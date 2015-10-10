THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/decimalPlaces.shtml
THE_TITLE:decimalPlaces

decimalPlaces

   Truncates or rounds to the number of decimal places specified.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function decimalPlaces (
                x           : numeric,
                nplaces [1] : integer,
                round   [1] : logical
        )

        return_val  :  numeric

Arguments

   x

   An array of any dimensionality.
   nplaces

   A scalar integer equal to the number of places to truncate.
   round

   A scalar logical. True = round, False = truncate.

Description

   Note: there is a bug in this function in versions 5.0.0 and earlier that causes it not to work with negative numbers. See
   the known bugs list for a fix.

   Truncates or rounds to the number of decimal places specified.

   Note: If it is for printing or placing with a string for, say, plots, it is better to use the sprintf function.

See Also

   sprintf, sprinti

Examples

   Example 1

     x = 12.345678
     xRound = decimalPlaces(x,2,True)

   ; xRound = 12.35


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:58 +0800
# vim:set fdm=indent foldlevel=0:
