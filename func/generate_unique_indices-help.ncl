THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/generate_unique_indices.shtml
THE_TITLE:generate_unique_indices

generate_unique_indices

   Generate unique random indices (subscripts).

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function generate_unique_indices (
                N  : integer or long
        )

Arguments

   N

   The number of unique random subscripts to be generated.

   As of version 6.0.0, this can be of type long.

Return value

   A one dimensional array containing the unique random integer subscripts (indices).

Description

   Uses a random algorithm to generate unique subscripts.

See Also

   generate_2d_array, generate_sample_indices

Examples

   Example 1: Generate 500000 random unique subscripts (indices).
         i = generate_unique_indices( 500000 )


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:18:08 +0800
# vim:set fdm=indent foldlevel=0:
