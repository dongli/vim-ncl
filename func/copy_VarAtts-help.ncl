THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/copy_VarAtts.shtml
THE_TITLE:copy_VarAtts

copy_VarAtts

   Copies all of a variable's attributes from one variable to another.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        procedure copy_VarAtts (
                var_from  ,
                var_to
        )

Arguments

   var_from

   An array of any dimensionality. Must have attributes.
   var_to

   An array of any dimensionality. Must be the same size as var_from.

Description

   This procedure copies all of a variable's attributes from var_from to var_to. If var_to already contains an attribute of
   the same name as one of var_from's attributes, then it is deleted and the new one copied over.

See Also

   There are many metadata tools.

Examples

   Example 1

;---Open file and read in variable
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
2015-10-03 23:16:48 +0800
# vim:set fdm=indent foldlevel=0:
