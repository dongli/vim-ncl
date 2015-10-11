THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/wrf_wps_write_int.shtml
THE_TITLE:wrf_wps_write_int

wrf_wps_write_int

   Writes data to a WPS intermediate file.

   [new.gif] Available in version 6.3.0 and later.

Prototype

        procedure wrf_wps_write_int (
                filename    [1] : string,
                field       [1] : string,
                units       [1] : string,
                description [1] : string,
                data     [*][*] : numeric,
                opt         [1] : logical
        )

Arguments

   filename

   The filename for the output WPS file.
   field

   The name of the field being written.
   units

   The units of the field being written.
   description

   The description of the field being written.
   data

   The 2D field to write to filename.
   opt

   A logical that will contain additional metadata to be written to the file.

   This logical must be set to True, and has several required attributes you must set. See the description below.

Description

   This procedure writes data to a WPS intermediate file, given a filename, field name, units, description, the field to
   write, and a logical variable containing additional attributes to write to the file.

   Here are the valid attributes that can be attached to opt:
   Attribute name Type Notes
   projection integer or string required, must be 0, 1, 3, 4, 5
   or "Equidistant_Lat_Lon", "Mercator", "Lambert", "Gaussian","Polar_Stereograhic"
   date string required
   version integer not required, defaults to 5
   forecast_hour float not required, defaults to 0.0
   map_source string not required, defaults to "Unknown data source"
   level float required
   startloc string not required, defaults to "SWCORNER"
   startlat float required
   startlon float required
   deltalat float required if projection=0; otherwise defaults to a dummy value
   deltalon float required if projection=0 or 4; otherwise defaults to a dummy value
   earth_radius float not required, defaults to 6367470. * 0.001
   dx float required if projection = 1, 3, 5; otherwise defaults to a dummy value
   dy float required if projection = 1, 3, 5; otherwise defaults to a dummy value
   truelat1 float required if projection = 1, 3, 5; otherwise defaults to a dummy value
   truelat2 float required if projection = 3; otherwise defaults to a dummy value
   center_lon float required if projection = 3 or 5; otherwise defaults to a dummy value
   nlats float required if projection = 4; otherwise defaults to a dummy value
   is_wind_earth_relative logical required

   Questions on this procedure should be sent to wrfhelp@ucar.edu.

Examples

   Example 1

   Assume you have five 3D rectilinear arrays, called U, V, T, R, Z, that are dimensioned "lev" x "lat" x "lon".

  DATE             = "2015-03-01"
  CASE             = "RCP85"
  WPS_IM_root_name = "CCSM4_CMIP5_MOAR_"+CASE
  output_file_name = WPS_IM_root_name + ":" + DATE
  earth_radius     = 6367.470

  system("/bin/rm " + output_file_name)

  FIELD_T          = "TT"
  UNITS_T          = "K"
  DESC_T           = "Temperature"

  FIELD_U          = "UU"
  UNITS_U          = "m s-1"
  DESC_U           = "Zonal Wind Speed"

  FIELD_V          = "VV"
  UNITS_V          = "m s-1"
  DESC_V           = "Meridional Wind Speed"

  FIELD_R          = "RH"
  UNITS_R          = "%K"
  DESC_R           = "Relative Humidity"

  FIELD_Z          = "GHT"
  UNITS_Z          = "m"
  DESC_Z           = "Geopotential Height"

  pnew = (/ 1000, 975, 950, 925, 900, 850, 800, 750, 700, 650, 600, 550, 500, \
             450, 400, 350, 300, 250, 200, 150, 100,  70,  50,  30,  20,  10 /)*100

  NLEV = dimsizes(pnew)

  opt                   = True
  opt@projection        = 0                 ; "Equidistant_Lat_Lon"
  opt@date              = date
  opt@map_source        = "CCSM 0.9 x 1.25"
  opt@startloc          = "SWCORNER"        ; 8 chars exact
  opt@startlon          = U&lon(0)
  opt@startlat          = U&lat(0)
  opt@deltalon          = U&lon(1) - U&lon(0)
  opt@deltalat          = U&lat(1) - U&lat(0)
  opt@is_wind_earth_rel = False

  do ilev=0,NLEV-1
    opt@level = pnew(ilev)

    wrf_wps_write_int(WPS_IM_root_name,FIELD_U,UNITS_U,\
                      DESC_U,UonP(ilev,:,:),opt)
    wrf_wps_write_int(WPS_IM_root_name,FIELD_V,UNITS_V,\
                      DESC_V,VonP(ilev,:,:),opt)
    wrf_wps_write_int(WPS_IM_root_name,FIELD_T,UNITS_T,\
                      DESC_T,TonP(ilev,:,:),opt)
    wrf_wps_write_int(WPS_IM_root_name,FIELD_R,UNITS_R,\
                      DESC_R,RonP(ilev,:,:),opt)
    wrf_wps_write_int(WPS_IM_root_name,FIELD_Z,UNITS_Z,\
                      DESC_Z,ZonP(ilev,:,:),opt)
  end do


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:16:10 +0800
# vim:set fdm=indent foldlevel=0:
