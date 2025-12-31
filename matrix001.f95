PROGRAM matrix001
    IMPLICIT NONE
    INTEGER :: i,j
    CHARACTER*30 ROW
	REAL :: m1(2,3)
	DATA m1/1.0,2.0,3.0,4.0,5.0,6.0/
    do j=1,2
	    do i=1,3
		  WRITE(ROW((i-1)*10+1:i*10),'(F10.2)') m1(j,i)
		end do
	    PRINT *,ROW
	    ROW = ' '
	end do
	PRINT '(3F10.2)', m1
	PRINT '(2F10.2)', m1
    PRINT '(3F8.2)', ((m1(i,j), j=1,3), i=1,2)
    WRITE(*,*) SHAPE(m1)                       ! prints "2 3"
    m1=RESHAPE((/ 6.0, 5.0, 4.0, 3.0, 2.0, 1.0 /), (/2, 3/))
    do j=1,2
	    do i=1,3
		  WRITE(ROW((i-1)*10+1:i*10),'(F10.2)') m1(j,i)
		end do
	    PRINT *,ROW
	    ROW = ' '
	end do
END PROGRAM matrix001
