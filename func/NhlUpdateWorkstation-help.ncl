THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/NhlUpdateWorkstation.shtml
THE_TITLE:NhlUpdateWorkstation

NhlUpdateWorkstation

   Updates the given workstation objects.

Prototype

        procedure NhlUpdateWorkstation (
                wks  : graphic
        )

Arguments

   wks

   An array of any dimensionality of NCL Workstation identifiers. The identifiers are ones returned either from calling
   gsn_open_wks or calling create to create a Workstation object.

Description

   The NhlUpdateWorkstation procedure is used to flush the internal buffers of HLU Workstation instances.

   Note: this procedure is identical to the update procedure, and we encourage the use of update instead (saves having to
   type longer names and capital letters).

See Also

   clear, update, frame


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:09:25 +0800
# vim:set fdm=indent foldlevel=0:
