program explic
	IMPLICIT NONE
	REAL, DIMENSION(15, 50) :: p
	REAL, DIMENSION(15, 15, 2) :: q
	CALL explicit(p, q, 15, 7)
!	print *, p
	print *, q
	
end program explic

SUBROUTINE explicit(a, b, m, n)
	IMPLICIT NONE
	INTEGER, INTENT(IN) :: m, n
	REAL, DIMENSION(m, n*n+1), INTENT(INOUT) :: a
	REAL, DIMENSION(-n:n, m, INT(m/n)), INTENT(OUT) :: b
	return
END SUBROUTINE explicit
