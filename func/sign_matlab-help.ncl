THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/sign_matlab.shtml
THE_TITLE:sign_matlab

sign_matlab

   Mimic the behavior of Matlab's sign function.

   [new.gif] Available in version 6.2.1 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function sign_matlab (
                X  : numeric
        )

        return_val  :  same type and shape as em>X one of 3 values: -1, 0, 1

Arguments

   X

   Scalar or array variable of type numeric.

Description

   Mimic Matlab's sign function: NCL's sign_matlab(X) returns:

    1  if the corresponding element of X is greater than zero

    0  if the corresponding element of X equals zero

    -1 if the corresponding element of X is less than zero


See Also

   sign_f90

Examples

   The contributed.ncl library is automatically loaded from NCL 6.2.0 onward.

  N = 3
  M = 9

  X = random_normal(0,5,(/N,M/))

  X = where(X.gt.-1 .and. X.lt.1, 0.0, X)   ; force 0 for demonstration purposes

  S = sign_matlab(X)
  print("sign_matlab: "+sprintf("%9.4f",X)+"  "+sprintf("%4.0f",S))

   An edited sample printed output is:
                          X        S
(0,0)   sign_matlab:    4.3516     1
(0,1)   sign_matlab:    4.3646     1
(0,2)   sign_matlab:    9.7340     1
(0,3)   sign_matlab:    4.9126     1
(0,4)   sign_matlab:    1.7698     1
(0,5)   sign_matlab:    0.0000     0
(0,6)   sign_matlab:   -4.2947    -1
(0,7)   sign_matlab:    4.3856     1
(0,8)   sign_matlab:    4.6598     1
(1,0)   sign_matlab:   -5.8381    -1
(1,1)   sign_matlab:    4.5896     1
(1,2)   sign_matlab:    3.6773     1
(1,3)   sign_matlab:  -14.1248    -1
(1,4)   sign_matlab:    0.0000     0
(1,5)   sign_matlab:    0.0000     0
(1,6)   sign_matlab:    3.7736     1
(1,7)   sign_matlab:    0.0000     0
(1,8)   sign_matlab:   -3.0932    -1
(2,0)   sign_matlab:    5.0781     1
(2,1)   sign_matlab:   -2.5122    -1
(2,2)   sign_matlab:    5.8457     1
(2,3)   sign_matlab:   -3.3532    -1
(2,4)   sign_matlab:   -1.6618    -1
(2,5)   sign_matlab:    8.4589     1
(2,6)   sign_matlab:    7.5549     1
(2,7)   sign_matlab:    0.0000     0
(2,8)   sign_matlab:    1.7595     1


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:03 +0800
# vim:set fdm=indent foldlevel=0:
