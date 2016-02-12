THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/dgeevx_lapack.shtml
THE_TITLE:dgeevx_lapack

dgeevx_lapack

   Given a square (N,N) real nonsymmetric matrix, compute the eigenvalues and, optionally, the left and/or right
   eigenvectors via the LAPACK subroutine dgeevx.

   [new.gif] Available in version 6.1.1 and later.

Prototype

        function dgeevx_lapack (
                Q   [*][*] : numeric,
                balanc [1] : string,
                jobvl  [1] : string,
                jobvr  [1] : string,
                sense  [1] : string,
                opt    [1] : logical
        )

        return_val [*][*] :  float or double

Arguments

   Q

   A square (N x N) matrix. On return, Q has been overwritten. If jobvl = "V" or jobvr = "V", Q contains the real Schur form
   of the balanced version of the input matrix Q. Note: If the input Q matrix is to be subsequently used by the user, then a
   copy should be made prior to invoking this function. Missing values are not allowed.

   balanc

   Indicates how the input matrix, Q, should be diagonally scaled and/or permuted to improve the conditioning of its
   eigenvalues. See dgeevx for details.
   balanc = 'N': Do not diagonally scale or permute;
          = 'P': Perform permutations to make the matrix more nearly
                 upper triangular. Do not diagonally scale;
          = 'S': Diagonally scale the matrix, i.e. replace Q by
                 D*Q*D**(-1), where D is a diagonal matrix chosen
                 to make the rows and columns of A more equal in
                 norm. Do not permute;
          = 'B': Both diagonally scale and permute Q.

   jobvl

   Specifies if the left eigenvectors of Q are to be computed or not.
   jobvl = "N": left eigenvectors of Q are not computed.
   jobvl = "V": left eigenvectors of Q are computed.
   If sense = "E" or "B", jobvl must = "V".

   jobvr

   Specifies if the right eigenvectors of Q are to be computed or not.
   jobvr = "N": right eigenvectors of Q are not computed;
   jobvr = "V": right eigenvectors of Q are computed.
   If sense = "E" or "B", jobvr must = "V".

   sense

   Determines which reciprocal condition numbers are computed.
  sense = "N": None are computed.
  sense = "E": Computed for eigenvalues only.
  sense = "V": Computed for right eigenvectors only.
  sense = "B": Computed for eigenvalues and right eigenvectors.

  If sense = "E" or "B", both left and right eigenvectors
  must also be computed (jobvl = "V" and jobvr = "V").

   opt

   Option setting. Currently, not used.

Return value

   A (2,2,N,N) array is returned:
    (0,0,N,N) refers to the left eigenvector real part
    (0,1,N,N) refers to the left eigenvector imaginary part
    (1,0,N,N) refers to the right eigenvector real part
    (1,1,N,N) refers to the right eigenvector imaginary part

   It will be of type double if Q is double, and float otherwise.

   The following will be returned as attributes.
    eigr - vector of length N containing the real part of the computed eigenvalues.
    eigi - vector of length N containing the imaginary part of the computed eigenvalues.

    eigleft  - array of size NxN containing the left eigenvectors.
               This is VL in the LAPACK dgeevx documentation.
    eigright - array of size NxN containing the right eigenvectors.
               This is VR in the LAPACK dgeevx documentation.

Description

   Given a square (N,N) real nonsymmetric matrix, compute the eigenvalues and, optionally, the left and/or right
   eigenvectors via the LAPACK subroutine dgeevx.

   Missing values are not allowed, and the routine will exit if any are encountered.

   The returned array contains the same information as the eigleft and eigright attributes. The values are just presented in
   a different form.

See Also

   svd_lapack, covcorm_xy

Examples

   Note: remember that NCL is row-major in terms of how it interprets arrays. This means that the leftmost dimension varies
   slowest and the rightmost dimension varies the fastest.

   Example 1

; Data source
; NAG: f08nbf: http://www.nag.com/numeric/fl/nagdoc_fl23/xhtml/F08/f08nbf.xml
; The NAG example reads the data in the transpose order of NCL.

  x   = (/ (/ 0.35,  0.45, -0.14, -0.17/) \
         , (/ 0.09,  0.07, -0.54,  0.35/) \
         , (/-0.44, -0.33, -0.03,  0.17/) \
         , (/ 0.25, -0.32, -0.13,  0.11/) /)

  REORDER = True
  if (REORDER) then   ; transposed from order 'seen' in example
      x!0 = "dim0"
      x!1 = "dim1"
      x   = x(dim1|:,dim0|:)
  end if

  balanc = "B"            ; balance
  jobvl  = "V"            ; compute Left  eigenvectors
  jobvr  = "V"            ; compute Right eigenvectors
  sense  = "B"            ; computed for eigenvalues and right eigenvectors
  opt    =  False         ; return in row major order (columns vary fastest)

  evlr   = dgeevx_lapack (x, balanc, jobvl, jobvr, sense, opt)  ; (2,2,4,4)

;or, directly place the options in the function invocation

;;evlr   = dgeevx_lapack (x, "B", "V", "V", "B", False )        ; (2,2,4,4)

  print(" ")
  printVarSummary(evlr)
  print(" ")

  print("------ Eigenvalues -----")
  print("     Real      Imaginary")
  print(sprintf("%9.4f", evlr@eigr)+"     "+sprintf("%9.4f", evlr@eigi))
  print(" ")

  print("------ Eigenvectors: (NxN): printed as linear list -----")
  print("     Right         Left")
  print(sprintf("%9.4f", evlr@eigright)+"     "+sprintf("%9.4f", evlr@eigleft))
  print(" ")

  left = 0        ; leftmost dimension
  rght = 1

  real = 0        ; next dimension
  imag = 1

  dimx = dimsizes(x)
  N    = dimx(0)

  print("               EIGENVECTORS:     ")
  print("            REAL      IMAGINARY")

  do j=0,N-1
     print(" ")
     print(" left: "+sprintf("%9.4f", evlr(left,real,j,:))+"     "+sprintf("%9.4f", evlr(left,imag,j,:)))
  end do

  print("==================")

  do j=0,N-1
     print(" ")
     print("right: "+sprintf("%9.4f", evlr(rght,real,j,:))+"     "+sprintf("%9.4f", evlr(rght,imag,j,:)))
  end do


   The output would look like:

   Variable: evlr
   Type: float
   Total Size: 256 bytes
               32 values
   Number of Dimensions: 3
   Dimensions and sizes:    [2] x [2] x [4] x [4]

   Number Of Attributes: 4
     eigright :
     eigleft  :
     eigi :    ( 0.0      ,   0.4007924,  -0.4007924,  0.0 )
     eigr :    ( 0.7994821, -0.09941246, -0.09941246, -0.1006572 )


           ------ Eigenvalues -----
                Real      Imaginary
   (0)        0.7995        0.0000
   (1)       -0.0994        0.4008
   (2)       -0.0994       -0.4008
   (3)       -0.1007        0.0000

        ------ Eigenvectors: (NxN): printed as linear list -----
               Right         Left
(0,0)        -0.6551       -0.6245
(0,1)        -0.5236       -0.5995
(0,2)         0.5362        0.4999
(0,3)        -0.0956       -0.0271
(1,0)        -0.1933        0.5330
(1,1)         0.2519       -0.2666
(1,2)         0.0972        0.3455
(1,3)         0.6760       -0.2541
(2,0)         0.2546        0.0000
(2,1)        -0.5224        0.4041
(2,2)        -0.3084        0.3153
(2,3)         0.0000       -0.4451
(3,0)         0.1253        0.6641
(3,1)         0.3320       -0.1068
(3,2)         0.5938        0.7293
(3,3)         0.7221        0.1249

                          EIGENVECTORS
                       REAL      IMAGINARY

   (0)      left:   -0.6245        0.0000
   (1)      left:   -0.5995        0.0000
   (2)      left:    0.4999        0.0000
   (3)      left:   -0.0271        0.0000

   (0)      left:    0.5330        0.0000
   (1)      left:   -0.2666        0.4041
   (2)      left:    0.3455        0.3153
   (3)      left:   -0.2541       -0.4451

   (0)      left:    0.5330       -0.0000
   (1)      left:   -0.2666       -0.4041
   (2)      left:    0.3455       -0.3153
   (3)      left:   -0.2541        0.4451

   (0)      left:    0.6641        0.0000
   (1)      left:   -0.1068        0.0000
   (2)      left:    0.7293        0.0000
   (3)      left:    0.1249        0.0000

           ==================

   (0)     right:   -0.6551        0.0000
   (1)     right:   -0.5236        0.0000
   (2)     right:    0.5362        0.0000
   (3)     right:   -0.0956        0.0000

   (0)     right:   -0.1933        0.2546
   (1)     right:    0.2519       -0.5224
   (2)     right:    0.0972       -0.3084
   (3)     right:    0.6760        0.0000

   (0)     right:   -0.1933       -0.2546
   (1)     right:    0.2519        0.5224
   (2)     right:    0.0972        0.3084
   (3)     right:    0.6760       -0.0000

   (0)     right:    0.1253        0.0000
   (1)     right:    0.3320        0.0000
   (2)     right:    0.5938        0.0000
   (3)     right:    0.7221        0.0000

   Example 2

; Data source
; ESSL: example 2.
; No imaginary parts

Use the same code as above on

  x   = (/ (/-2.0 ,  2.0 ,  2.0 ,  2.0 /) \
         , (/-3.0 ,  3.0 ,  2.0 ,  2.0 /) \
         , (/-2.0 ,  0.0 ,  4.0 ,  2.0 /) \
         , (/-1.0 ,  0.0 ,  0.0 ,  5.0 /) /)

   The output would look like:
   Variable: evlr
   Type: double
   Total Size: 512 bytes
               64 values
   Number of Dimensions: 4
   Dimensions and sizes:   [2] x [2] x [4] x [4]
   Coordinates:
   Number Of Attributes: 4
     eigright :
     eigleft  :
     eigi :    (        0, 0,    0,    0 )
     eigr :    ( 0.999999, 2,    3,    4 )

           ------ Eigenvalues -----
                Real      Imaginary
   (0)        1.0000        0.0000
   (1)        2.0000        0.0000
   (2)        3.0000        0.0000
   (3)        4.0000        0.0000


          ------ Eigenvectors: (NxN): printed as linear list -----
                Real      Imaginary
(0,0)        -0.7303       -0.7071
(0,1)        -0.5477        0.7071
(0,2)        -0.3651        0.0000
(0,3)        -0.1826        0.0000
(1,0)         0.6255       -0.4082
(1,1)         0.6255        0.8165
(1,2)         0.4170       -0.4082
(1,3)         0.2085        0.0000
(2,0)        -0.5547        0.0000
(2,1)        -0.5547        0.4082
(2,2)        -0.5547       -0.8165
(2,3)        -0.2774        0.4082
(3,0)         0.5000        0.0000
(3,1)         0.5000        0.0000
(3,2)         0.5000       -0.4472
(3,3)         0.5000        0.8944

                          EIGENVECTORS
                       REAL      IMAGINARY

   (0)      left:   -0.7071        0.0000
   (1)      left:    0.7071        0.0000
   (2)      left:    0.0000        0.0000
   (3)      left:    0.0000        0.0000

   (0)      left:   -0.4082        0.0000
   (1)      left:    0.8165        0.0000
   (2)      left:   -0.4082        0.0000
   (3)      left:    0.0000        0.0000

   (0)      left:    0.0000        0.0000
   (1)      left:    0.4082        0.0000
   (2)      left:   -0.8165        0.0000
   (3)      left:    0.4082        0.0000

   (0)      left:    0.0000        0.0000
   (1)      left:    0.0000        0.0000
   (2)      left:   -0.4472        0.0000
   (3)      left:    0.8944        0.0000

           ==================

   (0)     right:   -0.7303        0.0000
   (1)     right:   -0.5477        0.0000
   (2)     right:   -0.3651        0.0000
   (3)     right:   -0.1826        0.0000

   (0)     right:    0.6255        0.0000
   (1)     right:    0.6255        0.0000
   (2)     right:    0.4170        0.0000
   (3)     right:    0.2085        0.0000

   (0)     right:   -0.5547        0.0000
   (1)     right:   -0.5547        0.0000
   (2)     right:   -0.5547        0.0000
   (3)     right:   -0.2774        0.0000

   (0)     right:    0.5000        0.0000
   (1)     right:    0.5000        0.0000
   (2)     right:    0.5000        0.0000
   (3)     right:    0.5000        0.0000

   Example 3


Use the same code as above on


   x   = (/ (/ 8.0 , -1.0 , -5.0  /) \
          , (/-4.0 ,  4.0 , -2.0  /) \
          , (/18.0 , -5.0 , -7.0  /) /)


   The output would look like:

   Variable: evlr
   Type: float
   Total Size: 144 bytes
        36 values
   Number of Dimensions: 4
   Dimensions and sizes:   [2] x [2] x [3] x [3]
   Coordinates:

   Number Of Attributes: 4
        eigright :    ( 0.3162277660168378, -9.992007221626409e-16, 0.6324555320336762, 0.3162277660168379, 0.6324555320336755,
 0, 0.4082482904638627, 0.8164965809277263, 0.4082482904638627 )
        eigleft :     ( -0.8770580193070291, 0.2631174057921081, 0.3508232077228117,    0, -0.0877058019307029, 0.175411603861406,
 -0.8164965809277259, 0.408248290463863, 0.4082482904638634 )

        eigi :        ( 4.000000, -4.000000,    0 )
        eigr :        ( 2       ,  2       , 0.999999 )


          ------ Eigenvalues -----
             Real      Imaginary
   (0)     2.0000        4.0000
   (1)     2.0000       -4.0000
   (2)     1.0000        0.0000


        ------ Eigenvectors: (NxN): printed as linear list -----
             Real      Imaginary
(0,0)      0.3162       -0.8771
(0,1)     -0.0000        0.2631
(0,2)      0.6325        0.3508
(1,0)      0.3162        0.0000
(1,1)      0.6325       -0.0877
(1,2)      0.0000        0.1754
(2,0)      0.4082       -0.8165
(2,1)      0.8165        0.4082
(2,2)      0.4082        0.4082


                       EIGENVECTORS
                    REAL      IMAGINARY

   (0)   left:   -0.8771        0.0000
   (1)   left:    0.2631       -0.0877
   (2)   left:    0.3508        0.1754

   (0)   left:   -0.8771       -0.0000
   (1)   left:    0.2631        0.0877
   (2)   left:    0.3508       -0.1754

   (0)   left:   -0.8165        0.0000
   (1)   left:    0.4082        0.0000
   (2)   left:    0.4082        0.0000

   ==================

   (0)  right:    0.3162        0.3162
   (1)  right:   -0.0000        0.6325
   (2)  right:    0.6325        0.0000

   (0)  right:    0.3162       -0.3162
   (1)  right:   -0.0000       -0.6325
   (2)  right:    0.6325       -0.0000

   (0)  right:    0.4082        0.0000
   (1)  right:    0.8165        0.0000
   (2)  right:    0.4082        0.0000


   The above matches the output for the right eigenvector from Matlab derived via:

A = [8.0  -1.0  -5.0; -4.0   4.0  -2.0; 18.0  -5.0  -7]

A =

     8    -1    -5
    -4     4    -2
    18    -5    -7

help eig
    Eigenvalues and eigenvectors.
    E = eig(X) is a vector containing the eigenvalues of a square
    matrix X.

    [V,D] = eig(X) produces a diagonal matrix D of eigenvalues and a
    full matrix V whose columns are the corresponding eigenvectors so
    that X*V = V*D.

[V,D] = eig(A)

V =

   0.3162 + 0.3162i   0.3162 - 0.3162i   0.4082
  -0.0000 + 0.6325i  -0.0000 - 0.6325i   0.8165
   0.6325             0.6325             0.4082


D =

   2.0000 + 4.0000i        0                  0
        0             2.0000 - 4.0000i        0
        0                  0             1.0000



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:01:33 +0800
# vim:set fdm=indent foldlevel=0:
