THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/shgetp.shtml
THE_TITLE:shgetp

shgetp

   Retrieves control parameters for Shgrid routines.

Prototype

        function shgetp (
                pnam [1] : string
        )

        return_val [1]

Arguments

   pnam

   The name of the parameter you want to retrieve. Choose one from this list.

Return value

   A value of a type appropriate to the parameter being retrieved.

Description

   The function shgetp retrieves the current value of a named parameter of Shgrid.

Examples

begin

  shsetp("nls",50)   ; parameter names can be either upper or lower case
  shsetp("nfl",5)
  shsetp("ncl",3)

  nls = shgetp("nls")
  nfl = shgetp("nfl")
  ncl = shgetp("ncl")

  print(nls)
  print(nfl)
  print(ncl)

end


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:11:00 +0800
# vim:set fdm=indent foldlevel=0:
