Notes PML Tutorial -- YR 19 April 2020

1) as explained in the tutorial, when thresholds are 'structured' 
   (eg group.equal includes "thresholds"), then ctr_pml_plrt2() should be 
   used instead of ctr_pml_plrt() to get the model test statistic.

   in < 0.6-6, this was NOT done automatically (as reflected in the tuturial),
   but from 0.6-6 onwards, this is done automatically

2) from 0.6-6, the estimates of the polychoric estimates differ somewhat 
   for some pairs (new implementation!); this affects mostly the PML robust
   test statistic

3) on some machines, in particular for the multigroup example, you may get
   the warning:

   lavaan WARNING: Hessian is not fully symmetric.
	Max diff = 8.45073372965089
	(Max diag Hessian = 66496.3429486499)

   (possibly with different numbers). This is nothing to worry about. It is
   a new check (for YR) to evaluate the accuracy of Hessian matrices; 
   eventually, this warning will disappear again.


