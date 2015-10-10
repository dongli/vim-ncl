THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/fileexists.shtml
THE_TITLE:fileexists

fileexists

   Checks for existence of any UNIX file.

   [new.gif] Available in version 6.2.1 and later.

Prototype

        function fileexists (
                file_path  : string
        )

        return_val [dimsizes(file_path)] :  logical

Arguments

   file_path

   A scalar string or a multi-dimensional array of strings containing the full or relative path to UNIX files (Unix pathname
   string) for which to check presence on the filesystem.

Return value

   The output of fileexists is a logical variable with the same dimension sizes as the input.

Description

   The function fileexists returns True for every element of file_path that is present, and False if not.

   This function was created in NCL V6.2.1, to complement the isfilepresent function, which now only returns True if the
   file is present and it is a supported format recognized by addfile.

See Also

   isfilepresent

Examples

   Example 1

   The following code will determine if an ASCII file named "StationData.csv" exists before trying to read it in:

  filename = "StationData.csv"
  if (fileexists(filename)) then
    lines = asciiread (filename,-1,"string")
  end if

   Example 2

   The following code will determine if each of a group of files called "StationData_1.txt", "StationData_2.txt", ...,
   "StationData_5.txt" exists:

  filenames = "StationData_" + ispan(1,5,1) + ".txt"
  if (all(fileexists(filename))) then
    . . .  do something here . . .
  end if


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:04:04 +0800
# vim:set fdm=indent foldlevel=0:
