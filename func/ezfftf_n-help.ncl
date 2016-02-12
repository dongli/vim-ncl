THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/ezfftf_n.shtml
THE_TITLE:ezfftf_n

ezfftf_n

   Performs a Fourier analysis on a real periodic sequence on the given dimension.

   [new.gif] Available in version 6.3.0 and later.

Prototype

        function ezfftf_n (
                x       : numeric,
                dim [1] : integer
        )

        return_val  :   typeof(x)

Arguments

   x

   A variable containing one or more periodic sequences to be transformed. The dim argument represents the dimension of x to
   transform. The size of this dimension need not be a power of 2.
   dim

   A scalar integer indicating which dimension of x to transform. Dimension numbering starts from the left at 0.

Return value

   A double array is returned if x is double, otherwise a float array is returned.

   If npts is the size of the dimension to be transformed, and NL and NR represent an arbitrary number of dimensions to the
   left and right of dim, then the Fourier coefficients are returned as an variable dimensioned (2,NL,npts/2,NR). The
   leftmost dimension of size 2 contains the real and imaginary coefficients.

   It also returns the series mean(s) as an attribute called xbar. A second attribute, npts, specifies the length of the
   original series.

Description

   Given a real periodic sequence x, ezfftf_n performs a forward Fourier transform on the given dimension. This is often
   called Fourier Analysis.

   ezfftf_n is a direct call to the FFTPACK routine at
    http://www.netlib.org/fftpack/ezfftf.f

   or, with better documentation
    ftp://ftp.ucar.edu/dsl/lib/fftpack/ezfftf.f

   If any missing values are encountered in one of the input arrays, then no calculations will be performed on that array,
   and the corresponding output array will be filled with missing values.

   The user may wish to detrend [ dtrend_n ] and taper [ taper_n ] prior to performing the analysis. Consult a book on
   Fourier Analysis for details. A old but nice reference is:
        Peter Bloomfield
        Fourier analysis of time series : An introduction
        New York : John Wiley and Sons  , 1976

See Also

   ezfftb_n, ezfftf, ezfftb, cfftf, cfftb, taper_n, dtrend_n, taper, dtrend, specx_anal, specxy_anal

Examples

   See the ezfftf documentation for more detailed examples. Below is the second example from this documentation.

   Example 1

   Assume x(ntim,klvl,nlat,mlon) and you want to do the transform on the "mlon" dimension.

   In the "Return Value" documentation, NL corresponds to the dimension sizes (ntim,klvl,nlat), and NR is just 1.

    cf = ezfftf_n (x,3)   ; ==> cf(2,ntim,klvl,nlat,mlon/2)
                          ; ==> cf@npts = mlon
                          ; ==> cf@xbar ==> contains the means
                                            length=ntim*klvl*nlat

   The attribute xbar is returned as a one-dimensional array. The following will make this a three-dimensional array:

    xAvg = reshape(cf@xbar, (/ntim,klvl,nlat/) )


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:03:39 +0800
# vim:set fdm=indent foldlevel=0:
