traveling-salesman-fortran
==========================

Program written in Fortran 90. Finds the fastest route given a number of stops and distances between all locations using brute force calculation of all permutations. The permutation algorithm has a complexity of O(n!)

Sample text file:
4
SanDiego
0
350
900
1100
Phoenix
350
0
560
604
Denver
900
560
0
389
Dallas
1100
604
389
0

This denotes there are 4 different locations, and the distance between each stop. The results would be as follows:

Calculating:

SanDiego to Phoenix --   350 miles
Phoenix to Denver --   560 miles
Denver to Dallas --   389 miles
Dallas to SanDiego --  1100 miles
Distance is   2399

SanDiego to Phoenix --   350 miles
Phoenix to Dallas --   604 miles
Dallas to Denver --   389 miles
Denver to SanDiego --   900 miles
Distance is   2243

SanDiego to Denver --   900 miles
Denver to Phoenix --   560 miles
Phoenix to Dallas --   604 miles
Dallas to SanDiego --  1100 miles
Distance is   3164

SanDiego to Denver --   900 miles
Denver to Dallas --   389 miles
Dallas to Phoenix --   604 miles
Phoenix to SanDiego --   350 miles
Distance is   2243

SanDiego to Dallas --  1100 miles
Dallas to Denver --   389 miles
Denver to Phoenix --   560 miles
Phoenix to SanDiego --   350 miles
Distance is   2399

SanDiego to Dallas --  1100 miles
Dallas to Phoenix --   604 miles
Phoenix to Denver --   560 miles
Denver to SanDiego --   900 miles
Distance is   3164

 ------------------------------
The best path is:
SanDiego to Phoenix --   350 miles
Phoenix to Dallas --   604 miles
Dallas to Denver --   389 miles
Denver to SanDiego --   900 miles

Best distance is:   2243 miles
