THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/depth_to_pres.shtml
THE_TITLE:depth_to_pres

depth_to_pres

   Convert ocean depth to pressure.

   [new.gif] Available in version 6.1.0 and later.

Prototype

        function depth_to_pres (
                z       : numeric,
                opt [1] : logical
        )

        return_val  :  numeric

Arguments

   z

   Ocean depth (meters)
   opt

   Options. Currently not used, set to False.

Return value

   The returned array will have units of bars. It will be the same size, shape and type as z.

Description

   Calculate ocean pressure (bars) from user specified depth (meters). The equation used is consistent with that used in the
   POP model (2012).

   This function computes pressure in dekabar from depth in meters using a mean density derived from depth-dependent global
   average temperatures and salinities from Levitus 1994, and integrating using hydrostatic balance.
   References

      Levitus, S., R. Burgett, and T.P. Boyer, 1994
      World Ocean Atlas
      Volume 3: Salinity, NOAA Atlas NESDIS 3, US Dept. of Commerce

      Dukowicz, J. K., 2000
      Reduction of Pressure and Pressure
      Gradient Errors in Ocean Simulations, J. Phys. Oceanogr.,

See Also

   potmp_insitu_ocn

Examples

   Example 1

       d    = (/ 7321.45, 9712.65/)                     ; meters
       pd   = depth_to_pres(d,False) ; pd = (/ 749.937, 1000.19/) bars

   Example 2

       f        = addfile("POP.nc", "r")
       z        = f->z_t            ; cm
       z        = z*0.01            ; convert to meters
       z@units  = "meters"

       pz       = depth_to_pres(z,False)        ; pz(kz); kz=dimsizes(z)
       pz@units = "bars"

   The output:
              z          pz
(0)          5.01      0.498
(1)         15.07      1.500
(2)         25.28      2.519
(3)         35.76      3.568
(4)         46.61      4.656
(5)         57.98      5.797
[snip]
(34)      4125.00    419.486
(35)      4375.00    445.163
(36)      4625.00    470.869
(37)      4875.00    496.602
(38)      5125.00    522.365
(39)      5375.00    548.156


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:01:26 +0800
# vim:set fdm=indent foldlevel=0:
