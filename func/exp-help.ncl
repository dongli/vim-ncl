THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/exp.shtml
THE_TITLE:exp

exp

   Computes the value of e (the base of natural logarithms) raised to the power of the input.

Prototype

        function exp (
                value  : numeric
        )

        return_val [dimsizes(value)] :  float or double

Arguments

   value

   An array of one or more floating point values of any dimension.

Return value

   Returns an array dimensioned the same as value.

   The return type is floating point if the input is floating point, and double if the input is of type double.

Description

   This function returns e^value. Missing values are ignored.

See Also

   log, log10

Examples

   Example 1

  f = -0.2
  exp_f = exp(f)
  print(exp_f)        ; Should be 0.8187308

   Example 2: Find the cube root of 3112.136 [=x^3]

  x = exp( log(3112.136)/3.0 )
  print( x )        ; Should be 14.6

   Example 3: Solve the following for x: y = 9.328*(0.729-x^3) - 1.8

   y = 2.0
   x = exp( log(0.729-((y+1.8)/9.328))/3.0 )  ; = 0.685


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:03:31 +0800
# vim:set fdm=indent foldlevel=0:
