THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/random_setallseed.shtml
THE_TITLE:random_setallseed

random_setallseed

   Sets initial seeds for random number generators.

Prototype

        procedure random_setallseed (
                iseed1  : integer,
                iseed2  : integer
        )

Arguments

   iseed1

   Any integer between 1 and 2,147,483,562 (default is 1234567890).
   iseed2

   Any integer between 1 and 2,147,483,398 (default is 123456789).

Description

   This procedure is used to set the state of a random number generator. If the user does not explicitly set the seeds, they
   are set to the stated default values. It is recommended that the user specify these seeds. The source of this random
   number seed generator is from the random section at Netlib. The authors were Brian Brown and James Lovato. The official
   reference is:

     Authors: P. L'Ecuyer and S. Cote
     Title: Implementing a Random Number Package with Splitting Facilities
     Journal: ACM Transactions on Mathematical Software 17:1, pp 98-111.

See Also

   random_chi, random_gamma, random_normal, random_uniform

Examples

   Example 1

   Set seeds for generating random deviates:
  random_setallseed(36484749, 9494848)      ; Set seeds (suggested, NOT required)

   Example 2

   One method of assuring different seeds is to use some timing functions. This accesses the systen date functions. For
   example:
    rand1 = toint(systemfunc(" date +%s"))
    rand2 = toint(systemfunc(" date +%s"))
    random_setallseed(rand1, rand2)


   Testing might look like:

; test
    N     = 100
    test = random_normal(1,1,N)
    do i = 0,999
       rand1_tst = toint(systemfunc(" date +%s"))
       rand2_tst = toint(systemfunc(" date +%s"))
       random_setallseed(rand1_tst, rand2_tst)
       test = random_normal(1,1,100)
    end do


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:10:18 +0800
# vim:set fdm=indent foldlevel=0:
