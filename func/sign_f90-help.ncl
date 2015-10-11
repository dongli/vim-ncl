THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/sign_f90.shtml
THE_TITLE:sign_f90

sign_f90

   Mimic the behavior of fortran-90's sign transfer function.

   [new.gif] Available in version 6.2.1 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function sign_f90 (
                X  : numeric,
                Y  : numeric
        )

        return_val  :  same type and shape as abs(X) with the sign of Y

Arguments

   X

   Scalar or array variable of type numeric.
   Y

   Scalar or array variable of type numeric. It must be the same size and shape as X. However, it may be of different
   numeric type.

Description

   Mimic Fortran-90's 'sign' function. sign_f90(X,Y) returns the absolute value of X times the sign of Y.

     * Fortran 90 does not allow a processor to distinguish between a positive and a negative zero, whereas Fortran 95 does.
     * NCL can not test for -0 .... this will test positive.

See Also

   sign_matlab

Examples

   The contributed.ncl library is automatically loaded from NCL 6.2.0 onward.

  N = 3
  M = 9

  X = random_normal(0,5,(/N,M/))
  Y = random_normal(0,9,(/N,M/))

  X_f90 = sign_f90(X,Y)
  print("sign_f90: "+sprintf("%9.4f",X)    +"  " \
                    +sprintf("%9.4f",X_f90)+"  " \
                    +sprintf("%9.4f",Y))


   An edited sample printed output is:

                                return
                       X         X_f90       Y
(0,0)   sign_f90:    4.3516     4.3516     1.5664
(0,1)   sign_f90:    4.3646    -4.3646   -12.4236
(0,2)   sign_f90:    9.7340     9.7340     7.3159
(0,3)   sign_f90:    4.9126     4.9126    18.6940
(0,4)   sign_f90:    1.7698     1.7698     8.2136
(0,5)   sign_f90:   -0.6350    -0.6350   -10.1430
(0,6)   sign_f90:   -4.2947    -4.2947    -2.5691
(0,7)   sign_f90:    4.3856     4.3856    15.5743
(0,8)   sign_f90:    4.6598     4.6598     2.8550
(1,0)   sign_f90:   -5.8381     5.8381    12.8111
(1,1)   sign_f90:    4.5896     4.5896    16.2034
(1,2)   sign_f90:    3.6773    -3.6773    -4.7093
(1,3)   sign_f90:  -14.1248    14.1248     1.4315
(1,4)   sign_f90:    0.0693    -0.0693    -5.5404
(1,5)   sign_f90:    0.2680    -0.2680    -0.4364
(1,6)   sign_f90:    3.7736    -3.7736    -3.7113
(1,7)   sign_f90:    0.8871     0.8871     3.1518
(1,8)   sign_f90:   -3.0932     3.0932    12.5129
(2,0)   sign_f90:    5.0781    -5.0781    -0.6788
(2,1)   sign_f90:   -2.5122    -2.5122   -11.0567
(2,2)   sign_f90:    5.8457     5.8457     9.9452
(2,3)   sign_f90:   -3.3532     3.3532     2.7727
(2,4)   sign_f90:   -1.6618    -1.6618    -4.8936
(2,5)   sign_f90:    8.4589    -8.4589   -25.4436
(2,6)   sign_f90:    7.5549    -7.5549   -10.6152
(2,7)   sign_f90:    0.1364     0.1364    14.3543
(2,8)   sign_f90:    1.7595    -1.7595    -1.6946



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:02 +0800
# vim:set fdm=indent foldlevel=0:
