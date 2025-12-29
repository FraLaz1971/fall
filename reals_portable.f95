PROGRAM reals
  IMPLICIT NONE
  REAL :: a, b, c, d ! default-real
  REAL, DIMENSION(10) :: x, y
  REAL :: p(20), q(40), r(60) !!default-real
!  REAL(KIND=4) :: e, f
!  REAL(KIND=1) :: g, h
!  REAL(KIND=4), DIMENSION(10) :: u, v
!  REAL(KIND=2) :: s(8), t(5)
!  REAL(KIND=3) :: z
!  REAL :: y
  REAL(KIND=SELECTED_REAL_KIND(P=8, R=30)) :: m
  REAL(KIND=SELECTED_REAL_KIND(P=6, R=30)) :: n
  INTEGER :: i, j, k
  i = KIND(a) ! i = ?
  j = KIND(b) ! j = value for the kind type of  a default real number
  k = KIND(c)
  PRINT *,'KIND(a) = ',i
  PRINT *,'KIND(b) = ',j
  PRINT *,'KIND(c) = ',k
  PRINT *,'m = ',m,' KIND(m) = ',KIND(m)
  PRINT *,'n = ',n,' KIND(n) = ',KIND(n)
  STOP
END PROGRAM reals
