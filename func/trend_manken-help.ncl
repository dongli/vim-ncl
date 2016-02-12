THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/trend_manken.shtml
THE_TITLE:trend_manken

trend_manken

   Mann-Kendall non-parametric test for monotonic trend and, optionally, the Theil-Sen robust estimate of linear trend.

   [new.gif] Available in version 6.3.1 and later.

Prototype

        function trend_manken (
                x       : numeric,
                opt [1] : logical,
                dims    : integer
        )

        return_val  :  float or double

Arguments

   x

   Series to be tested. If there is a strong seasonal cycle, the data should be deseasonalized, prior to input. The
   successive input values are assummed to be independent and evenly spaced. The series must be at least 10 values.
   Currently, missing values are not allowed.
   dims

   The dimension(s) of x on which to calculate the average. Must be consecutive and monotonically increasing.
   opt

   If opt=True only the Mann-Kendall statistic is returned.

   If opt=False, both the Mann-Kendall non-parametric test for monotonic trend and the Theil-Sen robust estimate of linear
   trend are returned. NOTE: for large arrays with very long time series specifying this option will result in a large
   memory requirement and slower execution. This is because internally the slope estimates must be stored [ N*(N-1)/2, where
   N is the length of the time series ] and subsequently sorted into ascending order.

Return value

   The Mann-Kendall trend significance and, optionally, the Theil-Sen estimate of linear trend (aka, Sen trend estimate)
   will be returned for series. The output will be double if x is double, and float otherwise.

   The output dimensionality is best described via examples: The dimension rank of the input variable will be reduced by the
   rank of dims and an 'extra' dimension of size 2 will be prepended. Let NT refer to the 'time' dimension; KZ,NY,MX refer
   to spatial dimensions and NE refer to an ensemble dimension.

   x(NT)            : p=trend_manken(x,False,0) => p(2) where p(0)=probability,  p(1)=trend
   x(NT,NY,MX)      : p=trend_manken(x,False,0) => p(2,NY,MX)
   x(NY,MX,NT)      : p=trend_manken(x,False,2) => p(2,NY,MX)
   x(NT,KZ,NY,MX)   : p=trend_manken(x,False,0) => p(2,KZ,NY,MX)
   x(NE,NT,KZ,NY,MX): p=trend_manken(x,False,1) => p(2,NE,KZ,NY,MX)

Description

   The Mann-Kendall (M-K) test is a non-parametric (ie, distribution free) test used to detect the presence of linear or
   non-linear trends in time series data. The M-K test assesses if a series is steadily increasing/decreasing or unchanging.

   The null hypothesis is that there is no trend. The three alternative hypotheses are that there is a negative, non-null,
   or positive trend.

   The series should be pre-whitened if serial correlation exits and/or deseasonalized if an annual cycle is present.

   The M-K test is based on the relative ranking of the data values. Ties are allowed and appropriate corrections are made
   to the variance. The S statistic used to estimate the significance is calculated via:
                                           = 1 (X(k)-X(i)) > 0
         S = SUM[ SIGN((X(k)-X(i)) ]       = 0  X(k)=X(i)
                                           =-1 (X(k)-X(i)) < 0

   The Theil-Sen trend estimate is a robust estimate of linear trend. It is the median of slopes between all data pairs.
         trend = MEDIAN[ (X(k)-X(i))/(k-i) ]  ; all i < k

   The Theil-Sen trend estimation method "is insensitive to outliers; it can be significantly more accurate than simple
   linear regression for skewed and heteroskedastic data, and competes well against non-robust least squares even for
   normally distributed data in terms of statistical power. It has been called 'the most popular nonparametric technique for
   estimating a linear trend'."

   A nice description for the Thiel-Sen estimate and simple linear regression is here.

   The underlying code follows the first part of:
       http://vsp.pnnl.gov/help/Vsample/Design_Trend_Mann_Kendall.htm

   The following illustrates usage:

            Mondal et al (2012): RAINFALL TREND ANALYSIS BY MANN-KENDALL TEST:
                            A CASE STUDY OF NORTH-EASTERN PART OF CUTTACK DISTRICT, ORISS

       International Journal of Geology, Earth and Environmental Sciences ISSN: 2277-2081 (Online)
       An Online International Journal Available at http://www.cibtech.org/jgee.htm
       2012 Vol. 2 (1) January-April,  pp.70-78/Mondal et al.

See Also

   regline_stats, regline, ttest, rtest, betainc

Examples

   Please see: Mann-Kendall Regression & Trend Examples 1 and 2

   Example 1 Some pathological examples with the probability (significance) and Theil-Sen trend estimate indicated to the
   right:
     a  = ispan(1,20,1)
     pa = trend_manken(a, False, 0)     ; pa(0)=1.0   ,   pa(1)=1.0

     b  = (/1,2,3,4,5,6,5,4,3,2,1/)
     pb = trend_manken(b, False, 0)     ; pb(0)=0.0   ,   pb(1)=0.0

     c  = (/-1,2,-3,4,-5,6,-7,8,-9,10,-11,12/)
     pc = trend_manken(c, False, 0)     ; pc(0)=0.2683,   pc(1)=1.0

   For comparison, on the last example R (after loading the 'Kendall' library) returns:
    < library(Kendall)
    > q  <- c(-1,2,-3,4,-5,6,-7,8,-9,10,-11,12)
    > x  <- c(1,2,3,4,5,6,7,8,9,10,11,12)
    > qx <-Kendall(x,y)
    > qx

      tau = 0.0909, 2-sided pvalue =0.7317    (Note: 1-0.7317= 0.2683 which matches NCL)

   Example 2 Read a time series of global anomalies and calculate the significance and the Thiel-Sen trend estimate. The
   data are annual means and reside in column 2 of the input file. The file structure is described here.
   diri = "./"
   fili = "TA_Globe.1850-2014.txt"
   pthi = diri+fili

   nrow = numAsciiRow(pthi)
   data = asciiread(pthi,(/nrow,12/),"float")

   ta   = data(:,1)   ; for clarity

   opt  = False
   pt   = trend_manken(ta, opt, 0)   ; ===> pt(0)=1.000  pt(1)= 0.004


   The overall trend is 0.00443 per year (~0.04 C/decade) for 1850-2014. However, the series is perhaps better analyzed by
   partitioning the series into two periods (1850-1929) and (1930-2014). In the 1st period, the trend was ~0.0 while in the
   latter half the trend was 0.08 C/decade.

   Example 3 Consider q(time,lat,lon) Calculate the probability level and Thiel-Sen linear trend estimates at every grid
   point.
     opt = False
     pq  = trend_manken(q, opt, 0)  ; ===> px(2,nlat,mlon)
                                      ; if meta data is desired
     copy_VarCoords(q(0,:,:),pq(0,:,:))
     pq!0= "prob_trend"               ; ===> size 2
     printVarSummary(pq)            ; ===> pq(prob_trend,lat,lon)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:14:02 +0800
# vim:set fdm=indent foldlevel=0:
