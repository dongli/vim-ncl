THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/regline_stats.shtml
THE_TITLE:regline_stats

regline_stats

   Performs simple linear regression including confidence estimates, an ANOVA table and 95% mean response estimates.

   [new.gif] Available in version 6.2.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function regline_stats (
                x [*] : numeric,
                y [*] : numeric
        )

        return_val [1] :  float or double with many attributes

Arguments

   x

   A one dimensional array of size N containing the independent variable. Missing values, indicated by _FillValue, are
   allowed but are ignored.

   NOTE: For the computations, the x can be in any order. However, subsequent use for plotting lines often requires that the
   x be in monotonically {in/de}creasing order. See Example 2 below.
   y

   A one-dimensional array of length N containing the corresponding dependent variable. Missing values, indicated by
   _FillValue, are allowed but are ignored.

Return value

   A scalar containing the calculated linear regression coefficient. In addition, many statistical quantities are returned
   as attributes of b. THe 95% limits were introduced in version 6.3.1.

   The return value will be of type double if x or y is double, and float otherwise.

Description

   regline_stats performs a simple linear regression. The calculated regresssion coefficient represents the rate of change
   in the dependent variable for a unit change in the independent variable. This coefficient is sometimes referred to as the
   slope or trend.

   The user may wish to take into account the uncertainty associated with each estimated parameter and the overall
   uncertainty. This information is returned as the attributes stderr, tval and pval. In addition, an ANalysis Of VAriance
   [ANOVA] table is returned.

   Any missing values are ignored., Missing values should be indicated by the _FillValue attribute.

   Chad Hermann created a function linreg which derived many of the same statistics. It is written entirely in NCL and is
   here.

   Debasish Mazumder (NCAR/RAL) submitted code for the 95% mean response about the regression line. This was included within
   the regline_stats in the 6.3.1 release of NCL. A reference for this is Chapter 11 of
        Applied Statistics and Probability for Engineers
        D. C. Montgomery and G. C. Runge
        ISBN: 0471204544

See Also

   regline, reg_multlin, reg_multlin_stats

Examples

   See examples regress_1a.ncl and regress_1b.ncl for plot and usage of returned information. Example 1

   The following example was taken from:

    Brownlee
    Statistical Theory and Methodology
    J Wiley 1965   pgs: 342-346     QA276  .B77


   See example regress_1a.ncl for plot and usage of returned information.

      x    = (/ 1190.,1455.,1550.,1730.,1745.,1770. \
             ,  1900.,1920.,1960.,2295.,2335.,2490. \
             ,  2720.,2710.,2530.,2900.,2760.,3010. /)

      y    = (/ 1115.,1425.,1515.,1795.,1715.,1710. \
             ,  1830.,1920.,1970.,2300.,2280.,2520. \
             ,  2630.,2740.,2390.,2800.,2630.,2970. /)


   rc =  regline_stats(x,y) ; linear regression coef
   print(rc)


   The print(rc) yielded the following (edited) output. All the comments were manually added.

        Variable: rc
        Type: float
        Total Size: 4 bytes
                    1 values
        Number of Dimensions: 1
        Dimensions and sizes:   [1]
        Coordinates:
        Number Of Attributes: 38
          _FillValue :  9.96921e+36

          long_name :   simple linear regression
          model :       Yest = b(0) + b(1)*X

          N :   18                              ; # of observations
          NP :  1                               ; # of predictor variables
          M :   2                               ; # of returned coefficients
          bstd :        (  0, 0.9947125 )       ; standardized regression coefficient
                                                ; [ignore 1st element]

                                                ; ANOVA information: SS=>Sum of Squares
          SST : 4823324                         ; Total SS:      sum((Y-Yavg)^2)
          SSE : 50871.91                        ; Residual SS:   sum((Yest-Y)^2)
          SSR : 4772452                         ; sum((Yest-Yavg)^2)

          MST : 283724.9
          MSE : 3179.494
          MSE_dof :     16
          MSR : 4772452

          RSE : 56.387                          ; residual standard error; sqrt(MSE)
          RSE_dof :     15

          F :   1501.01                         ; MSR/MSE
          F_dof :       ( 1, 16 )
          F_pval :      1.51066e-17

          r2 :  0.989453                        ; square of the Pearson correlation coefficient
          r :   0.9947125                       ; multiple (overall) correlation: sqrt(r2)
          r2a : 0.9887938                       ; adjusted r2... better for small N

          fuv : 0.01054698                      ; (1-r2): fraction of variance of the regressand
                                                ; (dependent variable) Y which cannot be explained
                                                ;  i.e., which is not correctly predicted, by the
                                                ; explanatory variables X.

          Yest :        [ARRAY of 18 elements]  ; Yest = b(0) + b(1)*x
          Yavg :        2125.278                ; avg(y)
          Ystd :        532.6583                ; stddev(y)
          Xavg :        2165                    ; avg(x)
          Xstd :        543.6721                ; stddev(x)

          stderr :      ( 56.05802, 0.02515461 )     ; std. error of each b
          tval :        ( 0.2738642, 38.74285 )      ; t-value
          pval :        ( 0.7874895, 5.017699e-18 )  ; p-value

                                                ; following added in version 6.3.1
          b95  :        ( 0.9212361, 1.027887 ) ;  2.5% and 97.5% regression coef. confidence intervals
          y95  :        ( -459.9983, 490.703 )  ;  2.5% and 97.5% y-intercept confidence intervals
          YMR025 :      [ARRAY of 18 elements]  ;  2.5% mean response
          YMR975 :      [ARRAY of 18 elements]  ; 97.5% mean response
          YPI025 :      [ARRAY of 18 elements]  ;  2.5% predition interval
          YPI975 :      [ARRAY of 18 elements]  ; 97.5% predition interval

                                                ; Original regline attributes
                                                ; provided for backward cmpatibility
          nptxy :       18
          xave :        2165
          yave :        2125.278
          rstd :        56.387
          yintercept :  15.35228

          b :   ( 15.35228, 0.9745615 )         ; b(0) + b(1)*x

        (0)     0.9745615                       ; regression coefficient


   Example 2

   The following example was taken from: http://www.stat.ucla.edu/~hqxu/stat105/pdf/ch11.pdf. It is a commonly used WWW
   example. Here the independent values (x) and associated dependent variables (y) are placed into ascending order for
   subsequent plotting.

   See example regress_1b.ncl for plot and usage of returned information.


;                      Hydrocarbon level (%)
    x  = (/ 0.99, 1.02, 1.15, 1.29, 1.46, 1.36, 0.87, 1.23, 1.55, 1.40  \
          , 1.19, 1.15, 0.98, 1.01, 1.11, 1.20, 1.26, 1.32, 1.43, 0.95 /)
;                             Purity     (%)
    y  = (/ 90.01, 89.05, 91.43, 93.74, 96.73, 94.45, 87.59, 91.77, 99.42, 93.65  \
          , 93.54, 92.52, 90.56, 89.54, 89.85, 90.39, 93.25, 93.41, 94.98, 87.33  /)

; It is recommended that the independent variable be monotonically {in/de}creasing
; Not necessary for computations but it makes subsequent plotting easier.

    ii =  dim_pqsort_n(x,1,0)
    xx = x(ii)
    yy = y(ii)

; perform regression on the reordered arrays

    rc =  regline_stats(xx,yy) ; linear regression coef
    print(rc)


   yielded

        Variable: rc
        Type: float
        Total Size: 4 bytes
                    1 values
        Number of Dimensions: 1
        Dimensions and sizes:   [1]
        Coordinates:
        Number Of Attributes: 41
          _FillValue :  9.96921e+36
          long_name :   simple linear regression

          model :       Yest = b(0) + b(1)*X
          N :   20
          NP :  1
          M :   2
          bstd :        (  0, 0.9367155 )
          SST : 173.3769
          SSE : 21.24981
          SSR : 152.1272
          MST : 9.125101
          MSE : 1.180545
          MSE_dof :     18
          MSR : 152.1272
          RSE : 1.086529
          RSE_dof :     17
          F :   128.8618
          F_dof :       ( 1, 18 )
          F_pval :      1.227305e-09
          r2 :  0.8774363
          r :   0.9367157
          r2a : 0.8706272
          fuv : 0.1225637
          Yest :        [ARRAY of 20 elements]
          Yavg :        92.1605
          Ystd :        3.020778
          Xavg :        1.196
          Xstd :        0.1893034
          stderr :      ( 1.593479, 1.316763 )
          tval :        ( 46.61706, 11.35169 )
          pval :        ( 4.660713e-21, 6.580665e-10 )
          nptxy :       20
          xave :        1.196
          yave :        92.1605
          rstd :        1.086529
          yintercept :  74.28331

          b :   ( 74.28331, 14.94748 )
          b95 : ( 12.18108, 17.71389 )
          y95 : ( 60.07995, 88.48667 )
          YMR025 :      [ARRAY of 20 elements]  ;  2.5% mean response
          YMR975 :      [ARRAY of 20 elements]  ; 97.5% mean response
          YPI025 :      [ARRAY of 20 elements]  ;  2.5% predition interval
          YPI975 :      [ARRAY of 20 elements]  ; 97.5% predition interval

        (0)     14.94748


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:19:42 +0800
# vim:set fdm=indent foldlevel=0:
