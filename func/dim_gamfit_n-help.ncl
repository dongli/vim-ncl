THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/dim_gamfit_n.shtml
THE_TITLE:dim_gamfit_n

dim_gamfit_n

   Fit data to the two parameter gamma distribution.

   [new.gif] Available in version 6.1.0 and later.

Prototype

        function dim_gamfit_n (
                x        : numeric,  ; float, double
                optgam   : logical,
                dims [*] : integer
        )

        return_val  :  float or double

Arguments

   x

   A variable of type 'float' or 'double' and any dimensionality. Since a distribution is being fit, there should be a
   'reasonably' large sample size (say, at least 30 values).
   optgam

   If optgam=False, an estimate of the returned parameters will be provided regardless of the number of non-missing
   (_FillValue) observations.

   If optgam=True, the following attributes can be associated with optgam:
     * optgam@inv_scale=True, the returned 'scale' value will be (1/scale). The default is optgam@inv_scale=False.
     * optgam@pcrit specifies the minimum percent of observations required for parameters to be returned. The default is
       pcrit=0. So, if it is desired that (say) 75% of the observation must be nonmissing, then

       optgam = True
       optgam@pcrit = 75


   dims

   The dimension(s) of x on which to estimate the distribution parameters. Usually, this is the record ('time') dimension.

Return value

   The estimated parameters returned will be the same type as x. The leftmost dimension will be size 3. The order will be
   [0] shape; [1] scale; [2] unconditional probability ( 0.0 <=> 1.0 ) of a 0.0 observation).

Description

   The dim_gamfit_n will return estimates of the shape and scale of the 2-parameter gamma distribution. These estimates are
   derived using maximum likelihood as described in

        A Note on the Gamma Distribution
        Thom (1958): Monthly Weather Review, pp 117-122.
                     specifically: eqn 22 for gamma; just above eqn 21
        http://water.usgs.gov/osw/bulletin17b/MWR_Thom_1958.pdf


   In addition, a third value, the unconditional probability of encountering an observation equal to zero is returned. The
   latter parameter has nothing to do with the gamma distribution. However, this function was included to analyze
   precipitation observations and this 3rd parameter is useful for certain applications.

   The 2-parameter gamma distribution is modeled via:
    gamma2_distribution = (x^(shape-1) * exp( -x/scale )) / (scale^shape * gamma(shape))

   Note_1: The scale is returned as [1/scale] in some applications. This is called the rate.

   Note_2: As an aside, the scale and shape parameters for the classic two-parameter gamma distribution can be estimated via
   the "method of moments".

     m1    = avg(x)           ; 1st moment
     m2    = avg(x^2)         ; 2nd moment

or, if (say) x(time,lat,lon)

     m1    = dim_avg_n(x,0)   ; 1st moment
     m2    = dim_avg_n(x^2,0) ; 2nd moment

then

     shape = m1^2 / (m2 - m1^2)              ; gamma
     scale = (m2 - m1^2) / m1                ; beta

----------
Zhou Xin (11 Aug 2015) provided the following information:

     I looked at the source codes used by dim_gamfit_n() and cdfgam_p(). If I understood it correctly,
     the "SCALE" parameter in dim_gamfit_n() means "beta" in the Thom (1958) paper Eqn (1), while
     the "SCALE" parameter in cdfgam_p() means "1/beta". So when using the output of dim_gamfit_n()
     for cdfgam_p(), the "SCALE" parameter has to be inverted.


See Also

   dim_spi_n

Examples

   Example 1

       ; The following data were from: http://www.wessa.net/rwasp_fitdistrgamma.wasp
     g = (/112,118,132,129,121,135,148,148,136,119,104,118 \
          ,115,126,141,135,125,149,170,170,158,133,114,140 \
          ,145,150,178,163,172,178,199,199,184,162,146,166 \
          ,171,180,193,181,183,218,230,242,209,191,172,194 \
          ,196,196,236,235,229,243,264,272,237,211,180,201 \
          ,204,188,235,227,234,264,302,293,259,229,203,229 \
          ,242,233,267,269,270,315,364,347,312,274,237,278 \
          ,284,277,317,313,318,374,413,405,355,306,271,306 \
          ,315,301,356,348,355,422,465,467,404,347,305,336 \
          ,340,318,362,348,363,435,491,505,404,359,310,337 \
          ,360,342,406,396,420,472,548,559,463,407,362,405 \
          ,417,391,419,461,472,535,622,606,508,461,390,432 /)

       ; Fit the 2-parameter (shape and scale) gamma distribution via the "method of moments"

     g1   = avg(g)
     g2   = avg(g^2)

     gshape = g1^2 / (g2 - g1^2)    ; alpha
     gscale = (g2 - g1^2) / g1      ; beta

     print("gshape = "+gshape)
     print("gscale = "+gscale)

       ; Estimate the 2-parameter gamma distribution via maximum likelihood

     gpar = dim_gamfit_n(g, False, 0)   ; gpar(3)
     print(gpar)


   The online results, which returned rate (=1/scale) were:

     shape=gamma=5.459,  rate=0.019476 ==>  scale= (1/rate) = 51.345


   NCL's (edited) results from dim_gamfit_n are
                               ; Method of Moments
(0)     gshape  =  5.4973      ; shape
(0)     gscale  = 50.9884      ; scale

                               ; dim_gamfit_n
(0)     gpar[0] =  5.49911     ; shape
(0)     gpar[1] = 50.9716      ; scale
(0)     gpar[2] =  0.0         ; pzero

   Example 2

   If x(time,lat,lon) and it is desired that 60% of the values be present at each grid point before the parameters are
   calculated. Also, return the inverse scale (1/scale).

     gopt = True
     gopt@pcrit     = 60.0
     gopt@inv_scale = True
     xpar = dim_gamfit_n(x, gopt, 0)   ; xpar(3,nlat,mlon)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:01:42 +0800
# vim:set fdm=indent foldlevel=0:
