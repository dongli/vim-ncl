THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/area_poly_sphere.shtml
THE_TITLE:area_poly_sphere

area_poly_sphere

   Calculates the area enclosed by an arbitrary polygon on the sphere.

   [new.gif] Available in version 6.2.0 and later.

Prototype

        function area_poly_sphere (
                lat  [*] : numeric,
                lon  [*] : numeric,
                rsph [1] : numeric
        )

        return_val  :  numeric

Arguments

   lat
   lon

   Latitudes and longitudes, in degrees, of the polygon (vertex) locations. These must be in clockwise order. This is the
   user's responsibility.
   rsph

   Radius of the sphere to be used for the area calculation. rsph=1 will return the area in units of radians; rsph=6271 km
   would return the area in km^2; rsph=6.37122e06 m would yield m^2.

Return value

   The desired spherical area in units of rsph. The return value will be of type double if any of the input arguments is of
   type double and type float otherwise.

Description

   This function finds the area of a polygon patch on the sphere whose vertices are given in degrees as lat/lon pairs. The
   method uses line integrals. The lat/lon values must be in clockwise order.

Reference:  Computing the Area of a Spherical Polygon of Arbitrary Shape
            Bevis and Cambareri (1987)
            Mathematical Geology, vol.19, Issue 4, pp 335-346

   Missing values are not allowed since it makes no sense to have polygon entries specified as a missing value. It is the
   user's responsibility to make sure all values are valid locations.

See Also

   gc_tarea, gc_tarea, gc_clkwise

Examples

   Example 1

   The following shows that area_poly_sphere matches the results of Example 1 returned by gc_qarea. The points are in
   clockwise order but use gc_clkwise to verify.
    rsph = 1.0                                ; return area will be radians
    qlat = (/90.0,   0.0, -90.0,  0.0/)
    qlon = (/ 0.0, -90.0,   0.0, 90.0/)

    qorder     = gc_clkwise(qlat, qlon)  ; not required
    qarea_gc   = gc_qarea(qlat, qlon)
    qarea_poly = area_poly_sphere(qlat, qlon, rsph)
    print ("qarea_gc="+qarea_gc+"   qarea_poly="+qarea_poly+"  qorder="+qorder)

   The returned result is:

    qarea_gc=6.28319   qarea_poly=6.28319  qorder=True


   Example 2

   The following shows that area_poly_sphere matches the results of Example 1 returned by gc_tarea. The points are in
   clockwise order but use gc_clkwise to verify.
    rsph = 1.0                           ; return area will be radians
    tlat = (/0.0, 90.0, 0.0/)
    tlon = (/0.0,  0.0,90.0/)

    torder     = gc_clkwise(tlat, tlon)  ; not required
    tarea_gc   = gc_tarea(tlat, tlon)
    tarea_poly = area_poly_sphere(tlat, tlon, rsph)
    print ("tarea_gc="+tarea_gc+"   tarea_poly="+tarea_poly+"  torder="+torder)

   The returned result is:

    tarea_gc=1.5708   tarea_poly=1.5708  torder=True

   Example 3

   This is the same as Example 2 but the lat/lon locations are not in clockwise order. Since the area_poly_sphere does not
   check for clockwise order, it will return an incorrect result with no error message.

    tlat       = (/0.0, 0.0, 90.0/)    ; not clockwise
    tlon       = (/0.0, 90.0, 0.0/)
    torder     = gc_clkwise(tlat, tlon)  ; False
               ; an incorrect result would be returned (no warning)
    tarea_wrong= area_poly_sphere(tlat, tlon, rsph)


   The robust way would be

    if (gc_clkwise(tlat, tlon)) then
        tarea_poly = area_poly_sphere(tlat, tlon, rsph)
    else
       print ("Points are not in clockwise order.")
       exit
    end if

   Example 4

   Read the shapefile associated with the Mississippi River Basin which is distributed with NCL. The latitudes and
   longitudes are type double. Hence, the computed enclosed area will be type double. The returned area wil vary depending
   upon the user's choice of rsph. Note: Generally, shapefile lat/lon pairs are in clockwise order. Still, the example uses
   gc_clkwise to verify that this is true.


;---Open shapefile and read lat/lon values.
    dir     = ncargpath("data") + "/shp/"
    f       = addfile(dir + "mrb.shp", "r")
    mrb_lon = f->x                 ; type double
    mrb_lat = f->y

    n_mrb   = dimsizes(mrb_lat)    ; 88565
    print("n_mrb="+n_mrb)

    re      = 6371.
    re@units= "km"

    if (gc_clkwise(mrb_lat, mrb_lon)) then
        area_mrb = area_poly_sphere(mrb_lat, mrb_lon, re)

        area_mrb@units     = "km^2"
        area_mrb@long_name = "Area Enclosed by the MRB"

        print (area_mrb)
    else
        print ("MRB points are not in clockwise order.")
        exit
    end if


   The result is:

    Variable: area_mrb
    Type: double
    Total Size: 8 bytes
                1 values
    Number of Dimensions: 1
    Dimensions and sizes:       [1]
    Coordinates:
    Number Of Attributes: 2
      long_name :       Area Enclosed by the MRB
      units :   km^2

    (0) 3253197.133436443


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 22:59:18 +0800
# vim:set fdm=indent foldlevel=0:
