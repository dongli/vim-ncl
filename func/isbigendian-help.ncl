THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/isbigendian.shtml
THE_TITLE:isbigendian

isbigendian

   Returns True if you are running NCL on a big endian machine.

Prototype

        function isbigendian (
        )

Description

   This function returns True if you are running on a big endian system, and False otherwise. This is important to know,
   especially if you are reading in binary files that were created on another system that may not be the same "endianness".

   For more information on reading and writing binary files, see the setfileoption procedure.

See Also

   setfileoption, cbinread, cbinwrite, fbindirread, fbinrecread, fbindirwrite, fbinrecwrite, fbinread, fbinnumrec

Examples

   Example 1: Let's say it is desired to create little endian binary files regardless of the current system's endianness:

         if (isbigendian() ) then
             setfileoption("bin","WriteByteOrder","LittleEndian")
         end if
         fbindirwrite(path, z )


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:06:10 +0800
# vim:set fdm=indent foldlevel=0:
