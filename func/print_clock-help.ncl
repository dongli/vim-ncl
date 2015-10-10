THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/print_clock.shtml
THE_TITLE:print_clock

print_clock

   Prints the given string along with a current timestamp.

   [new.gif] Available in version 6.2.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        procedure print_clock (
                title [1] : string
        )

Arguments

   title

   A single title string to print along with the current timestamp.

Description

   This procedure simply prints the given string, followed by a current timestamp. This is useful for debugging an NCL
   script that is running slowly.

   Acknowledgement: This function was donated by Carl Schreck, III [SUNY at Albany].

See Also

   get_cpu_time, wallClockElapseTime

Examples

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"

begin
  print_clock("Read data")

  a = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/uv300.nc","r")
  u = a->U(1,:,:)                                ; read July zonal winds

  print_clock("Open PostScript file")
  wks = gsn_open_wks("ps","ce")

  res = True
  res@cnFillOn = True

  print_clock("Generate a contour plot")
  plot = gsn_csm_contour_map_ce(wks,u,res)

  print_clock("Finish program")
end

   Output:

  (0)  Read data                                     |  2013-10-22 14:44:54 MDT
  (0)  Open PostScript file                          |  2013-10-22 14:44:55 MDT
  (0)  Generate a contour plot                       |  2013-10-22 14:44:55 MDT
  (0)  Finish program                                |  2013-10-22 14:44:56 MDT


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:19:31 +0800
# vim:set fdm=indent foldlevel=0:
