THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/weibull.shtml
THE_TITLE:weibull

weibull

   Derives the shape and scale parameters for the Weibull distribution via maximum likelihood estimates.

   [new.gif] Available in version 6.3.0 and later.

Prototype

        function weibull (
                x        : numeric,
                opt  [1] : logical,
                dims [*] : integer
        )

        return_val  :  float or double, see return value description below

Arguments

   x

   Array of any dimensionality. Missing values (x@_FillValue) are allowed.
   opt

   If opt=True, two options are available:
     * opt@nmin: An integer specifying the minimum number of non-missing values that must be present before computations
       will be performed. If fewer than nmin are present, missing values will be returned for the shape and scale
       parameters. Defaults to 75% of the number of points if not set.
     * opt@confidence: A float or double scalar specifying the desired confidence limits on the returned coefficients: 0.0
       <= confidence < 1.0. Actually, the (1-confidence) confidence limits will be calculated. If confidence=0.95, the 2.5%
       and 97.5% limits will be returned.

   dims

   The dimension(s) of x on which to calculate the Weibull distribution parameters.

Return value

   For each series specified by dims, the shape and scale will be returned.

       (0) = shape
       (1) = scale

   If opt@confidence is specified an additional 4 estimates are returned:

       (2) = shape low  confidence limit
       (3) = shape high confidence limit
       (4) = scale low  confidence limit
       (5) = scale high confidence limit

   The return type will be double if x is double, and float otherwise.

Description

   This function computes maximum likelihood estimates of the two parameter (shape and scale) Weibull distribution. This
   distribution is also known as the Extreme Value Type III distribution.
Reference

   Weibull Maximum Likelihood Parameter Estimates with Censored Data
   J. Bert Keats, Frederick P. Lawrence, and F. K. Wang
   Journal of Quality Technology, Volume 29, Number 1, pp. 105--110, January 1997

See Also

   ftest, rtest, betainc, kolsm2_n

Examples

   As always when fitting a distribution, it is best if the sample size is large.

   Example 1

           q   = (/0.01,0.08,0.13,0.16,0.55,0.90,1.11,1.62,1.79,1.59,1.83,1.68,2.09,2.17,2.66 \
                  ,2.08,2.26,1.65,1.70,2.39,2.08,2.02,1.65,1.96,1.91,1.30,1.62,1.57,1.32,1.56 \
                  ,1.36,1.05,1.29,1.32,1.20,1.10,0.88,0.63,0.69,0.69,0.49,0.53,0.42,0.48,0.41 \
                  ,0.27,0.36,0.33,0.17,0.20/)

           wF = weibull(q, False, 0)
           print(wF)

           opt = True
           opt@confidence = 0.95
           wT = weibull(q, opt, 0)
           print(wT)


will yield

           wF(0) = 1.509     ; shape
           wF(1) = 1.299     ; scale

   and
           wT(0) = 1.509     ; shape
           wT(1) = 1.299     ; scale
           wT(2) = 1.152     ; shape low  limit ( 2.5%)
           wT(3) = 1.867     ; shape high limit (97.5%)
           wT(4) = 1.051     ; scale low  limit ( 2.5%)
           wT(5) = 1.548     ; scale high limit (97.5%)


   An estimate of the Weibull location parameter may be obtained from:

           qavg = avg(q)                       ; data average
           wavg = wF(0)*gamma(1 + 1/wF(1))   ; theoretical Weibull avg
           wloc = qavg - wavg                  ; location parameter

           print("qavg="+qavg+"  wavg="+wavg+"  wloc="+wloc)
yields
           qavg=1.1862  wavg=1.3939  wloc=-0.207703

           ------------------------ R ---------------------------

   For comparison, the R software package [Note: 'library(MASS)' is required] returns

           library(MASS)
           qWeib <- fitdistr(q, "weibull")
           qWeib

                   shape       scale
                 1.5090848   1.2993179
                (0.1824047) (0.1268983)

           qWeibCon <- confint(qWeib)
           qWeibCon

                       2.5 %   97.5 %
                shape 1.151578 1.866591
                scale 1.050602 1.548034
           ------------------------ R ---------------------------

   Example 2 Same as Example 1 but
           q = q+10

   yields
           wF(0) = 17.37123   ; shape
           wF(1) = 11.52268   ; scale
and
           wT(0) = 17.37123   ; shape
           wT(1) = 11.52268   ; scale
           wT(2) = 13.66275
           wT(3) = 21.07971
           wT(4) = 11.32812
           wT(5) = 11.71724

           qavg=11.1862  wavg=16.621  wloc=-5.43483

           ------------------------ R ---------------------------

   The R software package returns

          shape         scale
        17.37123526   11.52268040
       ( 1.89211608) ( 0.09926876)
           ------------------------ R ---------------------------

   Example 3 Let p(ntim,nlat,mlon). Determine Weibull parameters at each grid location.
           wF  = weibull(p, False, 0)   ; wF(2,nlat,mlon)

           opt = True
           opt@confidence = 0.90
           wT = weibull(p, opt, 0)      ; wT(6,nlat,mlon)

   would return
           wF(0,:,:) ; shape
           wF(1,:,:) ; scale

   and
           wT(0,:,:) ; shape
           wT(1,:,:) ; scale
           wT(3,:,:) ; shape low  limit ( 5.0%)
           wT(4,:,:) ; shape high limit (95.0%
           wT(4,:,:) ; scale low  limit ( 5.0%)
           wT(5,:,:) ; scale high limit (95.0%)


Example 4 Let wind(ntim,nlat,mlon). Determine Weibull parameters at each grid location.
Let's require that at least 48 values must be present.

           opt      = True
           opt@nmin = 48
           wndp = weibull(wind, opt, 0)   ; wndp(2,nlat,mlon)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:15:01 +0800
# vim:set fdm=indent foldlevel=0:
