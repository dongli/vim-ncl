THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/wrf_wps_read_int.shtml
THE_TITLE:wrf_wps_read_int

wrf_wps_read_int

   Reads data from a WPS intermediate file.

   [new.gif] Available in version 6.3.0 and later.

Prototype

        function wrf_wps_read_int (
                filename [1] : string
        )

        return_val [nfields][ny][nx] :  float

Arguments

   filename

   The name of the WPS intermediate file to read.

Description

   This function reads data from the given WPS intermediate file, and returns a 3D float array dimensioned [nfields x ny x
   nx], where each [ny x nx] subset is a 2D field that was written to the file.

   It also returns several attributes attached to the return variable, each one a string array of length nfields containing
   information about each field:

   hdate       the date for each field
   field       the field name for each field
   units       the units for each field
   description a description for each field
   map_source  a map source for each field

   A 2D float attribute called rhead of size nfields x 14 is returned that contains the following values:

                            For all fields:
                      version          rhead(:,0)
                      forecast hour    rhead(:,1)
                      level            rhead(:,2)
                      nx               rhead(:,3)
                      ny               rhead(:,4)
   projection
   (0, 1, 3, 4, or 5) rhead(:,5)
                          If projection = 0:
                      startlat         rhead(:,6)
                      startlon         rhead(:,7)
                      deltalat         rhead(:,8)
                      deltalon         rhead(:,9)
                      earth_radius     rhead(:,10)
                          If projection = 1:
                      startlat         rhead(:,6)
                      startlon         rhead(:,7)
                      dx               rhead(:,8)
                      dy               rhead(:,9)
                      truelat1         rhead(:,10)
                      earth_radius     rhead(:,11)
                          If projection = 3:
                      startlat         rhead(:,6)
                      startlon         rhead(:,7)
                      dx               rhead(:,8)
                      dy               rhead(:,9)
                      center_lon       rhead(:,10)
                      truelat1         rhead(:,11)
                      truelat2         rhead(:,12)
                      earth_radius     rhead(:,13)
                          If projection = 4:
                      startlat         rhead(:,6)
                      startlon         rhead(:,7)
                      nlats            rhead(:,8)
                      deltalon         rhead(:,9)
                      earth_radius     rhead(:,10)
                          If projection = 5:
                      startlat         rhead(:,6)
                      startlon         rhead(:,7)
                      dx               rhead(:,8)
                      dy               rhead(:,9)
                      center longitude rhead(:,10)
                      truelat1         rhead(:,11)
                      earth_radius     rhead(:,12)

   To read a WPS file one field at a time, you can use a 3-step process:
    1. wrf_wps_open_int - open a WPS file
    2. wrf_wps_rdhead_int - read header info for current field
    3. wrf_wps_rddata_int - read data for current field

   The examples below illustrate both methods for reading a WPS file.

See Also

   wrf_wps_open_int, wrf_wps_rdhead_int, wrf_wps_rddata_int, wrf_wps_read_int, wrf_wps_write_int, wrf_wps_close_int

Examples

   Example 1

   This example shows how to use wrf_wps_read_int to read a WPS intermediate file in one step.

   See example 2 below for a script that shows a three-step process of reading a WPS file using 1) wrf_wps_open_int, 2)
   wrf_wps_rdhead_int, and 3) wrf_wps_rddata_int.

  wps_filename = "NNRP:2006-04-10_00"

  slabs = wrf_wps_read_int(wps_filename)

  slabs_dims = dimsizes(slabs)
  header     = slabs@rhead          ; Read into memory so we can subscript it
  nfields    = slabs_dims(0)

  print("There are " + nfields + " fields in the " + wps_filename + " WPS file.")

  do nf=0,nfields-1
;---Print information about each slab
    print("Field #" + (nf+1))
    print("  name          : '" + slabs@field(nf) + "'")
    print("  description   : '" + slabs@description(nf) + "'")
    print("  units         : '" + slabs@units(nf) + "'")
    print("  min/max value : "  + min(slabs(nf,:,:)) + " / " + max(slabs(nf,:,:)))
    print("  date          : '" + slabs@hdate(nf) + "'")
    print("  map source    : '" + slabs@map_source(nf) + "'")
    print("  version       : " + header(nf,0))
    print("  forecast hour : " + header(nf,1))
    print("  level         : " + header(nf,2))
    print("  ny x nx       : " + header(nf,4) + " x " + header(nf,3))
    print("  projection    : " + header(nf,5))
    if(header(nf,5).eq.0) then
      print("startlat        : " + header(nf,6))
      print("  startlon      : " + header(nf,7))
      print("  deltalat      : " + header(nf,8))
      print("  deltalon      : " + header(nf,9))
      print("  earth_radius  : " + header(nf,10))
    else if(header(nf,5).eq.1) then
      print("  startlat      : " + header(nf,6))
      print("  startlon      : " + header(nf,7))
      print("  dy x dx       : " + header(nf,9) + " x " + header(nf,8))
      print("  truelat1      : " + header(nf,10))
      print("  earth_radius  : " + header(nf,11))
    else if(header(nf,5).eq.3) then
      print("  startlat      : " + header(nf,6))
      print("  startlon      : " + header(nf,7))
      print("  dy x dx       : " + header(nf,9) + " x " + header(nf,8))
      print("  center lon    : " + header(nf,10))
      print("  truelat1      : " + header(nf,11))
      print("  truelat2      : " + header(nf,12))
      print("  earth_radius  : " + header(nf,13))
    else if(header(nf,5).eq.4) then
      print("  startlat      : " + header(nf,6))
      print("  startlon      : " + header(nf,7))
      print("  nlats         : " + header(nf,8))
      print("  deltalon      : " + header(nf,9))
      print("  earth_radius  : " + header(nf,10))
    else if(header(nf,5).eq.5) then
      print("  startlat      : " + header(nf,6))
      print("  startlon      : " + header(nf,7))
      print("  dy x dx       : " + header(nf,9) + " x " + header(nf,8))
      print("  center lon    : " + header(nf,10))
      print("  truelat1      : " + header(nf,11))
      print("  earth_radius  : " + header(nf,12))
    end if
    end if
    end if
    end if
    end if
  end do

   Output: (run with "-n" option to remove annoying "(0)")
There are 100 fields in the NNRP:2006-04-10_00 WPS file.

Field #1
  name          : 'PMSL'
  description   : 'Sea-level Pressure'
  units         : 'Pa'
  min/max value : 0 / 107780
  date          : '2006-04-10_00:00:00'
  map source    : 'unknown model from NCEP GRID   2'
  version       : 5
  forecast hour : 0
  level         : 201300
  ny x nx       : 73 x 144
  projection    : 0
  startlat      : 90
  startlon      : 0
  deltalat      : -2.5
  deltalon      : 2.5
  earth_radius  : 6371.23
  .
  .
  .
Field #100
  name          : 'HGT'
  description   : 'Height'
  units         : 'm'
  min/max value : 0 / 31173
  date          : '2006-04-10_00:00:00'
  map source    : 'unknown model from NCEP GRID   2'
  version       : 5
  forecast hour : 0
  level         : 1000
  ny x nx       : 73 x 144
  projection    : 0
  startlat      : 90
  startlon      : 0
  deltalat      : -2.5
  deltalon      : 2.5
  earth_radius  : 6371.23

   Example 2

   This example shows how to use the three-step process of reading a WPS intermediate file using 1) wrf_wps_open_int, 2)
   wrf_wps_rdhead_int, and 3) wrf_wps_rddata_int.

  wps_filename = "NNRP:2006-04-10_00"

;---Preallocate variables for header
  header      = new(14,float)
  field       = new(1,string)
  date        = new(1,string)
  units       = new(1,string)
  map_source  = new(1,string)
  description = new(1,string)

  istatus =  wrf_wps_open_int(wps_filename)
  if(istatus.ne.0) then
    print("Error opening " + wps_filename)
    exit
  end if

;---Continuously read data from WPS file until istatus != 0.
  nfields = 0

  do while (istatus.eq.0)

;---Read header
    wrf_wps_rdhead_int(istatus,header,field,date,units,\
                       map_source,description)
    if(istatus.ne.0) then
      continue
    end if

    nx = toint(header(3))
    ny = toint(header(4))

;---Read data
    slab := wrf_wps_rddata_int(istatus,nx,ny)
    if(istatus.ne.0) then
      continue
    end if

;---Print information about each slab
    print("Field #" + (nfields+1))
    print("  name          : '" + field + "'")
    print("  description   : '" + description + "'")
    print("  units         : '" + units + "'")
    print("  min/max value : "  + min(slab) + " / " + max(slab))
    print("  date          : '" + date + "'")
    print("  map source    : '" + map_source + "'")
    print("  version       : " + header(0))
    print("  forecast hour : " + header(1))
    print("  level         : " + header(2))
    print("  ny x nx       : " + header(4) + " x " + header(3))
    print("  projection    : " + header(5))
    if(header(5).eq.0) then
      print("  startlat      : " + header(6))
      print("  startlon      : " + header(7))
      print("  deltalat      : " + header(8))
      print("  deltalon      : " + header(9))
      print("  earth_radius  : " + header(10))
    else if(header(5).eq.1) then
      print("  startlat      : " + header(6))
      print("  startlon      : " + header(7))
      print("  dy x dx       : " + header(9) + " x " + header(8))
      print("  truelat1      : " + header(10))
      print("  earth_radius  : " + header(11))
    else if(header(5).eq.3) then
      print("  startlat      : " + header(6))
      print("  startlon      : " + header(7))
      print("  dy x dx       : " + header(9) + " x " + header(8))
      print("  center lon    : " + header(10))
      print("  truelat1      : " + header(11))
      print("  truelat2      : " + header(12))
      print("  earth_radius  : " + header(13))
    else if(header(5).eq.4) then
      print("  startlat      : " + header(6))
      print("  startlon      : " + header(7))
      print("  nlats         : " + header(8))
      print("  deltalon      : " + header(9))
      print("  earth_radius  : " + header(10))
    else if(header(5).eq.5) then
      print("  startlat      : " + header(6))
      print("  startlon      : " + header(7))
      print("  dy x dx       : " + header(9) + " x " + header(8))
      print("  center lon    : " + header(10))
      print("  truelat1      : " + header(11))
      print("  earth_radius  : " + header(12))
    end if
    end if
    end if
    end if
    end if
    nfields = nfields + 1
  end do

  print("There were " + nfields + " fields in the " + wps_filename + " WPS file.")


   Output: (run with "-n" option to remove annoying "(0)")
Field #1
  name          : 'PMSL'
  description   : 'Sea-level Pressure'
  units         : 'Pa'
  min/max value : 95120 / 107780
  date          : '2006-04-10_00:00:00'
  map source    : 'unknown model from NCEP GRID   2'
  version       : 5
  forecast hour : 0
  level         : 201300
  ny x nx       : 73 x 144
  projection    : 0
  startlat      : 90
  startlon      : 0
  deltalat      : -2.5
  deltalon      : 2.5
  earth_radius  : 6371.23
  .
  .
  .
Field #100
  name          : 'HGT'
  description   : 'Height'
  units         : 'm'
  min/max value : 29479 / 31173
  date          : '2006-04-10_00:00:00'
  map source    : 'unknown model from NCEP GRID   2'
  version       : 5
  forecast hour : 0
  level         : 1000
  ny x nx       : 73 x 144
  projection    : 0
  startlat      : 90
  startlon      : 0
  deltalat      : -2.5
  deltalon      : 2.5
  earth_radius  : 6371.23
There were 100 fields in the NNRP:2006-04-10_00 WPS file.



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:09 +0800
# vim:set fdm=indent foldlevel=0:
