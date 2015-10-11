THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/nameDim.shtml
THE_TITLE:nameDim

nameDim

   Assigns given named dimensions, long_name, and units to the input variable.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function nameDim (
                x            ,
                dimNames [*] : string,
                longName     : string,
                units        : string
        )

        return_val [dimsizes(x)] :  typeof(x)

Arguments

   x

   Array to assign dimensions and attributes to.
   dimNames

   An array of dimension names to assign to x. It must be the same length as the rank of x.
   longName

   A single string to assign to the "long_name" attribute.
   units

   A single string to assign to the "units" attribute.

Return value

   The input array x is returned with the attached dimensions and attributes.

Description

   This function assigns the given named dimensions, long_name, and units to the input variable.

See Also

   There are many metadata routines available.

Examples

   There are no examples currently available for this function. Check the other metadata routine pages for similar examples.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:19:02 +0800
# vim:set fdm=indent foldlevel=0:
