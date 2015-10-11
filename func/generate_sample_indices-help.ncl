THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/generate_sample_indices.shtml
THE_TITLE:generate_sample_indices

generate_sample_indices

   Generate indices (subscripts) for resampling: with and without replacement.

   [new.gif] Available in version 6.3.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function generate_sample_indices (
                N       : integer or long,
                method  : integer
        )

Arguments

   N

   The number of indices (subscripts) to be generated.
   method

   Integer which specifies which type of indices should be generated.
     * method=0: Sample without replacement. These can be used to reshuffle the order. Use when the order of sampling may be
       important. Statistics like the mean and standard deviation will not be changed.
     * method=1: Sample with replacement. These can be used for (say) bootstrap resampling. Statistics like the mean and
       standard deviation will be changed.

Return value

   A one-dimensional array of size N containing the random integer indices (subscripts).

Description

   Uses a random algorithm to generate subscripts.

See Also

   generate_2d_array, generate_unique_indices

Examples

   Example 1: Generate N random indices with (method=1) and without (method=0) replacement.
         n   = 10
         iwo = generate_sample_indices( n, 0 )
         iw  = generate_sample_indices( n, 1 )

         print("iwo+"   "+iw)

The indices would be
                 iwo iw
          (0)     5   8
          (1)     3   3
          (2)     0   2
          (3)     1   5
          (4)     8   7
          (5)     9   0
          (6)     4   0
          (7)     2   2
          (8)     6   0
          (9)     7   7

   Note that the iwo are unique while the iw have indices repeated (0, 7) while other indices (1, 4, 6, 9) are not present.

   Example 2: Resample an array x[*] with and without replacement.
         N   = 10
         x   = fspan(17.89, 52.30,N)
         iwo = generate_sample_indices( N, 0 )
         iw  = generate_sample_indices( N, 1 )

         xAvg     = avg(x)
         xAvg_iwo = avg(x(iwo))
         xAvg_iw  = avg(x(iw) )

         xStd     = stddev(x)
         xStd_iwo = stddev(x(iwo))
         xStd_iw  = stddev(x(iw) )

         print(x+"   "+iwo+"   "+ x(iwo)+"   "+ iw+"   "+x(iw)  )

         print("avg:  "+xAvg+"      "+xAvg_iwo+"      "+xAvg_iw )
         print("std:  "+xStd+"      "+xStd_iwo+"      "+xStd_iw )


                    x         iwo   x(iwo)     iw    x(iw)
          (0)     17.89        2   25.5367      4   33.1833
          (1)     21.7133      3   29.36        0   17.89
          (2)     25.5367      1   21.7133      9   52.3
          (3)     29.36        0   17.89        7   44.6533
          (4)     33.1833      5   37.0067      3   29.36
          (5)     37.0067      8   48.4767      4   33.1833
          (6)     40.83        7   44.6533      8   48.4767
          (7)     44.6533      4   33.1833      0   17.89
          (8)     48.4767      6   40.83        1   21.7133
          (9)     52.3         9   52.3         0   17.89

          avg:    35.095           35.095           31.654
          std:    11.5757          11.5757          13.1459



   Example 3: Resample an array x(ntim,nlat,mlon) with and without replacement.

         iwo = generate_sample_indices( ntim, 0 )
         iw  = generate_sample_indices( ntim, 1 )

         xw  = x
         xwo = x

         do nl=0,nlat-1
           do ml=0,mlon-1
              xw(:,nl,ml)  = x(iw ,nl,ml)
              xwo(:,nl,ml) = x(iwo,nl,ml)
           end do
         end do


   Example 4: Resample an array x(ntim) 'nSample' times with replacement. For 'fun', do it in one statement.

         xAvg    = avg(x)
         print("xAvg="+xAvg)

         nSample = 1000
         xBoot   = new (nSample, typeof(x))

         do ns=0,nSample-1
            xBoot(ns) = avg( x(generate_sample_indices(ntim,1)) )
         end do

         xAvgBoot= avg(xBoot)
         xStdBoot= stddev(xBoot)
         print("xAvgBoot="+xAvgBoot)
         print("xStdBoot="+xStdBoot)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:18:08 +0800
# vim:set fdm=indent foldlevel=0:
