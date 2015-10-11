THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/craybinnumrec.shtml
THE_TITLE:craybinnumrec

craybinnumrec

   Returns the number of unformatted sequential access Fortran records in a Cray COS blocked binary file.

Prototype

        function craybinnumrec (
                path [1] : string
        )

        return_val [1] :  integer

Arguments

   path

   pathname of file

Description

   This function returns the number of records in a COS blocked Fortran unformatted sequential access binary file. The COS
   blocked file must have been created via the Fortran open statement, e.g.:
      open (...,form="unformatted",...).

See Also

   craybinrecread, fbinnumrec, fbinrecread fbinrecwrite

Examples

   Example 1

   Determine the number of records on a file created on a Cray when opening the file via the Fortran statement: open(10,
   "foo.COS", form="unformatted")

   nrec = craybinnumrec("foo.COS")   ; nrec is scalar integer


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:00:29 +0800
# vim:set fdm=indent foldlevel=0:
