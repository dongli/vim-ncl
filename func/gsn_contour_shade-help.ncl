THE_URL:https://www.ncl.ucar.edu/Document/Graphics/Interfaces/gsn_contour_shade.shtml
THE_TITLE:gsn_contour_shade

gsn_contour_shade

   Shades contour regions given low and/or high values using colors or patterns.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"

        function gsn_contour_shade (
                plot    [1] : graphic,
                lowval  [1] : numeric,
                highval [1] : numeric,
                opt     [1] : string
        )

        return_val [1] :  graphic

Arguments

   plot

   The plot to be modified.
   lowval

   Starting with the first contour less than or equal to lowval, all areas less than that first contour will be shaded with
   the color or pattern specified in opt@gsnShadeLow. Alternatively, opt@gsnShadeMid can be set, and starting with the first
   contour greater than or equal to lowval, all areas between that first contour and the last contour less than or equal to
   highval will be shaded with the color or pattern specified in opt@gsnShadeMid.
   highval

   Starting with the first contour greater than or equal to highval, all areas greater than that first contour will be
   shaded with the color or pattern specified in opt@gsnShadeHigh. Alternatively, opt@gsnShadeMid can be set, and starting
   with the first contour less than or equal to highval, all areas between that first contour and the last contour greater
   than or equal to lowval will be shaded with the color or pattern specified in opt@gsnShadeMid.
   opt

   A variable containing a list of special plot resources, attached as attributes.

Return value

   plot is returned with the modifications described above.

Description

   This function will color or pattern shade regions defined via the arguments lowval and/or highval. The type of shading
   (color or pattern), the exact colors/patterns, and which of the three possible regions will be shaded (le.lowval,
   ge.lowval.and.le.highval, ge.highval) are determined by the special resource list attached to opt.

   The list of possible resources that can be attached to opt is:
     * gsnShadeFillType : can be set to "color" for color fill, or "pattern" for pattern fill. "color" is the default. (This
       resource is case sensitive, do not capitalize "color" or "pattern".)
     * gsnShadeLow : a pattern or color index, named color (e.g. "blue"), or RGB / RGBA tuple representing what
       color/pattern to use when filling areas less than the first contour less than or equal to lowval.
     * gsnShadeMid : a pattern or color index, named color (e.g. "blue"), or RGB/RGBA tuple representing what color/pattern
       to use when filling areas greater than the first contour greater than or equal to lowval and less than the first
       contour less than or equal to highval.
     * gsnShadeHigh : a pattern or color index, named color (e.g. "blue"), or RGB/RGBA tuple representing what color/patterm
       to use when filling areas greater than the first contour greater than or equal to highval.

   One or more of the following resources must be set: gsnShadeLow, gsnShadeMid, gsnShadeHigh. Otherwise the plot is
   returned without modifications and a warning message is generated.

   Important notes:
     * The shading will always begin at a contour, and not necessarily at the specified lowval or highval. Check your plot
       to make sure that the results are what you expected.
     * You cannot mix and match color and shading with this routine. For an example of drawing shaded and filled contours,
       see example coneff_14.ncl.
     * This routine only modifies the color or shading of existing contours, and does not change any existing labelbar, if
       present.

   Recognition of RGB/A tuples for color was added in version 6.2.1.

   A bug was fixed in version 6.2.0 that didn't allow you to use the gsnShadeHigh, gsnShadeMid, and gsnShadeLow resources
   together.

See Also

   ColorNegDashZeroPosContour, ColorShadeLeGeContour, ShadeGeLeContour, ShadeGtContour, ShadeLtContour, ShadeLtGtContour

Examples

   Example 1

   For an application example, see:
     * Description of coneff_13
       "coneff_13.ncl" (frame 1 | frame 2)

   Example 2

   The following will shade areas less than the first contour less than or equal to -5. with the color referenced by color
   index 14, and shade areas greater than the first contour greater than or equal to 10. red.

res = True
.......
res@gsnDraw = False
res@gsnFrame = False
plot = gsn_csm_contour_map_ce(wks,data,res)

opt = True
opt@gsnShadeFillType = "color"        ; color is the default
opt@gsnShadeLow = 14                  ; use color index 14
opt@gsnShadeHigh = "red"
plot = gsn_contour_shade(plot,-5.,10.,opt)
draw(plot)
frame(wks)

   Example 3

   Same as example 2, except use an RGB tuple to define the color red.

res = True
.......
res@gsnDraw = False
res@gsnFrame = False
plot = gsn_csm_contour_map_ce(wks,data,res)

opt = True
opt@gsnShadeFillType = "color"        ; color is the default
opt@gsnShadeLow = 14
opt@gsnShadeHigh = (/1.,0,0/)
plot = gsn_contour_shade(plot,-5.,10.,opt)
draw(plot)
frame(wks)

   Example 4

   Using the same resource list defined in Example 1, the following example will pattern fill areas greater than the first
   contour greater than or equal to 20. with fill pattern #2.

plot = gsn_csm_contour_map_ce(wks,data,res)

opt = True
opt@gsnShadeFillType = "pattern"      ; pattern fill
opt@gsnShadeHigh = 2                  ; use pattern #2
plot = gsn_contour_shade(plot,-999.,20.,opt)
draw(plot)
frame(wks)

   Example 5

   Using the same resource list defined in Example 1, the following example will pattern fill areas greater than the first
   contour greater than or equal to 5., and less than or equal to 10. with fill pattern #2.

plot = gsn_csm_contour_map_ce(wks,data,res)

opt = True
opt@gsnShadeFillType = "pattern"      ; pattern fill
opt@gsnShadeMid = 2                   ; use pattern #2
plot = gsn_contour_shade(plot,5.,10.,opt)
draw(plot)
frame(wks)

   Example 6

   The following example will pattern fill areas less than the first contour less than or equal to -15 with fill pattern #4
   shaded blue. Note that at present there is no direct way to specify a pattern fill color into gsn_contour_shade. One can
   get around this limitation by setting cnFillColor and cnFillOn = False in the original plot's resource list. Note that
   only a single pattern fill color can be specified. If multiple fill pattern colors are needed, gsn_contour_shade cannot
   be used.

res = True
.......
res@cnFillOn = False
res@cnFillColor = "blue"
res@gsnDraw = False
res@gsnFrame = False
plot = gsn_csm_contour_map_ce(wks,data,res)

opt = True
opt@gsnShadeFillType = "pattern"        ; color is the default
opt@gsnShadeLow = 4                     ; use fill pattern #4
plot = gsn_contour_shade(plot,-15.,-999.,opt)
draw(plot)
frame(wks)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:22:25 +0800
# vim:set fdm=indent foldlevel=0:
