THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/dim_sum_wgt_Wrap.shtml
THE_TITLE:dim_sum_wgt_Wrap

dim_sum_wgt_Wrap

   Computes the weighted sum of a variable's rightmost dimension at all other dimensions and retains metadata.

   [new.gif] Available in version 4.3.1 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function dim_sum_wgt_Wrap (
                x       : numeric,
                w   [*] : numeric,
                opt [1] : integer
        )

        return_val  :  float or double

Arguments

   x

   A variable of numeric type and any dimensionality. Missing values are indicated by the _FillValue attribute.
   w

   A one-dimensional array of weights. The length must the same as the rightmost dimension of x.
   opt

   A scalar: (a) opt=0 means compute the weighted sum only if all values are not missing; (b) opt=1 means compute the
   weighted sum of all non-missing values; (c) opt>1 means to return the weighted sum only if the number of non-missing
   values is greater-than or equal to opt.

Return value

   The output will be double if x is double, and float otherwise.

   The output dimensionality is the same as the first n-2 dimensions of the input variable. That is, the dimension rank of
   the input variable will be reduced by one.

Description

   Computes the weighted sum of all elements of the n-1th (rightmost) dimension for each index of the dimensions 0...n-2 and
   retains metadata. A wrapper function.

   Use dim_sum_wgt_n_Wrap if you want to specify which dimensions to do the sum across.

See Also

   dim_sum_wgt, dim_avg, avg, dim_median, dim_stddev, dim_num, dim_product, dim_rmsd, dim_rmvmean, dim_rmvmed,
   dim_standardize, dim_stat4, dim_stddev, dim_sum, dim_variance

Examples

   Example 1

   Let PRC(12,nlat,mlon) contain monthly precipitation totals with named dimensions "time", "lat" and "lon", respectively.
   Compute the weighted annual total at each lat/lon point. Use dimension reordering to make time the rightmost dimension.
    wgt = (/0.08493151, 0.076712325, 0.08493151, 0.08219178 \ ; same size as dimension "time"
           ,0.08493151, 0.08219178 , 0.08493151, 0.08493151 \
           ,0.08219178, 0.08493151 , 0.08219178, 0.08493151 /)

    pTot = dim_sum_wgt_Wrap( prc(lat|:,lon|:,time|:), wgt, 0 )    ; ==> pTot(lat,lon)

    pTot = dim_sum_wgt_n_Wrap( prc, wgt, 0, 0 )                   ; no reordering needed

   All attributes and, if present, latitude and longitude coordinate variables are retained.

   Example 2

   Let T(time,lev,lat,lon). Compute the weighted vertical sum total at each time/lat/lon point. Use dimension reordering to
   make level the rightmost dimension.
    delp = ((/50,50,100,100,100,50,25,10/) ; same size as dimension "lev"

    Tsum = dim_sum_wgt_Wrap( T(time|:,lat|:,lon|:,lev|:), wgt, 0 )    ; ==> Tsum(time,lat,lon)

    Tsum = dim_sum_wgt_n_Wrap( T, wgt, 0, 1 )                         ; no reordering needed

   All attributes and, if present, time, latitude and longitude coordinate variables are retained.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:17:25 +0800
# vim:set fdm=indent foldlevel=0:
