THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/NhlSetDashPattern.shtml
THE_TITLE:NhlSetDashPattern

NhlSetDashPattern

   Sets the dash patterns for a given list of dash pattern indexes and workstations.

Prototype

        function NhlSetDashPattern (
                wks           [*] : graphic,
                dash_indexes  [*] : integer,
                dash_patterns [*] : string
        )

Arguments

   wks

   An array of NCL Workstation identifiers. The identifiers are ones returned either from calling gsn_open_wks or calling
   create to create a Workstation object.

   dash_indexes

   An array of dash pattern indexes.
   dash_patterns

   A list of strings of the same length as dash_indexes indicating the dash patterns to create.

Description

   For the dash pattern table of each workstation in wks, this procedure sets the given indexes to the dash pattern defined
   for that index.

   We recommend that you use the NhlNewDashPattern function instead, as it doesn't require that you give it a list of dash
   pattern indexes. It just adds the dash pattern to the end of the current dash pattern table, and returns a new list of
   indexes.

   For more information on how to create a new dash pattern, see the description section for NhlNewDashPattern.

See Also

   NhlNewDashPattern, NhlNewMarker

Examples

   See the examples in NhlNewDashPattern.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:09:22 +0800
# vim:set fdm=indent foldlevel=0:
