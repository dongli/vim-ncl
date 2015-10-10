THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/ezfftb_n.shtml
THE_TITLE:ezfftb_n

ezfftb_n

   Perform a Fourier synthesis from real and imaginary coefficients on the given dimension.

   [new.gif] Available in version 6.3.0 and later.

Prototype

        function ezfftb_n (
                cf      : numeric,
                xbar    : numeric,
                dim [1] : integer
        )

        return_val  :  float or double

Arguments

   cf

   Fourier coefficients as created by ezfftf. The elements cf(0,...) are the real coefficients, and cf(1,...) are the
   imaginary coefficients.
   xbar

   The constant Fourier coefficient. This must be a scalar or a single vector of the length of the product of the all
   dimensions of cf minus the dim-th dimension.
   dim

   A scalar integer indicating which dimension of cf to do the synthesis on. Dimension numbering starts from the left at 0,
   but since the leftmost dimension of cf represents the real and imaginary parts, this argument cannot be set to 0.

Return value

   A double array is returned if the input cf is double, otherwise a float array is returned.

   If cf(2,kcoef), then ezfftb_n will construct a one-dimensional series using the coefficients and the value of xbar. The
   length of the one-dimensional series may be odd or even depending upon the input coefficients.

   If cf(2, NL, kcoef, NR), where NL refers to one or more dimensions to the left of the dim-th dimension, and NR refers to
   one or more dimensions to the right of the dim-th dimension, then ezfftb_n will construct a variable, say x, that that is
   of size x(NL, npts, NR).

Description

   Given Fourier coefficients cf, the series means(s) xbar, and a dimension index to do the synthesis on, ezfftb_n computes
   the periodic sequences and returns an array of size NL x cf@npts x NR where NL and NR represent an arbitrary number of
   leftmost and rightmost dimensions.

   If any missing values are encountered in one of the input arrays, then no calculations will be performed on that array,
   and the corresponding output array will be filled with missing values.

See Also

   ezfftf_n, ezfftf, cfftf, cfftb

Examples

   See the ezfftb documentation for more detailed examples. Below is the third example from this documentation.

   Example 1

   Let x(ntim,klvl,nlat,mlon) where NL corresponds to (ntim,klvl,nlat) in this instance, and mlon is a number of longitude
   points:
    cf = ezfftf_n (x,3)   ; ==> cf(2,ntim,klvl,nlat,mlon/2)
                          ; ==> cf@npts = mlon
                          ; ==> cf@xbar ==> contains the means
                                            length=ntim*klvl*nlat

   Reconstruct using only wave 3 and set all the means to 0.0:
  cf(:,:,:,:,0:1) = 0.0         ; waves 1 and 2 set to zero
  cf(:,:,:,:,3:mlon-1) = 0.0    ; waves >3      set to zero

   Here cf@xbar will be a one-dimensional array of length ntim*klvl*nlat. We want set all to 0.0 so this is readily done
   via:

  cf@xbar = 0.0
  xWave_3 = ezfftb_n (cf, cf@xbar, 4)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:03:37 +0800
# vim:set fdm=indent foldlevel=0:
