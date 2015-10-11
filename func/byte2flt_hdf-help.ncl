THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/byte2flt_hdf.shtml
THE_TITLE:byte2flt_hdf

byte2flt_hdf

   Converts values of type byte to values of type float using the "scale" and "offset" attributes (if present).

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function byte2flt_hdf (
                x  : byte
        )

        return_val [dimsizes(x)] :  float

Arguments

   x

   An array of type byte of any dimensionality.

Return value

   The results are returned in a float array of the same type dimensionality as x. Metadata is preserved.

Description

   This function converts byte data to float using the "scale" and "offset" attributes (if present), and preserves metadata.
   It assumes that the "offset" is subtracted from the "scale" prior to application to the data.
             x_float = scale*(x_byte - offset)

   Other attributes similar to "scale" and "offset" will be recognized:

   offset:
          "add_offset", "OFFSET", "Offset", "_offset", "Intercept", "intercept"

   scale:
          "SCALE", "Scale", "_scale", "scale_factor", "Scale_factor", "Slope" , "slope"

   Note1: This function is slightly different than the built-in set of conversion functions (like floattointeger and
   shorttobyte), because it requires loading the "contributed.ncl" script and it preserves metadata. It has a slightly
   different naming style than the built-in functions, just to set it apart from these other functions.

   Note2: A separate function, byte2flt, must be used if the following approach is to be applied:
             x_float = x_byte*scale + offset

See Also

   short2flt, short2flt_hdf, dble2flt, flt2dble, byte2flt, typeof, getfilevartypes


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:27 +0800
# vim:set fdm=indent foldlevel=0:
