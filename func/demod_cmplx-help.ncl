THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/demod_cmplx.shtml
THE_TITLE:demod_cmplx

demod_cmplx

   Perform a complex demodulation on one or more time series.

   [new.gif] Available in version 6.3.1 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function demod_cmplx (
                x          : numeric,
                frqdem [1] : numeric,
                frqcut [1] : numeric,
                nwt    [1] : integer,
                ndim   [1] : integer,
                opt    [1] : logical
        )

Arguments

   x

   Array of any dimensionality. The 'time' dimension should be equally spaced.
   frqdem

   The demodulation frequency (cycles per data point). The choice of frqdem may be guided by theory or by a (say) Fourier
   analysis (e.g., a periodogram) of a series. The range: 0.0 < frqdem < 0.5
   frqcut

   The cutoff frequency. Typically, frqcut=frqdem or frqcut=0.50*frqdem or frqcut=0.75*frqdem. Note: nwt should be set such
   that it passes the desired information.`
   nwt

   A scalar indicating the total number of weights (must be an odd number; nwt >= 3). The more weights, the better the
   filter, but there is a greater loss of data.
   ndim

   The dimension of x containing the time series.
   opt

   Currently not used. Set to False.

Return value

   A variable of type list containing two arrays of the same sizes, shape and type as x. The two variables (arrays) are the
   raw demodulated amplitudes and phases. NOTE: The variables within the list can be accessed directly. However, many users
   find it clearer to explicitly extract the variables and subsequently delete the returned list variable. See examples.

Description

   Complex demodulation may be viewed as a local version of harmonic analysis. The purpose is to estimate the amplitude and
   phase of a slowly varying oscillation in the neighborhood of frqdem. The resulting series must be further post-processed
   via a low-pass filter. This low-pass filter should remove frequencies at or above the frequency ( frqcut ).

   References:
      Bloomfield, P. (1976)
      Fourier Analysis of Time series: An Introduction
      Wiley , 1976:  Chapter 6

      Kessler: U. Washington: Complex Demodulation

      PMEL: Complex Demodulation

See Also

   filwgts_lanczos, bw_bandpass_filter, wgt_runave_n, specx_anal, fourier_info

Examples

   See worked examples on the Spectral Analysis and Complex Demodulation page.

   Example 1: Let x(time), frqdem=0.21, frqcut=0.75*frqdem, nwt=71, ndim=0, then
   demod_x = demod_cmplx(x, frqdem, frqcut, nwt, ndim, False)   ; demod_x[2]
   print(demod_x)                    ; type list

   amp_x   = demod_x[0]              ; [0] list syntax;   amp_x(time)
   phase_x = demod_x[1]              ; [1]              phase_x(time)
   delete(demod_x)                   ; no longer needed

   printVarSummary(amp_x)
   printVarSummary(phase_x)


   Example 2: Let x(time,lat,lon), frqdem=0.30, frqcut=0.50*frqdem, nwt=101, ndim=0, then
   demod_x = demod_cmplx(x, frqdem, frqcut, nwt, ndim, False)   ; demod_x[2]
   print(demod_x)                    ; type list

   amp_x   = demod_x[0]              ; [0] list syntax;   amp_x(time,lat,lon)
   phase_x = demod_x[1]              ; [1]              phase_x(time,lat,lon)
   delete(demod_x)                   ; no longer needed

   printVarSummary(amp_x)
   printVarSummary(phase_x)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:17:01 +0800
# vim:set fdm=indent foldlevel=0:
