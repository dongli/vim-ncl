THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/str_get_cols.shtml
THE_TITLE:str_get_cols

str_get_cols

   Returns an array of substrings, given a start and end index into the given string.

   [new.gif] Available in version 5.1.1 and later.

Prototype

        function str_get_cols (
                string_val    : string,
                start_col [1] : integer,
                end_col   [1] : integer
        )

        return_val [dimsizes(string_val)] :  string

Arguments

   string_val

   An array of strings of any dimensionality.
   start_col
   end_col

   Scalar integers representing the start column and end column to be grabbed from a string. Numbering is 0-based, so the
   first column is 0.

Description

   This function returns an array of substrings with the same dimensionality as the input strings, but with the strings
   subscripted from start_col to end_col.

   You can use negative index values to indicate a count from the end of the string. For example, -1 represents the last
   character in a string, -2 the second-to-the-last character, etc.

   If end_col is greater than start_col, then the substring will be reversed (see example below).
   If just one of start_col and/or end_col are out-of-bounds, then the string will be subscripted only to the end or
   beginning as appropriate. If both are out-of-bounds, then an empty string ("") will be returned.

   If input strings are missing, then missing values will be returned.

See Also

   str_fields_count, str_get_field

Examples

   Example 1

   Assume you have an ASCII file, "asc3.txt":
200306130209   0.38   25.28 10088 233.95   6  92  9.99  9.99 99999.0   0.0 -9.99 167.9 p p p 1782  BOS_1  ATL 3
200306130209   0.38   25.28 10088 233.95   6  92  9.99  9.99 99999.0   0.0 -9.99 167.9 p p p 1782  ORD_2  ATL 3
200306122341 -45.10  168.70   914 279.35   4 272  9.99  9.99     1.1   0.0  0.01 -99.9 p p p 4552  DTW_3  MSP 3
200306122341 -45.10  168.70   914 279.35   4 272  9.99  9.99     1.1   0.0  0.01 -99.9 p p p 4552  SDF_4  MHR 3

   Use str_fields_count to count the number of fields separated by one or more spaces, str_get_field to retrieve the fields,
   and then str_get_cols to retrieve subsets of these fields:
 flnm = "asc3.txt"
 strs = asciiread(flnm,-1,"string")

 delim = " "
 nfields = str_fields_count(strs(0), delim)   ; Count the fields separated
                                              ; by one or more spaces.
 print(nfields)                               ; nfields = 20

 field = 1
 subStrings = str_get_field(strs, field, delim)
 print(subStrings)              ; (/"200306130209","200306130209",...,/)

 year = str_get_cols(subStrings, 0, 3)
 print(year)                   ; (/"2003","2003","2003","2003"/)

 month = str_get_cols(subStrings, 4, 5)
 print(month)                  ; (/"06","06","06","06"/)

 day = stringtoint(str_get_cols(subStrings, 6, 7))
 print(day)                    ; (/13,13,12,12/)

 hour = stringtoint(str_get_cols(subStrings, 8, 9))
 print(hour)                   ; (/2,2,23,23)

 minute = stringtoint(str_get_cols(subStrings, 10, 11))
 print(minute)                  ; (/9,9,41,41/)

   Example 2

   Assume you have the same ASCII file and the same strs arrays as in example 1, but that you want to read in the first 12
   characters and reverse them:
 date = str_get_cols(strs, 11, 0)
 print(date)                        ; (/"902031603002","902031603002",.../)

   To read in the second-to-the-last field, you can do this one of two ways:
 field = nfields-1
 subStrings = str_get_field(strs, field, delim)
 print(subStrings)              ; (/"ATL","ATL","MSP","MHR"/)

   Or:
 subStrings = str_get_cols(strs,-5,-3)
 print(subStrings)              ; (/"ATL","ATL","MSP","MHR"/)

   This second method is only good if you don't have extra whitespace at the end of your lines in the file.

   Example 3

   How can the following file (sample_sounding.txt) be read?
    PRES   HGHT   TEMP   DWPT   RELH   MIXR   DRCT   SKNT   THTA   THTE
    hPa     m      C      C      %    g/kg    deg   knot     K      K
-------------------------------------------------------------------------
  1013.0     17   22.8   16.8     69  12.02     20     10  294.9  329.5
  1012.0     26   22.8   16.9     70  12.15    350     14  294.9  330.0
  1000.0    136   22.4   18.8     80           345     16  295.6  335.5
   984.0    275   21.3            83           345     20  295.8  335.5
   930.0    763   17.6            97           350     14  296.8

   Use a combination of str_get_cols and tofloat. When tofloat encounters a non-numeric type (here, spaces) it issues a
   warning message. It uses the default float _FillValue (= 9.96921e+36). The simple function below results in a cleaner
   code and changes the return _FillValue.

   To suppress these warning messages use the answer to How can I turn off NCL warning messages?
undef("strflt")
function strflt(dstr[*]:string, colStrt[1]:integer, colLast[1]:integer)
begin
  dat = tofloat( str_get_cols(dstr, colStrt, colLast) )
  dat@_FillValue = -999.0       ; change from 9.96921e+36
  return(dat)
end


   err = NhlGetErrorObjectId()
   setvalues err
    "errLevel" : "Fatal"          ; only report Fatal errors
   end setvalues

   diri  = "./"
   fili  = "sample_sounding.txt"
   dstr  = asciiread(diri+fili, -1, "string")

   nrow  = dimsizes(dstr)
   nhead =  3
   nlvl  = nrow-nhead

   p  = strflt(dstr(nhead:), 0, 7)
   h  = strflt(dstr(nhead:),10,14)
   ts = strflt(dstr(nhead:),16,21)
   td = strflt(dstr(nhead:),22,28)
   rh = strflt(dstr(nhead:),30,35)
   mr = strflt(dstr(nhead:),37,42)
   wd = strflt(dstr(nhead:),44,49)
   ws = strflt(dstr(nhead:),50,56)
   ta = strflt(dstr(nhead:),57,63)
   te = strflt(dstr(nhead:),64,70)

   print(p)
   print(td)

   The output looks like:

Variable: pstr
Type: float
Total Size: 20 bytes
            5 values
Number of Dimensions: 1
Dimensions and sizes:   [5]
Coordinates:
Number Of Attributes: 1
  _FillValue :  -999
(0)     1013
(1)     1012
(2)     1000
(3)     984
(4)     930

=============

Variable: tdstr
Type: float
Total Size: 20 bytes
            5 values
Number of Dimensions: 1
Dimensions and sizes:   [5]
Coordinates:
Number Of Attributes: 1
  _FillValue :  -999
(0)     16.8
(1)     16.9
(2)     18.8
(3)     -999
(4)     -999



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:11:59 +0800
# vim:set fdm=indent foldlevel=0:
