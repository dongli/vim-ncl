THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/rdsstoi.shtml
THE_TITLE:rdsstoi

rdsstoi

   Reads weekly/monthly compocp site and climatology grids.

Prototype

        function rdsstoi (
                nyrstrt  : integer,
                nyrlast  : integer,
                mlon     : integer,
                nlat     : integer,
                info [9] : integer
        )

        return_val [180][360] :  float

Arguments

   nyrstrt
   nyrlast

   Start and end years for selecting data.
   mlon
   nlat

   Used for error checking.
   info

   Date and error information (info(8) has error info).

Description

   This function reads weekly/monthly compocp site and climatology grids, and returns a float array dimensioned 180 x 360
   (latitude x longitude).


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:10:23 +0800
# vim:set fdm=indent foldlevel=0:
