THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/exp_tapershC.shtml
THE_TITLE:exp_tapershC

exp_tapershC

   Performs tapering (filtering) of the spherical harmonic coefficients.

Prototype

        function exp_tapershC (
                ab  : numeric,
                N   : numeric,
                r   : integer
        )

        return_val [dimsizes(ab)] :  float or double

Arguments

   ab

   spherical harmonic coefficients returned to the user by the NCL functions shagC/shaeC.
   N

   mode at which the taper weight will equal exp(-1) [=0.3678795 ]. (N < maximum-wave-number possible)
   r

   power of exponent. This determines the rate at which the coefficients decrease (see below).

Return value

   The results are returned in an array that is of size (dimsizes(ab)).

Description

   exp_tapershC performs tapering on the spherical harmonic coefficients.

   The effect is to perform (spatial) isotropic smoothing by reducing the amplitude of the coefficients at higher modes.
   Most frequently, this is done for graphical purposes. The formula used is:

     S(n) = EXP{-[ n(n+1)/N(N+1)]^r }

   n = total wavenumber, N,r defined above. This is equation (9) in the following reference:

   Reference:

     Spatial Smoothing on the Sphere
     P. D. Sardeshmukh and B. J. Hoskins
     Monthly Weather Review, December 1984, pp 2424-2529.

   exp_tapershC is the function version of exp_tapersh.

See Also

   exp_tapersh_wgts, exp_tapersh, shagC, shaeC

Examples

   Example 1

   a and b are calculated from a function (say shagC/shaeC). g is a data array dimensioned ntim x nlat x nlon.

  ab = shaeC(g)

  T  = 62
  ab = tri_trunC (ab,T)         ;triangularly truncate the spherical harmonic coefficients
  ab = exp_tapershC (ab, 45, 2) ;taper the spherical harmonic coefficients

  g_mod = shseC(ab,nlon)                ;perform the spherical harmonic synthesis on the truncated coefficients, store results in
h


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:03:34 +0800
# vim:set fdm=indent foldlevel=0:
