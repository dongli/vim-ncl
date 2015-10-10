THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/cshstringtolist.shtml
THE_TITLE:cshstringtolist

cshstringtolist

   Converts a comma delimited string from csh and breaks it up into separate strings.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function cshstringtolist (
                cshlist  : string
        )

        return_val [*] :  string

Arguments

   cshlist

   A comma delimited string. Note that there must be commas at the beginning and end (e.g. ,cat,dog,bird,).

Return value

   An array of strings.

Description

   Converts a comma delimited string from csh and breaks it up into separate strings.

See Also

   str_split, str_split_csv

Examples

   No examples are currently available for this function.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:55 +0800
# vim:set fdm=indent foldlevel=0:
