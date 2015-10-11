THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/erf.shtml
THE_TITLE:erf

erf

   Evaluates the real error function.

Prototype

        function erf (
                x  : numeric            [float or double]
        )

        return_val  :  same size/shape/type as x

Arguments

   x

   A scalar or multi-dimensional array of type float or double.

Return value

   Same size as x. The return value is double if x is double, and float otherwise.

Description

   Evaluates the real error function.

See Also

   erfc

Examples

   Example 1

  x      = (/ 0, 100, 0.8, -0.8, 0.1/)
  result = erf (x)
  print ("x="+x+"   xresult="+result)


   The results are:
 x=   0    xresult= 0
 x= 100    xresult= 1
 x= 0.8    xresult= 0.742101
 x=-0.8    xresult=-0.742101
 x= 0.1    xresult= 0.112463


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:03:18 +0800
# vim:set fdm=indent foldlevel=0:
