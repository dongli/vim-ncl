THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/escorc_n.shtml
THE_TITLE:escorc_n

escorc_n

   Computes sample cross-correlations at lag 0 only, across the given dimensions.

   [new.gif] Available in version 6.2.1 and later.

Prototype

        function escorc_n (
                x          : numeric,
                y          : numeric,
                dims_x [*] : integer,
                dims_y [*] : integer
        )

        return_val  :  numeric

Arguments

   x

   An array of any numeric type or size. The rightmost dimension is usually time.
   y

   An array of any numeric type or size. The rightmost dimension is usually time. The size of the rightmost dimension must
   be the same as x.
   dims_x

   A scalar integer indicating which dimension of x to do the calculation on. Dimension numbering starts at 0.
   dims_y

   A scalar integer indicating which dimension of y to do the calculation on. Dimension numbering starts at 0.

Description

   Computes sample cross-correlations at lag 0 only, across the given dimensions. If a lagged correlations is required, use
   esccr. Missing values are allowed. This function can be used to determine:
     * a "one-point-correlation-map" where one point is used to cross-correlate with all other points (see example 4 below)
     * a "pattern correlation" which measures the degree of overall agreement between two grids (see examples 4-7). A high
       pattern correlation indicates that both amplitude and phase of both grids are in agreement.

   Algorithm:
     cor = SUM [(X(t)-Xave)*(Y(t)-Yave)}]/(Xstd*Ystd)

   The dimension sizes(s) of c are a function of the dimension sizes of the x and y arrays. Type double is returned if x or
   y are double, and float otherwise. The following illustrates dimensioning based on possible input for dims_x and dims_y:

    dims_x = dims_y = 0
        x(N), y(N)          c
        x(N), y(N,K,M)      c(K,M)
      x(N,I), y(N,K,M)      c(I,K,M)
    x(N,J,I), y(N,L,K,M)    c(J,I,L,K,M)

    dims_x = 0, dims_y = 2
        x(N), y(K,M,N)      c(K,M)
      x(N,I), y(K,M,N)      c(I,K,M)

   Special case when dimensions of all x and y are identical:

    dims_x = dims_y = 0
    x(N,J,I), y(N,J,I)      c(J,I)

   The correlation coefficient (r) for n pairs of independent observations can be tested against the null hypothesis (ie.:
   no correlation) using the statistic

    r*sqrt[ (n-2)/(1-r^2) ]

   This statistic has a Student t distribution with n-2 degrees of freedom.

See Also

   escorc, esacv, esacr, esccr, esccv, escovc, pattern_cor

Examples

   Example 1

   The following will calculate the cross-correlation for one three-dimensional array y(lat,lon,time) and one
   one-dimensional array x(time).
     ccr = escorc_n(x,y,0,2)      ; ccr(nlat,mlon)

   Example 2

   The following will calculate the cross-correlations for x3(time,lat,lon) and y3(time,lat,lon) and x4(time,lev,lat,lon)
   and y4(time,lev,lat,lon).
     ccr3 = escorc_n(x3,y3,0,0)      ; ccr3(nlat,mlon)
     ccr4 = escorc_n(x4,y4,0,0)      ; ccr4(klev,lat,lon)

   Example 3

   Consider x(neval,time) and y(lat,lon,time)
     ccr = escorc_n(x,y,1,2)      ; ccr(neval,nlat,mlon)

   Example 4

   Consider ya(time,nl,ml) and yb(lat,lon,time) where nl and ml are scalar integers (grid indices) specified by the user.
   The result is a "one-point correlation pattern". Basically, a specific point is correlated with all other points. NOTE:
   NCL makes y(:,nl,ml) and yb(nl,ml,:) into one-dimensional arrays. Hence, dimension number for time is 0.
     nl   = 32 ; for example
     ml   = 64
     ccra = escorc_n(ya(:,nl,ml),yb,0,0)   ===> ccra(lat,lon)
     ccrb = escorc_n(ya(nl,ml,:),yb,0,0)   ===> ccrb(lat,lon)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:03:28 +0800
# vim:set fdm=indent foldlevel=0:
