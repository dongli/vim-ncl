THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/str_match_ind.shtml
THE_TITLE:str_match_ind

str_match_ind

   Returns a list of indexes into an array of strings that contain the given substring (case sensitive).

   [new.gif] Available in version 6.0.0 and later.

Prototype

        function str_match_ind (
                string_array [*] : string,
                sub_string   [1] : string
        )

        return_val [*] :  integer

Arguments

   string_array

   A string array of any dimensionality.
   sub_string

   The substring to be matched.

Description

   This function returns an array of indexes where every occurrence of sub_string is matched in string_array. The matching
   is case sensitive.

   If there is no sub_string matched in string_array, the default missing value for an integer will be returned.

   Please note, str_match_ind is case sensitive. Use str_match_ind_ic if you need case insensitivity.

See Also

   str_match, str_match_ic, str_match_ind_ic, str_match_regex, str_match_ic_regex, str_match_ind_regex,
   str_match_ind_ic_regex, str_index_of_substr, str_sub_str

Examples

   Example 1

   Get the indexes of all the strings containing "Line" from the list of strings:

  strings = (/"cnLineColor","mpFillColor","xyLineThicknessF",\
              "txString","polyline"/)
  ii = str_match_ind(strings,"Line")
  print(ii)
  print(strings(ii))

   Output:

Variable: ii
Type: integer
Total Size: 8 bytes
            2 values
Number of Dimensions: 1
Dimensions and sizes:   [2]
Coordinates:
(0)     0
(1)     2

Variable: strings (subsection)
Type: string
Total Size: 8 bytes
            2 values
Number of Dimensions: 1
Dimensions and sizes:   [2]
Coordinates:
(0)     cnLineColor
(1)     xyLineThicknessF


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:12:16 +0800
# vim:set fdm=indent foldlevel=0:
