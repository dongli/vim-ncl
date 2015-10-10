THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/isvar.shtml
THE_TITLE:isvar

isvar

   Returns True for every element of the input that is a defined variable.

Prototype

        function isvar (
                varnames  : string
        )

        return_val [dimsizes(varnames)] :  logical

Arguments

   varnames

   An array of strings of any dimensionality.

Description

   For each element in the varnames list, isvar returns True if the element is a defined variable and False otherwise. The
   output of isvar is a logical array with the same dimensions as varnames.

See Also

   isdefined

Examples

   In the NCL script below, isvars will be equal to (/True, False, True/):
    x      = 1.5
    title  = "Temperature"
    isvars = isvar((/"x","z","title"/))


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:06:56 +0800
# vim:set fdm=indent foldlevel=0:
