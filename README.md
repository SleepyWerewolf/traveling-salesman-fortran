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

This denotes there are 4 different locations, and the distance between each stop. Here is a better representation of the information above: 


