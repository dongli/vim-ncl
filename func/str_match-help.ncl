THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/str_match.shtml
THE_TITLE:str_match

str_match

   Returns a list of strings that contain the given substring (case sensitive).

   [new.gif] Available in version 5.2.0 and later.

Prototype

        function str_match (
                string_array [*] : string,
                sub_string   [1] : string
        )

        return_val [*] :  string

Arguments

   string_array

   A string array of any dimensionality.
   sub_string

   The substring to be matched.

Description

   This function returns an array of strings with every occurrence of sub_string matched in string_array.

   If there is no sub_string matched in string_array, the default string missing value ("missing") will be returned.

   Please note, str_match is case SENSITIVE as of version 6.0.0. There's a bug in versions 6.0.0-beta and earlier in which
   this function is not case sensitive.

   Use str_match_ic if you need case insensitivity.

See Also

   str_index_of_substr, str_sub_str, str_match_ic, str_match_ind, str_match_ind_ic, str_match_regex, str_match_ic_regex,
   str_match_ind_regex, str_match_ind_ic_regex

Examples

   Example 1

   Get all the strings containing "cnConst" from the list of contour resources:

 class_out = NhlGetClassResources("contourPlotClass", "")

 cnConst = str_match(class_out, "cnConst")

 print(cnConst)


   Output:
(0)     cnConstFLabelAngleF
(1)     cnConstFLabelBackgroundColor
(2)     cnConstFLabelConstantSpacingF
(3)     cnConstFLabelFont
(4)     cnConstFLabelFontAspectF
(5)     cnConstFLabelFontColor
(6)     cnConstFLabelFontHeightF
(7)     cnConstFLabelFontQuality
(8)     cnConstFLabelFontThicknessF
(9)     cnConstFLabelFormat
(10)    cnConstFLabelFuncCode
(11)    cnConstFLabelJust
(12)    cnConstFLabelOn
(13)    cnConstFLabelOrthogonalPosF
(14)    cnConstFLabelParallelPosF
(15)    cnConstFLabelPerimColor
(16)    cnConstFLabelPerimOn
(17)    cnConstFLabelPerimSpaceF
(18)    cnConstFLabelPerimThicknessF
(19)    cnConstFLabelSide
(20)    cnConstFLabelString
(21)    cnConstFLabelTextDirection
(22)    cnConstFLabelZone
(23)    cnConstFUseInfoLabelRes


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:12:13 +0800
# vim:set fdm=indent foldlevel=0:
