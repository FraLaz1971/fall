!Write a program to find the root of the equation f (x) = 0 which lies in a specified interval.
!The program should use an external function to define the equation, and the user should
!input the details of the interval in which the root lies and the accuracy required.
!Structure plan:
!1.Read range (left and right), tolerance and maximum iterations
!2.Call subroutine bisect to find a root in the interval (left, right)
!3.If root found then
!    3.1 Print root
!  otherwise
!    3.2 Print error message
MODULE constants
	IMPLICIT NONE
	!
	! Define a kind type q to have at least 6 decimal digits
	! and an exponent range form 10**30 to 10**(-30)
	INTEGER, PARAMETER :: q = SELECTED_REAL_KIND(P=6, R=30)
END MODULE constants
PROGRAM roots
  USE constants
  IMPLICIT NONE
!  INTEGER, PARAMETER :: real_6_38 = SELECTED_REAL_KIND(P=6, R=38)
!
! This program finds a root of the equation f(x)=0 in a
! specified interval to within a specified tolerance of
! the true root, by using the bisection method
!
! Input variables
  REAL(KIND=q) :: left, right, tolerance
  INTEGER :: maximum_iterations
!
! Other variables
  REAL(KIND=q) :: zero, delta
  INTEGER :: number_of_bisections, err
!
  CHARACTER*80 IFNAM
  INTEGER :: i,DOM,IER,PGBEG
  INTEGER :: MDIM
  REAL, PARAMETER :: pi = 3.141593
  REAL :: xr(4096), yr(4096), myfun, myfun2, myfun3, myfun4, step, x_left, x_right
  REAL(KIND=q), EXTERNAL :: f
!
!
! Get range and tolerance information
!  REAL (KIND=real_6_38) :: x(4096), y(4096)
!example of the input file in.txt
!2048 ---> n. of points for the function
!7    ---> parameter for the extension of the domain
!-5.0 ---> left extreme of the bounding interval to search for the root
!-4.0 ---> right extreme of the bounding interval to search for the root
!1E-6 ---> tolerance until wich verify
!30   ---> max number of iterations

  IFNAM='in.txt'
  open(11,file=IFNAM)
! READ NUMBER OF POINTS
  READ(11,*) MDIM
! READ DOMAIN PARAMETER DOM
  READ(11,*) DOM
! READ RANGE:
! Get range and tolerance information
!PRINT *, "Give the bounding interval (two values)"
! READ LEFT
  READ(11,*) x_left
! READ RIGHT
  READ(11,*) x_right
!PRINT *, "Give the tolerance"
  READ(11,*) tolerance  
!PRINT *, "Give the maximum number of iterations allowed"
  READ(11,*) maximum_iterations 
  close(11)
  ! Calculate root by the bisection method
  CALL bisect(myfun4,x_left,x_right,tolerance,maximum_iterations,zero,delta,number_of_bisections,err)
  !
  ! Determine type of result
  SELECT CASE (err)
  CASE (0)
    PRINT 110, zero, delta
    PRINT *, "obtained after ", number_of_bisections," bisections"
  CASE (-1)
    PRINT *, "The input is bad"
  CASE (-2)
    PRINT *, "The maximum number of iterations has been exceeded"
    PRINT *, "The x value being considered was ", zero
  END SELECT
  step=DOM*pi/MDIM
  DO i=1,MDIM
    xr(i)=-(DOM/2)*pi+(i-1)*step
    yr(i)=myfun4(xr(i))
!    PRINT 100,xr(i),yr(i)
  END DO   
!  IER=PGBEG(0,'?',1,1)
  IER=PGBEG(0,'/CPS',1,1)
  IF(IER.NE.1) GOTO 9000
  CALL PGENV(-(DOM/2)*pi,(DOM/2)*pi,-1.0*DOM*2.0,DOM*2.0,0,1)
  CALL PGLAB('(x)','(y)','x*sin(x)')
!  CALL PGPT(MDIM,x,y,9)
  CALL PGLINE(MDIM,xr,yr)
  CALL PGEND
  GOTO 9999
100 format(F10.6,1X,F10.6)
110 format('The zero is ', F10.4, ' +- ', F10.4)
9000    PRINT *,'ERROR IN BEGINNING PLOT'
9999    STOP
END PROGRAM roots
!
FUNCTION myfun(x)
  USE constants
  IMPLICIT NONE
  REAL ,INTENT(IN) :: x 
  REAL  :: myfun
  myfun = x*sin(x)
  RETURN
END FUNCTION myfun
!
FUNCTION myfun2(x)
  USE constants
  IMPLICIT NONE
  REAL ,INTENT(IN) :: x 
  REAL  :: myfun2
  myfun2 =  x + EXP(x)
  RETURN
END FUNCTION myfun2

FUNCTION myfun3(x)
  USE constants
  IMPLICIT NONE
  REAL ,INTENT(IN) :: x 
  REAL  :: myfun3
  myfun3 =  x * EXP(x)
  RETURN
END FUNCTION myfun3

FUNCTION myfun4(x)
  USE constants
  IMPLICIT NONE
  REAL,INTENT(IN) :: x 
  REAL  :: myfun4
  myfun4 =  x * cos(x)
  RETURN
END FUNCTION myfun4
!Subroutine bisect
!Real dummy arguments: xl_start, xr_start, tolerance, zero, delta
!Integer dummy arguments: max_iterations, num_bisecs, error
![Note that zero is the root, delta is the uncertainty in the
!root (it will not exceed tolerance), num bisecs is the number
!of interval bisections taken and error is a status indicator]
!1.If xl_start and xr_start do not bracket a root then
!	1.1 Set error = - 1 and return
!2.Set x_left=xl_start, x_right=xr_start
!3.Repeat max iterations times
!	3.1 Calculate mid-point (x_mid) of interval
!	3.2 If (x_mid - x_left) ≤ tolerance then exit with
!	zero = x_mid, delta = x_mid - x_left,
!	and error = 0 to indicate success
!3.3 Otherwise, determine which half interval the root lies in
!	and set x_left and x_right appropriately
!	3.3.1 If f(x_left) × f(x_mid) .LT. 0 then
!      3.3.1.1 set x right to x mid
!      otherwise
!      3.3.1.2 set x left to x mid
!4.No root found so set error = -2 to indicate failure to converge
!  quickly enough
SUBROUTINE bisect(f, xl_start, xr_start, tolerance, max_iterations, zero, delta, num_bisecs, error)
  USE constants
  IMPLICIT NONE
!
! This subroutine attempts to find a root in the interval
! xl_start to xr_start using the bisection method
!
! Dummy arguments
  REAL(KIND=q), INTENT(IN) :: xl_start, xr_start, tolerance
  INTEGER, INTENT(IN) :: max_iterations
  REAL(KIND=q), INTENT(OUT) :: zero, delta
  INTEGER, INTENT(OUT) :: num_bisecs, error
!
! Function used to define equation whose roots are required
  REAL(KIND=q), EXTERNAL :: f
!
! Local variables
  REAL(KIND=q) :: x_left, x_mid, x_right, v_left, v_mid, v_right
  LOGICAL :: DEBUG
  !
  DEBUG=.FALSE.
! Initialize the zero-bounding interval and the function
! values at the end points
  IF (xl_start .LT. xr_start) THEN
    x_left = xl_start
    x_right = xr_start
  ELSE
    x_left = xr_start
    x_right = xl_start
  END IF
!
  v_left = f(x_left)
  v_right = f(x_right)
!
! Validity check
  IF ((v_left * v_right .GE. 0.0) .OR. (tolerance .LE. 0.0) .OR. (max_iterations .LT. 1)) THEN
    error = -1
  END IF
  !
DO num_bisecs = 0, max_iterations
	delta = 0.5 * (x_right-x_left)
	x_mid = x_left + delta
	IF (delta .LT. tolerance) THEN
	IF(DEBUG) PRINT *,'delta= ',delta,' tolerance= ',tolerance,' Convergence criteria satisfied!'
		! Convergence criteria satisfied
		error = 0
		zero = x_mid
	IF(DEBUG) PRINT '("Iteration", I3, 4X, 3F12.6, "(", F12.6, ")")', num_bisecs, x_left, x_mid, x_right, v_mid
		RETURN
	END IF
	!
	v_mid = f(x_mid)
	! ***********************************************************
	! Remove the following print statement when the program
	! has been thoroughly tested
	IF(DEBUG) PRINT '("Iteration", I3, 4X, 3F12.6, "(", F12.6, ")")', num_bisecs, x_left, x_mid, x_right, v_mid
	! ***********************************************************
	IF (v_left * v_mid .LT. 0.0) THEN
		! A root lies in the left half of the interval
		! Contract the bounding interval to the left half
		x_right = x_mid
		v_right = v_mid
	ELSE IF (v_mid * v_right .LT. 0.0) THEN
		! A root lies in the right half of the interval
		! Contract the bounding interval to the right half
		x_left = x_mid
		v_left = v_mid
	ELSE
	  CONTINUE
	END IF
END DO
!
! The maximum number of iterations has been exceeded
error = -2
zero = x_mid
  RETURN
END SUBROUTINE bisect
