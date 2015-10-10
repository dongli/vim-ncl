THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/isscalar.shtml
THE_TITLE:isscalar

isscalar

   Returns True if the given argument is a scalar.

   [new.gif] Available in version 6.3.1 and later.

Prototype

        function isscalar (
                x
        )

Arguments

   x

   A variable of any type.

Return value

   Returns True if x is a scalar; False otherwise.

Description

   If the array rank of x and the size of x are one, then it is a scalar quantity.

Examples

   Example 1
       i = 1
       x = (/ 3.3, 7.3111 /)
       s = "s"
       S = (/ "a", "q", "z"/)

       print("isscalar(i)="+isscalar(i))
       print("isscalar(x)="+isscalar(x))
       print("isscalar(s)="+isscalar(s))
       print("isscalar(S)="+isscalar(S))

   yields


(0)    isscalar(i)=True
(0)    isscalar(x)=False
(0)    isscalar(s)=True
(0)    isscalar(S)=False


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:06:44 +0800
# vim:set fdm=indent foldlevel=0:
