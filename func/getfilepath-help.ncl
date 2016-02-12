THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/getfilepath.shtml
THE_TITLE:getfilepath

getfilepath

   Returns a string of the opened file's path.

   [new.gif] Available in version 6.3.0 and later.

Prototype

        function getfilepath (
                the_file [1] : file
        )

        return_val [1] :  string

Arguments

   the_file

   "the_file" references to a file. It is created using addfile or addfiles. Thus, it must be a supported file format.

Return value

   This function returns a string which contains the path of a opended file.

Examples

   The following example gets the path info of a opened file back.
    f = addfile ("MLS-Aura_L2GP-O3_v02-22-c01_2008d001.he5" , "r")   ; could also have ccm, grb or hdf suffix
    path = getfilepath (f) ; get file pointer's path

    print (path)               ; print file's path

   The above script produces:

Variable: path
Type: string
Total Size: 8 bytes
            1 values
Number of Dimensions: 1
Dimensions and sizes:   [1]
Coordinates:
(0)     MLS-Aura_L2GP-O3_v02-22-c01_2008d001.he5


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:05:27 +0800
# vim:set fdm=indent foldlevel=0:
