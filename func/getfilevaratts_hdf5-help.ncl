THE_URL:https://www.ncl.ucar.edu/Document/Functions/Contributed/getfilevaratts_hdf5.shtml
THE_TITLE:getfilevaratts_hdf5

getfilevaratts_hdf5

   Parse a HDF5 global attribute into an array containing KEYWORDs and associated VALUEs.

   [new.gif] Available in version 6.3.1 and later.

Prototype

load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

        procedure getfilevaratts_hdf5 (
                f           ,
                attName [1] : string
        )

Arguments

   f

   A file or group reference.
   attName

   The global attribute to be parsed.

Description

   Some HDF5 global attributes consist of one string which contains carriage returns, equals ("=") and end of line
   characters (eg, ";"). The string to the left of the "=" is the KEYWORD. The string to the right of the "=" is the
   associated VALUE. See example below. These are returned as a [*][2]:string so that subsequently, selected attribues may
   be extracted. THe KEYWORD is the 0-th element and the associated VALUE is the 1-th element.

See Also

   extract_filevaratts_hdf5

Examples

   Example 1

    fn = "3B-MO.MS.MRG.3IMERG.20140701-S000000-E235959.07.V03D.HDF5"
    f  = addfile( fn, "r")
    print( f )

    print("===========")
    print("   TEST_1  ")
    print("===========")

    finfo1:= getfilevaratts_hdf5(f,"FileHeader")
    printVarSummary(finfo1)
    print("===========")
    print(finfo1(:,0)+"  "+finfo1(:,1))
    print("===========")
    value11 := extract_filevaratts_hdf5(finfo1,"SatelliteName")
    value12 := extract_filevaratts_hdf5(finfo1,"GenerationDateTime")
    value13 := extract_filevaratts_hdf5(finfo1,"TimeInterval")

    print(value11)
    print(value12)
    print(value13)

    print("===========")
    print("   TEST_2  ")
    print("===========")

    finfo2:= getfilevaratts_hdf5(f,"FileInfo")
    printVarSummary(finfo2)
    print("===========")
    print(finfo2(:,0)+"  "+finfo2(:,1))
    print("===========")
    value21 := extract_filevaratts_hdf5(finfo2,"FormatPackage")
    value22 := extract_filevaratts_hdf5(finfo2,"MetadataStyle")
    value23 := extract_filevaratts_hdf5(finfo2,"EndianType")

    print(value21)
    print(value22)
    print(value23)


   The edited output from the above is


Variable: f
Type: file
filename:       3B-MO.MS.MRG.3IMERG.20140701-S000000-E235959.07.V03D
path:   3B-MO.MS.MRG.3IMERG.20140701-S000000-E235959.07.V03D.HDF5
   file global attributes:
      FileHeader : DOI=10.5067/GPM/IMERG/MONTH/3B;
DOIauthority=http://dx.doi/org/;
DOIshortName=3IMERGM;
AlgorithmID=3IMERGM;
AlgorithmVersion=3IMERGM_1.0;
FileName=3B-MO.MS.MRG.3IMERG.20140701-S000000-E235959.07.V03D.HDF5;
SatelliteName=MULTI;
InstrumentName=MERGED;
GenerationDateTime=2015-01-21T16:13:51.000Z;
StartGranuleDateTime=2014-07-01T00:00:00.000Z;
StopGranuleDateTime=2014-07-31T23:59:59.999Z;
GranuleNumber=;
NumberOfSwaths=0;
NumberOfGrids=1;
GranuleStart=;
TimeInterval=MONTH;
ProcessingSystem=PPS;
ProductVersion=V03D;
EmptyGranule=NOT_EMPTY;
MissingData=;

      FileInfo  : DataFormatVersion=bh;
TKCodeBuildVersion=1;
MetadataVersion=bh;
FormatPackage=HDF5-1.8.9;
BlueprintFilename=GPM.V1.3IMERGM.redprint.xml;
BlueprintVersion=BV_42;
TKIOVersion=3.60.8;
MetadataStyle=PVL;
EndianType=LITTLE_ENDIAN;

[SNIP]
      group <\/Grid>

         GridHeader  :   BinMethod=ARITHMETIC_MEAN;
Registration=CENTER;
LatitudeResolution=0.1;
LongitudeResolution=0.1;
NorthBoundingCoordinate=90;
SouthBoundingCoordinate=-90;
EastBoundingCoordinate=180;
WestBoundingCoordinate=-180;
Origin=SOUTHWEST;
[SNIP]



Variable: finfo1
Type: string
Total Size: 320 bytes
            40 values
Number of Dimensions: 2
Dimensions and sizes:   [20] x [2]
Coordinates:
Number Of Attributes: 2
  _FillValue :  missing
  hdf5_global_attribute_name :  FileHeader
(0)     ===========
(0)     DOI  10.5067/GPM/IMERG/MONTH/3B
(1)     DOIauthority  http://dx.doi/org/
(2)     DOIshortName  3IMERGM
(3)     AlgorithmID  3IMERGM
(4)     AlgorithmVersion  3IMERGM_1.0
(5)     FileName  3B-MO.MS.MRG.3IMERG.20140701-S000000-E235959.07.V03D.HDF5
(6)     SatelliteName  MULTI
(7)     InstrumentName  MERGED
(8)     GenerationDateTime  2015-01-21T16:13:51.000Z
(9)     StartGranuleDateTime  2014-07-01T00:00:00.000Z
(10)    StopGranuleDateTime  2014-07-31T23:59:59.999Z
(11)    GranuleNumber
(12)    NumberOfSwaths  0
(13)    NumberOfGrids  1
(14)    GranuleStart
(15)    TimeInterval  MONTH
(16)    ProcessingSystem  PPS
(17)    ProductVersion  V03D
(18)    EmptyGranule  NOT_EMPTY
(19)    MissingData
(0)     ===========

Variable: value11
Type: string
Number Of Attributes: 2
  hdf5_global_attribute_name :  FileHeader
  _FillValue :  missing

(0)     MULTI

Variable: value12
Type: string
Dimensions and sizes:   [1]
Coordinates:
Number Of Attributes: 2
  hdf5_global_attribute_name :  FileHeader
  _FillValue :  missing

(0)     2015-01-21T16:13:51.000Z


Variable: value13
Type: string
Total Size: 8 bytes
            1 values
Number of Dimensions: 1
Dimensions and sizes:   [1]
Coordinates:
Number Of Attributes: 2
  hdf5_global_attribute_name :  FileHeader
  _FillValue :  missing

(0)     MONTH

0)     ===========
(0)        TEST_2
(0)     ===========

Variable: finfo2
Type: string
Total Size: 144 bytes
            18 values
Number of Dimensions: 2
Dimensions and sizes:   [9] x [2]
Coordinates:
Number Of Attributes: 2
  _FillValue :  missing
  hdf5_global_attribute_name :  FileInfo
(0)     ===========
(0)     DataFormatVersion  bh
(1)     TKCodeBuildVersion  1
(2)     MetadataVersion  bh
(3)     FormatPackage  HDF5-1.8.9
(4)     BlueprintFilename  GPM.V1.3IMERGM.blueprint.xml
(5)     BlueprintVersion  BV_42
(6)     TKIOVersion  3.60.8
(7)     MetadataStyle  PVL
(8)     EndianType  LITTLE_ENDIAN
(0)     ===========


Variable: value21
Number Of Attributes: 2
  hdf5_global_attribute_name :  FileInfo
  _FillValue :  missing

(0)     HDF5-1.8.9


Variable: value22
Number Of Attributes: 2
  hdf5_global_attribute_name :  FileInfo
  _FillValue :  missing

(0)     PVL


Variable: value23
  hdf5_global_attribute_name :  FileInfo
  _FillValue :  missing

(0)     LITTLE_ENDIAN

(0)     ++++++++++++++++++++++++++++++++++++++++++++++
(0)        Group Attribute tests
(0)     ++++++++++++++++++++++++++++++++++++++++++++++
(0)     BinMethod=ARITHMETIC_MEAN;

Registration=CENTER;
LatitudeResolution=0.1;
LongitudeResolution=0.1;
NorthBoundingCoordinate=90;
SouthBoundingCoordinate=-90;
EastBoundingCoordinate=180;
WestBoundingCoordinate=-180;
Origin=SOUTHWEST;


Variable: ginfo1
Type: string
Total Size: 144 bytes
            18 values
Number of Dimensions: 2
Dimensions and sizes:   [9] x [2]
Coordinates:
Number Of Attributes: 2
  _FillValue :  missing
  hdf5_global_attribute_name :  GridHeader
(0)     ===========
(0)     BinMethod  ARITHMETIC_MEAN
(1)     Registration  CENTER
(2)     LatitudeResolution  0.1
(3)     LongitudeResolution  0.1
(4)     NorthBoundingCoordinate  90
(5)     SouthBoundingCoordinate  -90
(6)     EastBoundingCoordinate  180
(7)     WestBoundingCoordinate  -180
(8)     Origin  SOUTHWEST
(0)     ===========

Variable: gval1
Number Of Attributes: 2
  hdf5_global_attribute_name :  GridHeader
  _FillValue :  missing

(0)     CENTER


Variable: gval2
Number Of Attributes: 2
  hdf5_global_attribute_name :  GridHeader
  _FillValue :  missing

(0)     SOUTHWEST


Variable: gval3
Number Of Attributes: 2
  hdf5_global_attribute_name :  GridHeader
  _FillValue :  missing

(0)     0.1






   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:19:19 +0800
# vim:set fdm=indent foldlevel=0:
