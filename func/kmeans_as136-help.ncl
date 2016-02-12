THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/kmeans_as136.shtml
THE_TITLE:kmeans_as136

kmeans_as136

   Performs k-means clustering via the Hartigan and Wong AS-136 algorithm.

   [new.gif] Available in version 6.3.0 and later.

Prototype

        function kmeans_as136 (
                x       : numeric,  ; float or double
                k   [1] : integer,
                opt [1] : logical
        )

        return_val  :  float or double

Arguments

   x

   An array of N variables (eg, grid points, stations) and M observations. At this time, the _FillValue attribute is not
   recognized for this function. The user should remove or replace these values prior to input.

   Here, M can only be the righmost dimension, and all dimensions to the left of this dimension will be considered to be the
   'variable' dimension(s) (represented collectively by N). Most commonly, the observation (rightmost) dimension is the
   'time' dimension.

   It may be necessary to reorder the array to obtain the required order expected by kmeans_as136. See examples 3 and 4
   below.
   k

   User-specified number of clusters.
   opt

   Specifies whether optional arguments should be used. If opt=True, then the following attributes are recognized:

     * iter - the maximum iteration count (default=25)
     * iseed - an integer option specifing how the input x should be sampled to initialize the cluster centers (default=1)

     * opt@iseed=1 results in the center clusters being set to the first k sets of observations
     * opt@iseed=2 results in the cluster centers being set to a random set of observations

   Currently, the user can not explicitly set the actual cluster centers.

Return value

   The return array (say), clcnter, will contain the cluster centers. It will be dimensioned (k,N), where N collectively
   represents the 'variable' dimension(s).

   clcnter will have the following attributes associated with it:

     * id - a one-dimensional integer array of size M indicating the cluster to which each observation is assigned.
     * npts - a one-dimensional integer array of size k containing the number of points in each cluster.
     * ss2 - a one-dimensional double array of size k containing the within-cluster sum of squares.

Description

   K-means is a centroid-based cluster method. The observations are allocated to k clusters in such a way that the
   within-cluster sum of squares is minimized. K-means clustering requires that the number of clusters to be extracted be
   specified in advance.

   As noted by http://www.onmyphd.com/?p=k-means.clustering
   : "The number of clusters should match the data. An incorrect choice of the number of clusters will invalidate the whole
   process. An empirical way to find the best number of clusters is to try K-means clustering with different number of
   clusters and measure the resulting sum of squares."

   The k-means algorithm works reasonably well when the data fits the cluster model:
     * The number of clusters is 'consistent' with the data.
     * The data points within a cluster are centered around that cluster
     * The spread/variance of the clusters is similar, ie each data point belongs to the closest cluster

   Limitations: K-means may have problems when clusters are of very differing sizes; outliers are present; or empty clusters
   exist.

   The original code is created for Cartesian grids. If the application requires using grid points or stations located at
   high latitudes, it is suggested that css2c be used to interpolate to Cartesian coordinates. These better reflect the true
   distances and should be input to the function.

   The modified code used by this function was downloaded from John Burkardt's website. The original Hartigan & Wong Fortran
   code was from:

   John Hartigan, Manchek Wong,
   Algorithm AS 136:
   A K-Means Clustering Algorithm,
   Applied Statistics,
   Volume 28, Number 1, 1979, pages 100-108.

Examples

   Example 1: The source of this example is here. Default options are used.

   v0 = (/1.0, 1.5, 3.0, 5.0, 3.5, 4.5, 3.5/)      ; 1st variable
   v1 = (/1.0, 2.0, 4.0, 7.0, 5.0, 5.0, 4.5/)      ; 2nd variable

   m  = dimsizes(v1)    ; # observations
   n  = 2               ; # variables
   k  = 2               ; # clusters (user specified)

   x  = new((/n,m/), typeof(v1), "No_FillValue")
   x(0,:) = v0
   x(1,:) = v1

   clcntr = kmeans_as136(x, k, False)  ; use default options
   print(clcntr)      ; (1.25,1.5) and (3.9,5.1)

   An edited version of the output follows:

   Variable: clcntr
   Type: float
   Total Size: 16 bytes
               4 values
   Number of Dimensions: 2
   Dimensions and sizes:   [2] x [2]            <=== (k,n), (# clusters, # variables)
   (0,0)   1.25
   (0,1)   1.5

   (1,0)   3.9
   (1,1)   5.1

   Number of Attributes: 3
     id  : (1, 1, 2, 2, 2, 2, 2)
     npts : (2, 5)
     ss2 : (0.625, 7.9)                       <=== type double


   Example 2: Same as Example 1 but with three clusters (k=3). For illustration only, the maximum iteration count and the
   seed values are set.

   x  = (/ (/1.0, 1.5, 3.0, 5.0, 3.5, 4.5, 3.5/) \   ; create 'x' directly
         , (/1.0, 2.0, 4.0, 7.0, 5.0, 5.0, 4.5/) /)

   dimx = dimsizes(x)
   n    = dimx(0)         ; # variables    (2)
   m    = dimx(1)         ; # observations (7)
   k    = 3               ; # clusters

   opt            = True
   opt@iter       = 40     ; change the default max # iterations

   clcntr = kmeans_as136(x, k, opt)
   print(clcntr)


   An edited version of the output follows:

   Variable: clcntr
   Type: float
   Total Size: 24 bytes
               6 values
   Number of Dimensions: 2
   Dimensions and sizes:   [3] x [2]            <=== (k,n), (# clusters,# variables)
   (0,0)    1
   (0,1)    1

   (1,0)   1.5
   (1,1)    2

   (2,0)   3.9
   (2,1)   5.1

   Number of Attributes: 3
     id  : (1, 2, 3, 3, 3, 3, 3)
     npts : (1, 1, 5)
     ss2 : (0.0, 0.0, 7.9)                    <=== type double

   Example 3: Use the "famous" Anderson-Fischer IRIS data set and perform a K-Means analysis. Here the cluster centers are
   set using opt@iseed=1. To get the data in the required order, the variable is reordered upon input to the function.


   diri = "./"
   fili = "IRIS.txt"

   nvar = 4                    ; # of variables
   x    = readAsciiTable(diri+fili, nvar, "float", 2)
   x!0  = "obs"
   x!1  = "var"
   printVarSummary(x)

   dimx = dimsizes(x)
   mobs = dimx(0)              ; # observations
   k    = 3                    ; # clusters (user specified)

   opt       = True
   opt@iseed = 2
   clcntr = kmeans_as136(x(var|:,obs|:), k, opt)    ; temporarily reorder
   print(clcntr)

   The edited output is

   Variable: clcntr
   Type: float
   Total Size: 24 bytes
               12 values
   Number of Dimensions: 2
   Dimensions and sizes:   [3] x [4]      <=== (k,n), (# clusters, # variables)
   (0,0)   5.902
   (0,1)   2.748
   (0,2)   4.394
   (0,3)   1.434

   (1,0)   5.006
   (1,1)   3.425
   (1,2)   1.467
   (1,3)   0.246

   (2,0)   6.850
   (2,1)   3.074
   (2,2)   5.742
   (2,3)   2.071

   Number of Attributes: 3
     id   : (2,2,2,...,3,1,3,3,1)
     npts : (62, 48, 38)
     ss2  : (39.82097, 15.02396, 23.87947)  <=== type double

   The statistical package R returns the following.

    =============================R==============================
      http://www.rdatamining.com/examples/kmeans-clustering
    ============================================================
    > (kc <- kmeans(newiris, 3))

    K-means clustering with 3 clusters of sizes 38, 48, 62

    Cluster means:
      Sepal.Length Sepal.Width Petal.Length Petal.Width
    1     6.850000    3.073684     5.742105    2.071053
    2     5.006000    3.428000     1.462000    0.246000
    3     5.901613    2.748387     4.393548    1.433871

    Clustering vector:
      [1] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
     [30] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3 3 1 3 3 3 3 3
     [59] 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 1 3 3 3 3 3 3 3 3 3
     [88] 3 3 3 3 3 3 3 3 3 3 3 3 3 1 3 1 1 1 1 3 1 1 1 1 1 1 3 3 1
    [117] 1 1 1 3 1 3 1 3 1 1 3 3 1 1 1 1 1 3 1 1 1 1 3 1 1 1 3 1 1
    [146] 1 3 1 1 3

    Within cluster sum of squares by cluster:
    [1] 23.87947 15.15100 39.82097

   NOTE: NCL's npts is in a different order than R's cluster sizes (38, 50, 62). Further, NCL's id is associating the 1st
   elements with cluster 3 while R is associating the elements with cluster 2. Why the difference? The reason is that
   differing initial seeds may yield different cluster assignments. There is no significance associated with the cluster
   assignments. Being in cluster 1 is not more significant than being in cluster 3. It is arbitrary.

   Example 4: Consider X(time,lat,lon): Perform a K-means cluster using data from 30S to 30N. Here the array is rectilinear
   and the specified region does not extend to high latitudes. Hence, we will treat the data as if it is on a Cartesian
   grid.

    x  = f->X(:,{-30:30},:)               ; x(time,lat,lon)
                                          ; reorder via NCL's named dimension reordering
    xr = x(lat|:,lon|:,time|:)            ; make 'time' (observations; M) the rightmost dimension
                                          ; the lat,lon are the 'variables' (N)

    k  = 3                                ; # clusters (user specified)

    opt       = True
    opt@iseed = 1
    clcntr    = kmeans_as136(xr, k, opt)   ; input the reordered array
              :                            ; clcntr(3,nlat,mlon)
              :
              :
    delete(xr)                ; delete if no longer needed (not necessary)



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:06:58 +0800
# vim:set fdm=indent foldlevel=0:
