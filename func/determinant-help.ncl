THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/determinant.shtml
THE_TITLE:determinant

determinant

   Calculates the determinant of a square real matrix.

   [new.gif] Available in version 6.3.0 and later.

Prototype

        function determinant (
                x [*][*] : numeric
        )

        return_val [1] :  float or double

Arguments

   x

   A two-dimensional variable of numeric type. The dimension sizes must be the same (i.e. [N][N])

Return value

   A scalar of type double if x is type double; otherwise the returned value will be type float.

Description

   The determinant of the square (NxN) matrix is calculated using the partial-pivoting Gaussian elimination scheme.

See Also

   solve_linsys

Examples

   Example 1

   a = (/ (/ 1, 0, 2, -1/) \   ; N=4
        , (/ 3, 0, 0,  5/) \
        , (/ 2, 1, 4, -3/) \
        , (/ 1, 0, 5,  0/) /)

   d = determinant(a)          ; d=30.0


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:01:30 +0800
# vim:set fdm=indent foldlevel=0:
