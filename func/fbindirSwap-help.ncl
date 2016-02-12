THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/fbindirSwap.shtml
THE_TITLE:fbindirSwap

fbindirSwap

   Reads byte-reversed data and writes output file that can be read by fbindirread or cbinread (deprecated).

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        procedure fbindirSwap (
                in_file  [1] : string,
                dims     [*] : integer,
                type     [1] : string,
                out_file [1] : string
        )

Arguments

   in_file

   Name of input file.
   dims

   A one-dimensional array or equal to the dimensionality of the input data.
   type

   The type of the data in in_file (e.g. "float")
   out_file

   Name of output file.

Description

   Note: this function is deprecated. You can now use the "ReadByteOrder" and "WriteByteOrder" options in setfileoption to
   indicate how the various NCL binary read/write functions should read and write files.

   This procedure reads byte-reversed data and writes output file that can be read by fbindirread or cbinread.

See Also

   setfileoption, fbindirread, cbinread, fbinseqSwap1, fbinseqSwap2


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:17:54 +0800
# vim:set fdm=indent foldlevel=0:
