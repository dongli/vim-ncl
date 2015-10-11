THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/v5d_setUnits.shtml
THE_TITLE:v5d_setUnits

v5d_setUnits

   Sets a name for physical units for a variable in a Vis5D+ format file.

Prototype

        procedure v5d_setUnits (
                variable [1] : integer,
                units    [*] : string
        )

Arguments

   variable

   The variable number of the Vis5D+ format variable with which to associate physical units, in the range [1...(numvars-1)]

   units

   The descriptive name and type of physical units with which to associate the variable.

Description

   v5d_setUnits()
   associates a descriptive name and type of physical units with a variable in a Vis5D+ format file.

   For further information on Vis5D+ and file formats, see documentation at the Vis5D website.

See Also

   v5d_create, v5d_write, v5d_write_var, v5d_close, v5d_setLowLev

Examples

   Example

  Assignment        Comments

  ...
  vars    = (/"T", "P", "S"/)
  numvars = dimsizes(vars)     ; here 3
  v5d_create(...)

  ;; for variable "P"
  v5d_setUnits(1, "millibars")
  v5d_write(...)



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:14:34 +0800
# vim:set fdm=indent foldlevel=0:
