THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/flt2dble.shtml
THE_TITLE:flt2dble

flt2dble

   Converts values of type float to values of type double and preserves metadata.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function flt2dble (
                x  : float
        )

        return_val [dimsizes(x)] :  double

Arguments

   x

   An array of any dimensionality and of type float.

Return value

   An array of the same size as x and of type double.

Description

   This function converts values of type float to values of type double and preserves metadata.

   Note: this function is slightly different than the built-in set of conversion functions (like floattointeger and
   shorttobyte), because it requires loading the "contributed.ncl" script and it preserves metadata. It has a slightly
   different naming style than the built-in functions, just to set it apart from these other functions.

See Also

   dble2flt, short2flt, todouble

Examples

   Example 1


  diri   = "./"
  fili   = "V22_GPCP.1979-2010.nc"
  f      = addfile(diri+fili, "r")

  prc    = flt2dble(f->PREC)
  pmsg   = prc@_FillValue      ; convenience

  printVarSummary(prc)
  printMinMax(prc,0)




   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:17:58 +0800
# vim:set fdm=indent foldlevel=0:
