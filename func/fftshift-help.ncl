THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/fftshift.shtml
THE_TITLE:fftshift

fftshift

   Rearranges an array in a manner similar to Matlab's fftshift function.

   [new.gif] Available in version 6.3.0 and later.

Prototype

        function fftshift (
                x        : numeric,
                mode [1] : integer
        )

        return_val  :  same size, shape and type as x

Arguments

   x

   A vector or multidimensional array. If there are two or more dimensions, the two rightmost dimensions will be the
   rearranged.
   mode

   Type of rearrangement (shift) to be performed.

Return value

   An array of the same size, type and shape as x with the elements rearranged.

Description

   See the Matlab description of fftshift. Also, see the examples below.

See Also

   reshape, reshape_ind, conform, conform_dims, ndtooned, onedtond

Examples

   Example 1

   Using fftshift on a vector (i.e., a one-dimensional array).

   f      = (/ 0.0, 0.1,  0.2,  0.3,  0.4, 0.5, -0.5, -0.4, -0.3, -0.2, -0.1 /)
   fshift = fftshift(f, 0)
   print(fshift)

   This would yield 0.0 in the middle.

   fshift = (/ -0.5, -0.4, -0.3, -0.2, -0.1,  0.0, 0.1,  0.2,  0.3,  0.4, 0.5/)

   Example 2

   Using fftshift on an even number of rows and columns:

    nrow  = 6
    ncol  = 6
    N     = nrow*ncol
    a     = onedtond(fspan(1,N,N), (/nrow,ncol/))

    print(" ")
    print("--- Original Array ---")
    write_matrix (x, ncol+"f7.2", False)

    x = fftshift(a, 0)
    print("---mode= 0     quadrant shift")
    write_matrix (x, ncol+"f7.2", False)

    y = fftshift(a, 1)
    print("---mode= 1     column shift")
    write_matrix (y, ncol+"f7.2", False)

    z = fftshift(a,-1)
    print("---mode= -1    row shift")
    write_matrix (y, ncol+"f7.2", False)

   This would yield:

           original array: a (6,6)

   1.00   2.00   3.00   4.00   5.00   6.00
   7.00   8.00   9.00  10.00  11.00  12.00
  13.00  14.00  15.00  16.00  17.00  18.00
  19.00  20.00  21.00  22.00  23.00  24.00
  25.00  26.00  27.00  28.00  29.00  30.00
  31.00  32.00  33.00  34.00  35.00  36.00

       ---mode= 0     quadrant shift: x

  22.00  23.00  24.00  19.00  20.00  21.00
  28.00  29.00  30.00  25.00  26.00  27.00
  34.00  35.00  36.00  31.00  32.00  33.00
   4.00   5.00   6.00   1.00   2.00   3.00
  10.00  11.00  12.00   7.00   8.00   9.00
  16.00  17.00  18.00  13.00  14.00  15.00

      ---mode= 1     columns shift: y

   4.00   5.00   6.00   1.00   2.00   3.00
  10.00  11.00  12.00   7.00   8.00   9.00
  16.00  17.00  18.00  13.00  14.00  15.00
  22.00  23.00  24.00  19.00  20.00  21.00
  28.00  29.00  30.00  25.00  26.00  27.00
  34.00  35.00  36.00  31.00  32.00  33.00

      ---mode=-1     row     shift: z

  19.00  20.00  21.00  22.00  23.00  24.00
  25.00  26.00  27.00  28.00  29.00  30.00
  31.00  32.00  33.00  34.00  35.00  36.00
   1.00   2.00   3.00   4.00   5.00   6.00
   7.00   8.00   9.00  10.00  11.00  12.00
  13.00  14.00  15.00  16.00  17.00  18.00

==================================================

   Example 3

   Using fftshift on an even number of rows and an odd number of columns:

    nrow  = 6
    ncol  = 5
    N     = nrow*ncol

   The results are:

        --- Original Array (6,5) ---

   1.00   2.00   3.00   4.00   5.00
   6.00   7.00   8.00   9.00  10.00
  11.00  12.00  13.00  14.00  15.00
  16.00  17.00  18.00  19.00  20.00
  21.00  22.00  23.00  24.00  25.00
  26.00  27.00  28.00  29.00  30.00

        ---mode= 0     quadrant shift

  19.00  20.00  16.00  17.00  18.00
  24.00  25.00  21.00  22.00  23.00
  29.00  30.00  26.00  27.00  28.00
   4.00   5.00   1.00   2.00   3.00
   9.00  10.00   6.00   7.00   8.00
  14.00  15.00  11.00  12.00  13.00

        ---mode= 1     column shift

   4.00   5.00   1.00   2.00   3.00
   9.00  10.00   6.00   7.00   8.00
  14.00  15.00  11.00  12.00  13.00
  19.00  20.00  16.00  17.00  18.00
  24.00  25.00  21.00  22.00  23.00
  29.00  30.00  26.00  27.00  28.00

        ---mode=-1     row    shift

  16.00  17.00  18.00  19.00  20.00
  21.00  22.00  23.00  24.00  25.00
  26.00  27.00  28.00  29.00  30.00
   1.00   2.00   3.00   4.00   5.00
   6.00   7.00   8.00   9.00  10.00
  11.00  12.00  13.00  14.00  15.00

   Example 4

   Using fftshift on an odd number of rows and an even number of columns:

    nrow  = 5
    ncol  = 6
    N     = nrow*ncol

   The results are:

        --- Original Array (5,6)---


   1.00   2.00   3.00   4.00   5.00   6.00
   7.00   8.00   9.00  10.00  11.00  12.00
  13.00  14.00  15.00  16.00  17.00  18.00
  19.00  20.00  21.00  22.00  23.00  24.00
  25.00  26.00  27.00  28.00  29.00  30.00

        ---mode=0     quadrant shift

  22.00  23.00  24.00  19.00  20.00  21.00
  28.00  29.00  30.00  25.00  26.00  27.00
   4.00   5.00   6.00   1.00   2.00   3.00
  10.00  11.00  12.00   7.00   8.00   9.00
  16.00  17.00  18.00  13.00  14.00  15.00

        ---mode=1     column shift

   4.00   5.00   6.00   1.00   2.00   3.00
  10.00  11.00  12.00   7.00   8.00   9.00
  16.00  17.00  18.00  13.00  14.00  15.00
  22.00  23.00  24.00  19.00  20.00  21.00
  28.00  29.00  30.00  25.00  26.00  27.00

        ---mode=-1     row    shift

  19.00  20.00  21.00  22.00  23.00  24.00
  25.00  26.00  27.00  28.00  29.00  30.00
   1.00   2.00   3.00   4.00   5.00   6.00
   7.00   8.00   9.00  10.00  11.00  12.00
  13.00  14.00  15.00  16.00  17.00  18.00

   Example 5

   Using fftshift on an odd number of rows and columns:

    nrow  = 5
    ncol  = 5
    N     = nrow*ncol

   The results are:

        --- Original Array ---

   1.00   2.00   3.00   4.00   5.00
   6.00   7.00   8.00   9.00  10.00
  11.00  12.00  13.00  14.00  15.00
  16.00  17.00  18.00  19.00  20.00
  21.00  22.00  23.00  24.00  25.00

        ---mode= 0     quadrant shift

  19.00  20.00  16.00  17.00  18.00
  24.00  25.00  21.00  22.00  23.00
   4.00   5.00   1.00   2.00   3.00
   9.00  10.00   6.00   7.00   8.00
  14.00  15.00  11.00  12.00  13.00

        ---mode= 1     column shift

   4.00   5.00   1.00   2.00   3.00
   9.00  10.00   6.00   7.00   8.00
  14.00  15.00  11.00  12.00  13.00
  19.00  20.00  16.00  17.00  18.00
  24.00  25.00  21.00  22.00  23.00

        ---mode=-1     row    shift

  16.00  17.00  18.00  19.00  20.00
  21.00  22.00  23.00  24.00  25.00
   1.00   2.00   3.00   4.00   5.00
   6.00   7.00   8.00   9.00  10.00
  11.00  12.00  13.00  14.00  15.00


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:03:59 +0800
# vim:set fdm=indent foldlevel=0:
