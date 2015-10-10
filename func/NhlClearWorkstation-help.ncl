THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/NhlClearWorkstation.shtml
THE_TITLE:NhlClearWorkstation

NhlClearWorkstation

   Clears the given workstation objects.

Prototype

        procedure NhlClearWorkstation (
                wks  : graphic
        )

Arguments

   wks

   An array of any dimensionality of NCL Workstation identifiers. The identifiers are ones returned either from calling
   gsn_open_wks or calling create to create a Workstation object.

Description

   This procedure loops through the given list of workstation identifiers and clears the workstation. If any of the
   workstations were set up to pause on the clear procedure, they must have a button click or key click in them before the
   actual clearing occurs.

   Note: this procedure is identical to the clear procedure, and we encourage the use of clear instead (saves having to type
   longer names and capital letters).

See Also

   clear, frame, update

Examples

   See the examples for clear.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:08:34 +0800
# vim:set fdm=indent foldlevel=0:
