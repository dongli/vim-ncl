THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/tounsigned.shtml
THE_TITLE:tounsigned

tounsigned

   Converts any kind of 8/16/32/64 integers to its corresponding unsigned integers.

   [new.gif] Available in version 5.2.0 and later.

Prototype

        function tounsigned (
                input_val  : any kind of 8/16/32/64 integers.
        )

        return_val [dimsizes(input_val)] :  unsigned 8/16/32/64 integers.

Arguments

   input_val

   A variable of any kind of 8/16/32/64 integers.

Return value

   Returns corresponding 8/16/32/64 integers.

Description

   This function converts any kind of 8/16/32/64 integers to its corresponding unsigned integers. If there is any missing
   value, it will be converted as well.

See Also

   tosigned

Examples

   Example 1

uv = new((/2/), ushort)
uv = 65535H
v = tosigned(uv)
print(uv)

;print-out:
;Variable: uv
;Type: ushort
;...
;(0)     65535
;(1)     65535

print(v)

;print-out:
;Variable: v
;Type: short
;...
;(0)     -1
;(1)     -1

nuv = tounsigned(v)
print(nuv)

;print-out:
;Variable: nuv
;Type: ushort
;...
;(0)     65535
;(1)     65535

   Example 2

ui = new((/2/), uint)
;ui = 2147483647I
ui = 4294967285I
i = tosigned(uv)(ui)
print(ui)
print(i)

nui = tounsigned(uv)(i)
print(nui)

ul = new((/2/), ulong)
;ul = 2147483647L
ul = 4294967285L
l = tosigned(uv)(ul)
print(ul)
print(l)

nul = tounsigned(uv)(l)
print(nul)

ull = new((/2/), uint64)
ull = 9223372036854775807Q
;ull = 18446744073709551615Q
ull = 2 * ull + 1;
ll = tosigned(uv)(ull)
print(ull)
print(ll)

mull = tounsigned(uv)(ll)
print(mull)



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:13:59 +0800
# vim:set fdm=indent foldlevel=0:
