!---------------------------------------------------------------------
! File: p4.f90
! Author: Viet Truong, masc0859
!
! Description: 
! Fortran 90 program based on the traveling salesman problem.
! By using the brute force method, it calculates the distance between
! all permutations of locations, and keeping the smallest total distance
! on a running counter. Input is taken in from a .txt file that will
! be provided by the instructor
!
! Written for CS 320, SDSU, October 19, 2014
!---------------------------------------------------------------------

PROGRAM p4
	IMPLICIT NONE

	CHARACTER(128) :: fileName
	INTEGER :: permutations, innerCount, outerCount, distance=0, best_distance=99999, status
	CHARACTER(20), ALLOCATABLE :: city(:) ! Array of characters to hold town names, 50 char each
	INTEGER, ALLOCATABLE:: d_table(:,:), path(:), best_path(:)

	WRITE(*, "(A)") "Program #4, masc0859, Viet Truong"
	WRITE(*, "(A)") "Enter filename:"
	READ*, fileName
	PRINT*

	! Opens and reads files
	OPEN(UNIT=10, FILE=fileName, IOSTAT=status)
	IF (status /= 0) THEN
		PRINT*, "Error opening file"
		STOP
	END IF

	READ(10, *, IOSTAT=status) permutations ! Grab the number of towns from text file
	IF (status /= 0) THEN
		PRINT*, "Error reading values"
		STOP
	END IF

	! Allocate spaces based on input from text file
	ALLOCATE(city(permutations), STAT = status)
	IF (status /= 0) STOP
	ALLOCATE(d_table(permutations,permutations), STAT = status)
	IF (status /= 0) STOP
	ALLOCATE(path(permutations), STAT=status)
	IF (status /= 0) STOP
	ALLOCATE(best_path(permutations),STAT=status)
	IF (status /=0) STOP

	DO outerCount=1, permutations
		path(outerCount) = outerCount
		best_path(outerCount) = outerCount
	END DO

	! Grab values from text file
	DO outerCount=1, permutations
		READ(10, FMT="(A)", IOSTAT=status) city(outerCount)
		DO innercount=1,permutations
			READ(10,*) d_table(outerCount, innerCount)
		END DO
	END DO

	! Closes file that we opened
	CLOSE(10)

	WRITE(*, "(A)") "Calculating:"
	PRINT*
	CALL permute(2, permutations)

	call print_answer(2, permutations)

CONTAINS

! Prints best path and distance based on permutation algorithm
SUBROUTINE print_answer(first, last)
	IMPLICIT NONE
	INTEGER, INTENT(IN) :: first, last
	PRINT*, "------------------------------"
	WRITE(*, "(A)") TRIM(ADJUSTL("The best path is: "))
    WRITE(*, 100) TRIM(ADJUSTL(city(1))), TRIM(ADJUSTL(city(best_path(2)))), &
    	d_table(1, best_path(2))
    DO outerCount=2, last-1
		WRITE(*, 100) TRIM(ADJUSTL(city(best_path(outerCount)))), &
			TRIM(ADJUSTL(city(best_path(outerCount+1)))), &
			d_table(best_path(outerCount),best_path(outerCount+1))
	END DO
	WRITE(*, 100) TRIM(ADJUSTL(city(best_path(last)))), TRIM(ADJUSTL(city(best_path(1)))), &
		d_table(best_path(last),path(1))
	PRINT *
	WRITE(*,"(A, I6, A)") "Best distance is: ", best_distance, " miles"
	100 FORMAT (A, " to ", A, " --", I6, " miles")
END SUBROUTINE print_answer


! Recursively calculates best distance by iterating through every sum
RECURSIVE SUBROUTINE permute(first, last)
INTEGER, INTENT(IN) :: first, last
INTEGER :: i, temp
	IF(first == last)  THEN
	distance = d_table(1,path(2))
	WRITE(*, 100) TRIM(ADJUSTL(city(1))), TRIM(ADJUSTL(city(path(2)))), d_table(1, path(2))
	DO i=2, last-1
		distance = distance + d_table(path(i),path(i+1))
		WRITE(*, 100) TRIM(ADJUSTL(city(path(i)))), TRIM(ADJUSTL(city(path(i+1)))),&
		d_table(path(i),path(i+1))
	END DO
	distance = distance + d_table(path(last),path(1))
	WRITE(*,100) TRIM(ADJUSTL(city(path(last)))), TRIM(ADJUSTL(city(path(1)))), &
		d_table(path(last),path(1))
	WRITE(*, "(A, I6)") "Distance is ",distance
	PRINT *
	IF(distance < best_distance) THEN
		best_distance = distance
		DO i=2, last
			best_path(i) = path(i)
		END DO
	END IF

	ELSE
		DO i=first, last
			temp = path(first)
			path(first) = path(i)
			path(i) = temp

			call permute(first+1,last)

			temp = path(first)
			path(first) = path(i)
			path(i) = temp
		END DO
	END IF
	100 FORMAT (A, " to ", A, " --", I6, " miles")
END SUBROUTINE permute
END PROGRAM p4