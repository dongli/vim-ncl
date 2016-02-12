THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/undef.shtml
THE_TITLE:undef

undef

   Undefines defined NCL symbols (functions, procedures, variables).

Prototype

        procedure undef (
                names  : string
        )

Arguments

   names

   String names of any dimensionality of symbols to be undefined.

Description

   This procedure should be used primarily to undefine functions and procedures, although it does work for variables. undef
   will remove from the symbol table any references matching the input.

   Warning: once a function, procedure, or variable is undefined, there is no way to get it back.

Examples

   Example 1

   The example below shows how to redefine the built-in function stringtocharacter to return a character array of a single
   string without the end-of-string character. We are being sneaky here, because we are using the identical function
   stringtochar to first return the character array. Note: it is not recommended that you do this, but there it is:
undef("stringtocharacter")
function stringtocharacter(str[1]:string)
local cstr, new_cstr
begin
  cstr     = stringtochar(str)
  new_cstr = cstr(0:dimsizes(cstr)-2)
  return(new_cstr)
end

begin
   str = "Ixnay on the ottenray."
   print(stringtocharacter(str))
end



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:14:10 +0800
# vim:set fdm=indent foldlevel=0:
