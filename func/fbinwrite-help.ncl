THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/fbinwrite.shtml
THE_TITLE:fbinwrite

fbinwrite

   Writes a single binary record to a file in manner analogous to Fortran's "form=unformatted, access=sequential".

Prototype

        procedure fbinwrite (
                filepath [1] : string,
                value        : numeric
        )

Arguments

   filepath

   Path needed to locate binary file.
   value

   A numeric variable of any dimensionality.

Description

   The fbinwrite function is used to create a binary data file from an NCL numeric variable. The variable is written to a
   file as a single sequential access unformatted record.

   By default, the elements of value are written to the file using the machine's native binary format. To force the byte
   order to be written as big-endian or little-endian, see the "WriteByteOrder" option in the setfileoption procedure.

   By default, the record marker size at the beginning and end of Fortran sequential files is assumed to be 4 bytes. In
   V6.1.1 and later, you can change this to 8 bytes using the "RecordMarkerSize" option in the setfileoption procedure.

See Also

   fbinnumrec, fbinrecread, fbindirread, fbinread, fbinrecwrite, fbindirwrite, setfileoption

Examples

   The following will write one record length 100x64x128 float words.
  ntimes = 100
  z      = new ( (/ntimes,64,128/), float)
  fbinwrite(path, z )

   The binary file will be the same as one opened via Fortran's open statement:
    open(..., form="unformatted",  [,access="sequential"] )  ; sequential is default


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:03:55 +0800
# vim:set fdm=indent foldlevel=0:
