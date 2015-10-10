THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/copy_VarCoords_1.shtml
THE_TITLE:copy_VarCoords_1

copy_VarCoords_1

   Copies all named dimensions and coordinate variables from one variable to another except for the rightmost dimension.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        procedure copy_VarCoords_1 (
                var_from  ,
                var_to
        )

Arguments

   var_from

   An array of any dimensionality. Must have named dimensions and coordinate variables
   var_to

   An array of any dimensionality.

Description

   This procedure copies all named dimensions and coordinate variables from one variable to another except for the rightmost
   dimension.

See Also

   There are many metadata tools.

Examples

   Example 1

;---Open files and read in variables
;***********************************************
  in1  = addfile("b003_TS_200-299.nc","r")
  in2  = addfile("b006_TS_035-134.nc","r")

  tmp1 = in1->TS
  tmp2 = in2->TS

;---Reorder to get time as right most dimension
  ts1 = tmp1(lat|:,lon|:,time|:)
  ts2 = tmp2(lat|:,lon|:,time|:)

;---Calculate cross correlations
  maxlag = 2                                    ; set lag
; note, the max lag should not be more than N/4

  ccr = esccr(ts1,ts2,maxlag)                   ; calc cross correlations

;---Copy meta data and coordinate variables using contributed functions
  copy_VarAtts(ts1, ccr)
  copy_VarCoords_1(ts2,ccr)


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:50 +0800
# vim:set fdm=indent foldlevel=0:
