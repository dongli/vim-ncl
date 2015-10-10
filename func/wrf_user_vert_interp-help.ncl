THE_URL:https://www.ncl.ucar.edu/Document/Functions/WRF_arw/wrf_user_vert_interp.shtml
THE_TITLE:wrf_user_vert_interp

wrf_user_vert_interp

   Vertically interpolates ARW WRF variables given the type of surface and a set of new levels.

   [new.gif] Available in version 6.3.0 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"

        function wrf_user_vert_interp (
                file_handle         : file or list,
                field               : numeric,
                vert_coordinate [1] : string,
                interp_levels   [*] : numeric,
                opts            [1] : logical
        )

        return_val  :  numeric

Arguments

   file_handle

   Reference to an input netCDF file opened with addfile, or list of NetCDF files opened with addfiles.
   field

   The field variable to be interpolated. This must be a 3D array dimensioned bottom_top x south_north x west_east, or a 4D
   array dimensioned time x bottom_top x south_north x west_east.
   vert_coordinate

   A scalar string indicating the type of surface to interpolate to. Valid strings are:

     * "pressure", "pres" - pressure [hPa]
     * "ght_msl" - grid point height msl [km]
     * "ght_agl" - grid point height agl [km]
     * "theta" - potential temperature [K]
     * "theta-e" - equivalent potential temperature [K]

   interp_levels

   A 1D array of vertical levels to interpolate to.
   opts

   A scalar logical that can be set to True to indicate additional options attached as attributes. Valid attributes are:

     * opts@extrapolate (logical) - whether to extrapolate values below ground (default=False)
     * opts@field_type (string) - the type of field; valid values are:

     * "ght"
     * "pressure", "pres", "p"
     * "t"
     * "z"
     * "none"

     opts@logP (logical) - use the log of the pressure for interpolation instead of just pressure (default=False)

Return value

   The return variable will be the same dimensionality as field, except with the level dimension replaced by the number of
   new levels. An attribute called "vert_interp_type" will be added to indicate the type of interpolation done.

Description

   This function does a vertical interpolation of ARW WRF variables to several possible surfaces: Pressure, Height, AGL,
   Height MSL, Potential Temperature and Equivalent Potential Temperature. It also does an extrapolation below ground level
   and above the model surfaces.

   wrf_user_vert_interp is part of a library of functions and procedures in WRFUserARW.ncl written to help users plot ARW
   WRF model data.

   Questions on this function should be sent to wrfhelp@ucar.edu.

See Also

   See the full list of WRF functions.

Examples

  filename = "wrfout_d01_1991-01-01_00:00:00"
  fin      = addfile(filename+".nc","r")

  fld = wrf_user_getvar(fin,"tk",-1)     ; The variable to interpolate

  vert_coord       = "theta"
  interp_levels    = ispan(200,1000,50)

  opts             = True
  opts@extrapolate = True
  opts@field_type  = "T"
  opts@logP        = True

  fld_intrp = wrf_user_vert_interp(fin,fld,vert_coord,interp_levels,opts)
  printVarSummary(fld_intrp)

   The output will be:

Variable: fld_intrp
Type: float
Total Size: 7493940 bytes
            1873485 values
Number of Dimensions: 4
Dimensions and sizes:[Time | 1] x [interp_levels | 17] x [south_north | 279] x [west_east | 395]
Coordinates:
            interp_levels: [1000..200]
Number Of Attributes: 8
_FillValue :9.96921e+36
description :Temperature
FieldType :104
MemoryOrder :XYZ
units :K
stagger :
coordinates :XLONG XLAT
vert_interp_type :theta



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:22:02 +0800
# vim:set fdm=indent foldlevel=0:
