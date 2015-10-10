THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/covcorm_xy.shtml
THE_TITLE:covcorm_xy

covcorm_xy

   Calculates a covariance or correlation matrix given two separate 'n x m' arrays.

   [new.gif] Available in version 6.1.1 and later.

Prototype

        function covcorm_xy (
                x [*][*] : numeric,
                y [*][*] : numeric,
                iopt [3] : integer
        )

        return_val  :  numeric

Arguments

   x

   Data array of size(nrow,ncol). Missing values (_FillValue) are allowed.
   y

   Same size and shape as x.
   iopt

   An integer vector of length 3.
     * iopt(0)=0 means return the covariance matrix.
     * iopt(0)=1 means return the correlation matrix.

     * iopt(1) refers to the lag. This must be greater than or equal to zero. Generally, iopt(1)=0. If iopt(1)=lag then the
       following is computed: x(i,t)*y(j,t-lag).

     * iopt(2) is the percent of missing values to allow for any one covariance/correlation pair. iopt(2)=0 means all values
       of a time series must be present.

Return value

   See the description of iopt. The return numeric type will be double if x or y is double and float otherwise.

Description

   Standard calculation of covariance or correlation matrix. The original matrix may have to be reshaped to a
   two-dimensional array. The reshaping may be accomplished by the ndtooned and onedtond functions.

   Missing values (x@_FillValue) are allowed. However, interpretation of statistics derived from an input array, x,
   containing missing values should be done with appropriate caution because the elements of the derived covariance or
   correlation matrix will use differing numbers of values. Further, if all the values for a particular column are missing,
   the result will be a missing value ( _FillValue ).

See Also

   eofunc, ndtooned, onedtond, covcorm, dgeevx_lapack

Examples

   The following examples use data from:
  Statistics and Data Analysis in Geology
  John C Davis
  John Wiley and Sons: 2002:   3rd Edition:

   Specifically, the following data which are contained within the ascii text file: "BOXES.TXT". For convenience, consider
   the rows as samples in time and the columns to be stations or grid points.

  3.760  3.660  0.540  5.275  9.768 13.741  4.782
  8.590  4.990  1.340 10.022  7.500 10.162  2.130
  6.220  6.140  4.520  9.842  2.175  2.732  1.089
  7.570  7.280  7.070 12.662  1.791  2.101  0.822
  9.030  7.080  2.590 11.762  4.539  6.217  1.276
  5.510  3.980  1.300  6.924  5.326  7.304  2.403
  3.270  0.620  0.440  3.357  7.629  8.838  8.389
  8.740  7.000  3.310 11.675  3.529  4.757  1.119
  9.640  9.490  1.030 13.567 13.133 18.519  2.354
  9.730  1.330  1.000  9.871  9.871 11.064  3.704
  8.590  2.980  1.170  9.170  7.851  9.909  2.616
  7.120  5.490  3.680  9.716  2.642  3.430  1.189
  4.690  3.010  2.170  5.983  2.760  3.554  2.013
  5.510  1.340  1.270  5.808  4.566  5.382  3.427
  1.660  1.610  1.570  2.799  1.783  2.087  3.716
  5.900  5.760  1.550  8.388  5.395  7.497  1.973
  9.840  9.270  1.510 13.604  9.017 12.668  1.745
  8.390  4.920  2.540 10.053  3.956  5.237  1.432
  4.940  4.380  1.030  6.678  6.494  9.059  2.807
  7.230  2.300  1.770  7.790  4.393  5.374  2.274
  9.460  7.310  1.040 11.999 11.579 16.182  2.415
  9.550  5.350  4.250 11.742  2.766  3.509  1.054
  4.940  4.520  4.500  8.067  1.793  2.103  1.292
  8.210  3.080  2.420  9.097  3.753  4.657  1.719
  9.410  6.440  5.110 12.495  2.446  3.103  0.914

   Example 1

   Compute the covariance matrix [iopt(0)=0]. This is a test code because array x and y are the same. Hence, the returned
   array is symmetric.

       diri     = "./"
       fili     = "BOXES.TXT"
                                          ; read the entire data array
       ntim     = 25                      ; number of observations [number of time steps]
       mpts     = 7                       ; number of variables or grid points
       x        = asciiread( diri+fili, (/ntim,mpts/), "float")
       x!0      = "time"                  ; name the dimensions
       x!1      = "gridpts"
       y        = x                       ; y is identical to x

       cov_xy   = covcorm_xy( x(gridpts|:,time|:), y(gridpts|:,time|:), (/0,0,0/)  )
       write_matrix(cov_xy, mpts+"f8.2", False)

   The covariance values, which are symmetric when x=y, are:

    5.40    3.26    0.78    6.39    2.16    3.04   -2.00
    3.26    5.85    1.46    6.08    1.31    2.88   -2.37
    0.78    1.46    2.77    2.20   -3.84   -5.17   -1.74
    6.39    6.08    2.20    9.11    1.61    2.78   -3.28
    2.16    1.31   -3.84    1.61   10.71   14.77    2.25
    3.04    2.88   -5.17    2.78   14.77   20.78    2.62
   -2.00   -2.37   -1.74   -3.28    2.25    2.62    2.59


   If iopt=(/1,0,0/) then the return symmetric correlation array would be:

    1.00    0.58    0.20    0.91    0.28    0.29   -0.53
    0.58    1.00    0.36    0.83    0.17    0.26   -0.61
    0.20    0.36    1.00    0.44   -0.70   -0.68   -0.65
    0.91    0.83    0.44    1.00    0.16    0.20   -0.68
    0.28    0.17   -0.70    0.16    1.00    0.99    0.43
    0.29    0.26   -0.68    0.20    0.99    1.00    0.36
   -0.53   -0.61   -0.65   -0.68    0.43    0.36    1.00


   Example 2

   Same as Example 1 but a random number has been is added to array y. The returned covariance and correlation arrays are
   not symmetric.

       y        = x+random_uniform(-2,2,dimsizes(x))       ; y will not be the same as x


   The non-symmetric covariance matrix would be

    5.31    2.57    0.78    5.94    1.78    2.33   -1.70
    4.24    7.48    1.88    7.82    1.52    3.48   -3.34
    0.82    1.84    2.75    2.37   -3.86   -5.07   -1.78
    6.27    5.89    2.34    8.94    1.55    2.65   -3.14
    2.91    1.55   -3.80    2.38   10.86   14.88    2.00
    3.57    3.08   -4.80    3.49   14.75   20.73    2.26
   -1.94   -2.72   -1.51   -3.34    1.94    2.13    2.39


   If iopt=(/1,0,0/) then the return non-symmetric correlation array would be:

    0.92    0.43    0.19    0.79    0.22    0.20   -0.42
    0.57    0.96    0.35    0.80    0.14    0.24   -0.64
    0.18    0.39    0.85    0.40   -0.60   -0.57   -0.57
    0.85    0.76    0.44    0.93    0.15    0.18   -0.61
    0.36    0.18   -0.66    0.23    0.95    0.94    0.36
    0.33    0.27   -0.62    0.25    0.96    0.97    0.30
   -0.47   -0.63   -0.51   -0.62    0.33    0.26    0.83



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:00:28 +0800
# vim:set fdm=indent foldlevel=0:
