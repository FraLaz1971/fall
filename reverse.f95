!program that
!defines an integer array to have 10 elements
!a) fills the array with ten numbers
!b) reads in 2 numbers (in the range 1-10)
!c) reverses the order of the array elements in the range specified by the two numbers.
!Try not to use an additional array.
PROGRAM REVERS
  IMPLICIT NONE
  INTEGER :: A1(10),i,LB,UB,TEMP
  REAL :: GETRAN
  LOGICAL DEBUG
  DEBUG=.TRUE.
! FILL THE ARRAY WITH 10 RANDOM INTEGERS
  CALL INI_RAN
  do i=1,10
    A1(i)=NINT(GETRAN(100.0))
  end do  
  PRINT *,'A1 = ',A1
! READ LOWER BOUND
  PRINT *,'ENTER LOWER BOUND (1,10)'
  READ *, LB
! READ UPPER BOUND
  PRINT *,'ENTER UPPER BOUND (1,10)'
  READ *, UB
! NOW REVERSE
  PRINT *,'LB,UB=',LB,UB
  DO i=LB,(LB+UB)/2
    IF (DEBUG) PRINT *,I,A1(I),A1(UB-(I-LB))
    TEMP=A1(i)
	A1(i)=A1(UB-(I-LB))
	A1(UB-(I-LB))=TEMP
    IF (DEBUG) PRINT *,I,A1(I),A1(UB-(I-LB))
  END DO
  PRINT *,'REVERSED:',A1(LB:UB)
END
