THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/fbindirwrite.shtml
THE_TITLE:fbindirwrite

fbindirwrite

   Writes binary records to a file in manner analogous to fortran's "access=direct".

Prototype

        procedure fbindirwrite (
                path [1] : string,
                var      : numeric
        )

Arguments

   path

   Pathname to binary file.
   var

   A numeric variable of any dimensionality.

Description

   fbindirwrite writes records to a file in a manner similar to that written by Fortran code that opens a file with
   'form=unformatted, access=direct, recl= ...'. If the file already exists, the values to be written are appended to the
   file.

   By default, the elements of var are written to the file using the machine's native binary format. To force the byte order
   to be written as big-endian or little-endian, see the "WriteByteOrder" option in the setfileoption procedure.

   This function was updated in version 4.3.0 in order to allow writes of files bigger than 2 GB.

See Also

   fbinnumrec, fbinrecread, fbindirread, fbinread, fbinrecwrite, fbinwrite, isbigendian, setfileoption

Examples

   The following will write ntimes records, each of length 64x128 float words.

     ntimes = 100
     z    = new ( (/ntimes,64,128/), float)
          .
     path = "/dummy/file"
     do nt=0,ntimes-1
        fbindirwrite(path,z(nt,:,:) )
     end do

   The binary file will be the same as one opened via Fortran's open statement:
     open(..., form="unformatted", access="direct", recl= )   ; recl is system dependent


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:03:50 +0800
# vim:set fdm=indent foldlevel=0:
