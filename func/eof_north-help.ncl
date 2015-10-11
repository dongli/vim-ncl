THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/eof_north.shtml
THE_TITLE:eof_north

eof_north

   Use North et al (MWR, 1982) equation 24 to evaluate eigenvalue separation.

   [new.gif] Available in version 6.3.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function eof_north (
                eval   [*] : numeric,
                N      [1] : integer or long,
                prinfo [1] : logical
        )

Arguments

   eval

   Eigenvalues to be tested. These are returned as attributes of the EOFs returned by eofunc or eofunc_Wrap. Actually, any
   of the following attributes can be used: pcvar, eval_transpose or eval. Using pcvar is probably the clearest if
   prinfo=True.
   N

   Maximum possible number of eigenvalues. Typically, in climate applications, this is the number time steps.
   prinfo

   Print the calculated 'delta lambda', the eigenvalues, the lower and upper test bounds and the 'separated significance'
   (sig).

Return value

   A one dimensional logical array containing True or False. This indicates if eigenvalues are significantly separated.

Description

   Uses North et al equation 24 to see if eigenvalues are significantly separated.
   [north24.png]

 North, G.R. et al (1982): Sampling Errors in the Estimation of Empirical Orthogonal Functions.
 Mon. Wea. Rev., 110, 699-706.
 doi:    http://dx.doi.org/10.1175/1520-0493(1982)110<0699:SEITEO>2.0.CO;2


See Also

   eofunc, eofunc_Wrap

Examples

   Example 1

   f      = addfile("erai_1989-2009.mon.msl_psl.nc","r")
   p      = f->SLP(::12,{0:90},:)                      ; p(time,latitude,longtitude)
   printVarSummary(p)                                  ; p(21,61,240)

   w      = sqrt(cos(0.01745329*p&latitude)            ; weights(61)
   wp     = p*conform(p, w, 1)                        ; wp(21,61,240)
   copy_VarCoords(p, wp)                             ; wp(time,lat,lon)
   printVarSummary(wp)   ; [time | 21] x [latitude | 61] x [longitude | 240]

   x      = wp(latitude|:,longitude|:,time|:)          ; reorder data
   neof   = 4
   eof    = eofunc_Wrap(x, neof, False)
   eof_ts = eofunc_ts_Wrap

   printVarSummary(eof)
   printVarSummary(eof_ts)

   ;*******************************************
   ; North significance test: Note any of the following could be used
   ;*******************************************
   dimp   = dimsizes(p)
   ntim   = dimp(0)

   prinfo = True
   sig_pcv = eof_north(eof@pcvar, ntim, prinfo)
   sig_evt = eof_north(eof@eval_transform, ntim, prinfo)
   sig_ev  = eof_north(eof@eval, ntim, prinfo)


   The (edited) output


Variable: eof
Type: float
Number of Dimensions: 3
Dimensions and sizes:   [evn | 4] x [latitude | 61] x [longitude | 240]
Coordinates:
            evn: [1..4]
            latitude: [ 0..90]
            longitude: [ 0..358.5]
Number Of Attributes: 6
  eval_transpose :      ( 47.2223, 32.42917, 21.44406, 15.27389 )
  eval     :    ( 34519.5, 23705.72, 15675.61, 11165.21 )           <==========
  pcvar :       ( 26.83549, 18.42885, 12.18624, 8.679848 )
  matrix :      covariance
  method :      transpose
  _FillValue :  1e+20

=======
From eof_north, all return the same 'sig' answers.
Using eof@pcvar yields the easiest numbers to read.

index    dlam      low       pcvar     high    sig_pcv         <== titles added for clarity
(0)     8.28161   18.5539   26.8355   35.1171  True     <== EOF 1
(1)     5.68727   12.7416   18.4289   24.1161  True     <== EOF 2
(2)     3.76075   8.42548   12.1862   15.947   True     <== EOF 3
(3)     2.67866   6.00119   8.67985   11.3585  False    <== EOF 4

index    dlam      low      eval_tr    high    sig_evt         <== titles added for clarity
(0)     14.5731   32.6492   47.2223   61.7954  True     <== EOF 1
(1)     10.0079   22.4213   32.4292   42.437   True     <== EOF 2
(2)     6.61778   14.8263   21.4441   28.0618  True     <== EOF 3
(3)     4.71362   10.5603   15.2739   19.9875  False    <== EOF 4

index    dlam      low        eval     high    sig_ev          <== titles added for clarity
(0)     10652.9   23866.6   34519.5   45172.4  True     <== EOF 1
(1)     7315.75   16390     23705.7   31021.5  True     <== EOF 2
(2)     4837.6    10838     15675.6   20513.2  True     <== EOF 3
(3)     3445.66   7719.55   11165.2   14610.9  False    <== EOF 4



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:17:35 +0800
# vim:set fdm=indent foldlevel=0:
