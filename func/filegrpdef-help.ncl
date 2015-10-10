THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/filegrpdef.shtml
THE_TITLE:filegrpdef

filegrpdef

   Defines a list of group (names), for a supported file, or group.

   [new.gif] Available in version 6.1.0 and later.

Prototype

        procedure filegrpdef (
                thefile   [1] : file,
                grp_names [*] : string
        )

Description

   This procedure defines one or more groups in a netCDF(4) or HDF(5) file to be created. grp_names can contain multiple
   names of groups.

See Also

   getfilegrpnames, fileattdef, filedimdef, filevarattdef

Examples

   Example 1

   Create groups in a HDF5 file named "myfile.h5".
  f = addfile("myfile.h5","c")
  grpnames = (/"grp1", "group2", "g3"/)
  filegrpdef(f, grpnames)

   "h5dump myfile.h5" produces the following output:
HDF5 "myfile.h5" {
GROUP "/" {
   GROUP "g3" {
   }
   GROUP "group2" {
   }
   GROUP "grp1" {
   }
}
}

   Example 2

   Write one 2D array and two 3D arrays (with dimension names "lev", "lat", and "lon") to a netCDF file called "myfile.nc"
   under group "grp1":
 f = addfile("myfile.nc","c")

 grpnames = (/"grp1", "group2", "g3"/)

 filegrpdef(f, grpnames)

 g = f=>grp1

 filedimdef(g,(/"lev","lat","lon"/),(/2,2,3/),(/False,False,False/))

 var_names2D = (/ "PS" /)
 var_names3D = (/ "T", "Q" /)
 varvar_types2D = (/ "float" /)
 varvar_types3D = (/ "float", "float" /)

 filevardef(g, (/"lev"/), (/"float"/), (/"lev"/) )
 filevardef(g, (/"lat"/), (/"float"/), (/"lat"/) )
 filevardef(g, (/"lon"/), (/"float"/), (/"lon"/) )
 filevardef(g, var_names2D, varvar_types2D, (/  "lat", "lon" /) )
 filevardef(g, var_names3D, varvar_types3D, (/  "lev", "lat", "lon" /) )

 lev = fspan(1, 2, 2)
 lat = fspan(3, 4, 2)
 lon = fspan(5, 7, 3)

 ps = new((/2,3/), float)
 t = new((/2,2,3/), float)
 q = new((/2,2,3/), float)

 ps = 1000.0
 t  = 273.15
 q  = 0.015

 g->lev = lev
 g->lat = lat
 g->lon = lon
 g->PS = ps
 g->T = t
 g->Q = q

   "ncdump myfile.nc" produces the following output:
netcdf myfile {

group: grp1 {
  dimensions:
        lev = 2 ;
        lat = 2 ;
        lon = 3 ;
  variables:
        float lev(lev) ;
        float lat(lat) ;
        float lon(lon) ;
        float PS(lat, lon) ;
                PS:_FillValue = 9.96921e+36f ;
        float T(lev, lat, lon) ;
                T:_FillValue = 9.96921e+36f ;
        float Q(lev, lat, lon) ;
                Q:_FillValue = 9.96921e+36f ;
  data:

   lev = 1, 2 ;

   lat = 3, 4 ;

   lon = 5, 6, 7 ;

   PS =
  1000, 1000, 1000,
  1000, 1000, 1000 ;

   T =
  273.15, 273.15, 273.15,
  273.15, 273.15, 273.15,
  273.15, 273.15, 273.15,
  273.15, 273.15, 273.15 ;

   Q =
  0.015, 0.015, 0.015,
  0.015, 0.015, 0.015,
  0.015, 0.015, 0.015,
  0.015, 0.015, 0.015 ;
  } // group grp1

group: group2 {
  } // group group2

group: g3 {
  } // group g3
}


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:04:05 +0800
# vim:set fdm=indent foldlevel=0:
