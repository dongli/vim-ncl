THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/gaus.shtml
THE_TITLE:gaus

gaus

   Computes Gaussian latitudes and weights.

Prototype

        function gaus (
                nlat [1] : integer or long
        )

        return_val [2*nlat,2] :  double

Arguments

   nlat

   A scalar integer equal to the number of latitude points PER hemisphere.

   As of version 6.0.0, this can be of type integer or long.

Description

   A two dimensional array is returned that contains both the Gaussian latitudes (first dimension) and the Gaussian weights
   (second dimension). By default the returned values are of type double.

See Also

   There are numerous other latitude/longitude functions.

   latGau, latGauWgt, latGlobeF, latGlobeFo, lonGlobeF, lonGlobeFo

Examples

   Example 1

   Generate Gaussian latitudes and weights (type double) for a specified number of latitudes:
  nlat = 64  ; for globe

  gau_info = gaus(nlat/2)   ; divide by 2 to get "per hemisphere"
  glat     = gau_info(:,0)  ; gaussian latitudes ( 1st dimension of gau_info)
  gwgt     = gau_info(:,1)  ; gaussian weights   ( 2nd dimension of gau_info)

   Example 2

   Use tofloat to generate Gaussian latitudes and weights (type float) for a specified number of latitudes:
  nlat     = 94     ; for globe
; conversion is embedded
  gau_info = tofloat(gaus(nlat/2))
  glat     = gau_info(:,0)                ; glat ==> float
  gwgt     = gau_info(:,1)                ; gwgt ==> float


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:04:55 +0800
# vim:set fdm=indent foldlevel=0:
