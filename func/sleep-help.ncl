THE_URL:https://www.ncl.ucar.edu/Document/Functions/Built-in/sleep.shtml
THE_TITLE:sleep

sleep

   Pauses execution of NCL scripts for a specified number of seconds.

Prototype

        procedure sleep (
                seconds [1] : integer
        )

Arguments

   seconds

   A single positive integer value representing the number of seconds to pause script execution.

Description

   This procedure pauses script execution for the specified number of seconds.

Examples

   Example 1

   Wait 5 seconds before proceeding to the next iteration.
begin
  do year = 79, 81
     system("export YEAR = "+ year +"; echo $YEAR ; ncl myscript.ncl &")
     sleep(5)
  end do
end


   ©2015 UCAR | Privacy Policy | Terms of Use | Contact the Webmaster | Sponsored by NSF
2015-10-03 23:11:22 +0800
# vim:set fdm=indent foldlevel=0:
