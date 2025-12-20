PROGRAM MAIN
    IMPLICIT NONE
    ! 1. Declare external functions to be passed
    REAL, EXTERNAL :: MY_SQUARE, MY_CUBE
    REAL :: RESULT

    ! 2. Pass 'MY_SQUARE' as an argument
    ! The result will be saved in the variable RESULT
    CALL SOLVER(MY_SQUARE, 5.0, RESULT)
    PRINT *, "Square of 5.0 is:", RESULT

    ! 3. Pass 'MY_CUBE' as an argument
    ! The result will be saved in the variable RESULT
    CALL SOLVER(MY_CUBE, 5.0, RESULT)
    PRINT *, "Cube of 5.0 is:", RESULT
END PROGRAM MAIN

! This routine accepts a procedure 'F' as a dummy argument
SUBROUTINE SOLVER(F, X, RES)
    IMPLICIT NONE
    REAL, EXTERNAL :: F  ! Declare F as an external function
    REAL, INTENT(IN) :: X
    REAL, INTENT(OUT) :: RES

    ! Execute the passed function
    RES = F(X)
END SUBROUTINE SOLVER

! --- Actual external functions ---
REAL FUNCTION MY_SQUARE(X)
    REAL, INTENT(IN) :: X
    MY_SQUARE = X * X
END FUNCTION

REAL FUNCTION MY_CUBE(X)
    REAL, INTENT(IN) :: X
    MY_CUBE = X * X * X
END FUNCTION

