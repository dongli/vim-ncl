THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/create_graphic.shtml
THE_TITLE:create_graphic

create_graphic

   Creates a graphic object

Prototype

        function create_graphic (
                name      [*] : string,
                class         : string,
                parent        : graphic or string,
                resources [1] : logical
        )

Arguments

   name

   One or more strings representing the names of graphic objects to be created. As many objects will be created as there are
   strings in this argument.
   class

   A string naming the class of graphic objects to be created.
   parent

   The object id of the parent object, or one of the following strings: "defaultapp", "noparent", or "null"
   resources

   A logical variable with the resources as attributes of this variable. These resources will be applied at the creation of
   each graphic object.

Description

   This function creates one or more graphic objects, with names as given by the first argument. All the objects must belong
   to the same class as specified in the second argument. The class name must be one of the publicly accessible graphic
   object classes, as follows:
     * annoManagerClass
     * appClass
     * contourPlotClass
     * coordArraysClass
     * documentWorkstationClass
     * graphicStyleClass
     * imageWorkstationClass
     * irregularPlotClass
     * labelBarClass
     * legendClass
     * logLinPlotClass
     * mapPlotClass
     * meshScalarFieldClass
     * ncgmWorkstationClass
     * pdfWorkstationClass
     * primitiveClass
     * psWorkstationClass
     * scalarFieldClass
     * streamlinePlotClass
     * textItemClass
     * tickMarkClass
     * titleClass
     * vectorFieldClass
     * vectorPlotClass
     * windowWorkstationClass
     * xWorkstationClass
     * xyPlotClass

   Since the argument is a string the class name must be enclosed in quotes.

   The third argument specifies the parent object of the objects to be created . All view class objects (i.e. objects that
   are potentially visible in a plot) must have an object belonging to one of the workstation classes as a parent. Objects
   belonging to other classes can either have no parent, specified using one of the pre-defined synonymous strings
   ("defaultapp", "noparent", or "null"), or they can have an object of the appClass as a parent. An app class parent allows
   the object to have resources set using a resource file that has as its base name the name of the parent app.

   The resources argument is a logical variable to which resources are attached as attributes. It must be set to True for
   the resources to be passed into the object creation routine.

   This routine provides a functional interface to the create visualization block that follows the model of the "gsn"
   graphical functions for setting resource values via attributes. It can help simplify code by making it easier to
   dynamically adjust the set of resources passed to the graphic object.

See Also

   attsetvalues

Examples

   Example 1

   Here is a simple example taken from gsn_code.ncl. Notice how the sfMissingValueV resource is set only if the data has a
   _FillValue attribute. In order to do the same thing using a create visualization block, the block would need to be
   included in both the clauses of an if-then-else statement, once with the sfMissingValueV set and once without it.

        mres = True
        mres@sfXCellBounds = res2@sfXCellBounds
        mres@sfYCellBounds = res2@sfYCellBounds
        mres@sfDataArray = data
        if(isatt(data,"_FillValue")) then
          mres@sfMissingValueV = data@_FillValue
        end if
        data_object = create_graphic("mesh_sf","meshScalarFieldClass","null",mres)


   Example 2

   This example shows the creation and rendering of a contour plot object using the data_object defined in the first example

        wks = gsn_open_wks("x11","test_contour")
        res = True
        res@cnScalarFieldData = data_object
        res@cnFillOn = True
        res@cnFillMode = "CellFill"
        cn_plot = create_graphic("cn","contourPlotClass",wks,res)
        draw(cn_plot)
        frame(wks)



   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:00:31 +0800
# vim:set fdm=indent foldlevel=0:
