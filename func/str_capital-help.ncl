THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/str_capital.shtml
THE_TITLE:str_capital

str_capital

   Capitalizes all words in each string.

   [new.gif] Available in version 5.1.1 and later.

Prototype

        function str_capital (
                string_val  : string
        )

        return_val [dimsizes(string_val)] :  string

Arguments

   string_val

   A string array of any dimensionality.

Description

   This function returns strings with all words capitalized in every input string.

See Also

   str_upper, str_lower, str_switch

Examples

   Example

 strs = (/"NCL has many features common to modern programming languages,", \
          "including types, variables, operators, expressions,", \
          "conditional statements, loops, and functions and procedures."/)
 new_strs = str_capital(strs)
 print(new_strs)

   Output:

Variable: new_strs
Type: string
Total Size: 12 bytes
            3 values
Number of Dimensions: 1
Dimensions and sizes:   [3]
Coordinates:
(0)     NCL Has Many Features Common To Modern Programming Languages,
(1)     Including Types, Variables, Operators, Expressions,
(2)     Conditional Statements, Loops, And Functions And Procedures.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:11:55 +0800
# vim:set fdm=indent foldlevel=0:
