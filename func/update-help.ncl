THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/update.shtml
THE_TITLE:update

update

   Updates the given workstation objects.

Prototype

        procedure update (
                wks  : graphic
        )

Arguments

   wks

   An array of any dimensionality of NCL Workstation identifiers. The identifiers are ones returned either from calling
   gsn_open_wks or calling create to create a Workstation object.

Description

   The update procedure is used to flush the internal buffers of NCL Workstation instances.

See Also

   clear, NhlUpdateWorkstation, frame


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:14:12 +0800
# vim:set fdm=indent foldlevel=0:
