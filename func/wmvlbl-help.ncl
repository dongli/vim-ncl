THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/wmvlbl.shtml
THE_TITLE:wmvlbl

wmvlbl

   Draws an informational label box for plots produced by wmvect or wmvectmap.

Prototype

        procedure wmvlbl (
                wks [1] : graphic,
                x   [*] : float,
                y   [*] : float
        )

Arguments

   wks

   An NCL workstation identifier specifying where you want to draw the label box. The wks identifier is one returned either
   from calling gsn_open_wks or calling create to create a Workstation object.

   x
   y

   NDC coordinates specifying where you want to place the box. These coordinates specify the lower right corner of the box.

Description

   The procedure wmvlbl uses the current settings for the parameters VRS and VRN to draw a reference vector with a printed
   numeric value indicating the world coordinate vector size such a vector represents.

   You have only two controls over the box - setting the foreground color (the color that the boundary, the vector, and the
   numeric label will be drawn in), and the background color (the color of the background area contained in the boundary
   box).

   To set parameters to control the appearance of the label box use the wmsetp procedure. To retrieve parameter values, use
   the function wmgetp.

   The parameters are:

    1. VLB - for setting the background color.
    2. VLF - for setting the foreground color.

   The procedure wmvlbl does not call frame.

See Also

   wmvectmap, wmvect

Examples

   See examples 8 and 9 on the weather symbols application page.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:15:36 +0800
# vim:set fdm=indent foldlevel=0:
