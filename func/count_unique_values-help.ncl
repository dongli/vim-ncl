THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/count_unique_values.shtml
THE_TITLE:count_unique_values

count_unique_values

   Counts the number of unique values in the given array.

   [new.gif] Available in version 6.3.0 and later.

Prototype

        function count_unique_values (
                x
        )

        return_val [1] :  integer or long

Arguments

   x

   An array of any type or dimensionality.

Return value

   A scalar integer or long representing the number of unique values.

Description

   This function returns a count of all the unique values in the given array. Missing values are not included in the count.
   If the array contains all missing values, then 0 is returned. This function will work on strings or numeric values.

   Use get_unique_values if you want the unique values returned.

   Note: this function returns the equivalent of:

  unique_count = dimsizes(get_unique_values(x))

   but this creates an unnecessary copy of a subset of the original array, and can be memory intensive if you have a lot of
   values.

See Also

   get_unique_values, where, num, ind, ind_resolve

Examples

   Example 1

   Return and count the unique values of 1D integer arrays.

  a  = (/1,2,3,4,5,5,4,3,2,1,1,2,3,4,5/)
  au = get_unique_values(a)      ; (/1,2,3,4,5/)
  ac = count_unique_values(a)    ; 5

  b  = (/2,3,3,2,4,1,1,2,3,4,5,5,4,3,2,1,1,2,3,4,5/)
  bu = get_unique_values(b)      ; (/1,2,3,4,5/)
  bc = count_unique_values(b)    ; 5

  msg = -999
  c   = (/2,3,3,msg,2,4,1,1,2,3,4,msg,5,4,3,msg,1,1,2,3,4,5,msg/)
  c@_FillValue = msg
  cu = get_unique_values(c)      ; (/1,2,3,4,5/)
  cc = count_unique_values(c)    ; 5

   Example 2

   Return and count the unique values of a 1D string array.

  yr  = "Yr" + (/1911,2001,1901,1911,2001,2001,1950,1911,1950/)
  yru = get_unique_values(yr)   ; "Yr1901","Yr1911","Yr1950","Yr2001"
  yrc = count_unique_values(yr) ; 4

   Example 3

   Return the unique values of a multi-dimensional float array.

  x  = (/ (/1.5,2.8,1.6/), (/3.1,1.5,1.5/), (/2.8, 2.8, 2.8/) /)   ; 3 x 3
  xu = get_unique_values(x)      ; (1.5,1.6, 2.8, 3.1)

   Example 4

   Count the number of times a unique value appears in an array.

;---Generate an array of random years from 1900 to 2000
  years = toint(random_uniform(1900,2000,1000))

  uniq_years = get_unique_values(years)
  nuniq      = dimsizes(uniq_years)

  do i=0,nuniq-1
    print("Year " + uniq_years(i) + " appears in the array " + \
          num(years.eq.uniq_years(i)) + " times.")
  end do

   Output:
  Year 1900 appears in the array 8 times.
  Year 1901 appears in the array 8 times.
  Year 1902 appears in the array 12 times.
. . .
  Year 1997 appears in the array 3 times.
  Year 1998 appears in the array 8 times.
  Year 1999 appears in the array 8 times.


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:00:25 +0800
# vim:set fdm=indent foldlevel=0:
