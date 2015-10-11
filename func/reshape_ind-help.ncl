THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/reshape_ind.shtml
THE_TITLE:reshape_ind

reshape_ind

   Places values from a smaller one-dimensional array to a larger one-dimensional array, and reshapes it.

   [new.gif] Available in version 6.1.0 and later.

Prototype

        function reshape_ind (
                val          ,
                indexes [*], : integer or long,
                dims         : integer or long
        )

        return_val  :  typeof(val)

Arguments

   val

   A multi-dimensional array of any type. The rightmost dimension must be the 1D array that will be mapped onto the larger
   1D array.

   If this array has more than one dimension, then the rest of the dimensions (the leftmost dimensions) will be looped
   across to fill in the larger array.
   indexes

   A one-dimensional array of index values into a larger 1D array. This array must be the same length as the rightmost
   dimension of x.
   dims

   A one-dimensional array of positive values that represent the total (or just the rightmost dimensions) of the output
   array. See below for more details.

Return value

   This function returns an array of the same type as x whose leftmost dimensions are the same as all but the last dimension
   of x, and whose rightmost dimensions are dims.

Description

   This function places values from a smaller 1D array onto a larger 1D array, given the indexes into the larger 1D array,
   and then reshapes it to a multi-dimensional array. It is assumed that the dims dimensions passed to this function
   represent an nD array that the original larger 1D array can be conformed to.

   If the x input array has multiple dimensions, then the leftmost dimensions of x will be prepended to the dims dimensions
   to create the dimensions for the output array. See the examples below for better understanding.

   This function was specially written to handle a suite of examples for regridding unstructured grids to structured grids.
   The underlying software requires that the calculations be done with one-dimensional arrays, and this function is useful
   when you need to put those 1D values back onto 2D grids.

   Metadata are not copied, except for the "_FillValue" attribute. To copy metadata, use copy_VarMeta.

   Note: a bug was fixed in version 6.1.1 which caused this function to only allow numeric types. It will now handle other
   types, like strings.

See Also

   reshape, conform, conform_dims, ndtooned, onedtond

Examples

   Example 1

   Assume you have an array of indexes of length nvals that represent index values into an array with 10,000 elements.
   Assume you have a smaller 1D array x also of length nvals that you want to place into the larger array, and then reshape
   it to a 100 x 100 array:
    x2d = reshape_ind(x,indexes,(/100,100/))

   Example 2

   Assume that indexes is the same as in example 1, but now x is dimensioned 3 x 10 x nvals. You can use the same call as in
   example 1 to reshape the array:
    x4d = reshape_ind(x,indexes,(/100,100/))

   x4d will be dimensioned 3 x 10 x 100 x 100.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:10:35 +0800
# vim:set fdm=indent foldlevel=0:
