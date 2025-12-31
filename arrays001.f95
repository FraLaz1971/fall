PROGRAM ARRAYS
    TYPE point
      REAL :: x,y,z
    END TYPE point
	REAL, DIMENSION(8) :: a
	INTEGER, DIMENSION(3, 10, 2) :: b
	TYPE(point), DIMENSION(4, 2, 100, 8) :: c
	REAL, DIMENSION(11:18) :: a1
	INTEGER, DIMENSION(5:7, -10:-1, 2) :: b1
	TYPE(point), DIMENSION(5:8, 0:1, 100, -3:4) :: c1
!	PRINT *,a
!	PRINT *,b
	PRINT *,c
!	PRINT *,a1
!	PRINT *,b1
!	PRINT *,c1
END
