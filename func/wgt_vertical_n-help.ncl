THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/wgt_vertical_n.shtml
THE_TITLE:wgt_vertical_n

wgt_vertical_n

   Calculate a weighted vertical sum (integral) or average.

   [new.gif] Available in version 6.3.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        function wgt_vertical_n (
                x       : numeric,
                dp      : numeric,
                iopt    : integer,
                dim [1] : integer
        )

        return_val [dimsizes(t)] :  float or double

Arguments

   x

   Array to be integrated or averaged. No missing data allowed.
   dp

   Pressure thicknesses computed by dpres_hybrid_ccm or dpres_plevel. These are the 'weights' associated with each level.
   iopt

   option. Currently not used, set to 0.
   dim

   The dimension(s) of x on which to calculate the sum. or average.

Return value

   An array of of one less rank than the input x. The output will be double if x or dp is of type double.

Description

   Calculate the weighted vertical sum or average along a specific dimension.

             vertical_integral_X = SUM[x*dp]
             vertical_average__X = SUM[x*dp]/SUM[dp]


   NOTE: This function is documented as weighted vertical sum/average but it can be used for any weighted quantity along any
   coordinate. It was developed to isolate vertical sum/average so it is documented as such.

See Also

   advect_variable, pot_vort_hybrid, pot_vort_isobaric, static_stability_n

Examples

   Note: The dimension names are those used by the CESM. NCL does not care what the dimensions are named.

   See Example 2 of advect_variable.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:20:40 +0800
# vim:set fdm=indent foldlevel=0:
