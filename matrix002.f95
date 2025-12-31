PROGRAM matr2
  IMPLICIT NONE
  REAL :: m2(2,3)
  INTEGER i,j,lb(2),ub(2),s
  CHARACTER(LEN = 10), DIMENSION(8, 4, 9) :: string
  DATA string /288*'NULL'/
  INTEGER, DIMENSION(5) :: vec = (/ 7, 1, 3, 1, 4 /)
  LOGICAL, DIMENSION(3) :: p
  DATA P/.true.,.false.,.true./
  INTEGER, DIMENSION(5) :: u = (/ 3, 2, 2, 3, 1 /)
  CHARACTER*33 ROW
  DATA m2/1.0,4.0,2.0,5.0,3.0,6.0/
  DO i=1,2
    DO J=1,3
      WRITE(ROW((j-1)*11+1:j*11),'(F10.2,1X)',ERR=9000) m2(i,j)
    END DO
    PRINT *,ROW
  END DO
  s=SIZE(m2)
  PRINT *,'size of m2 is ',s
  lb=LBOUND(m2)
  PRINT *,'subscript lower bound of m2(i,j) is ',lb
  ub=UBOUND(m2)
  PRINT *,'subscript upper bound of m2(i,j) is ',ub
  PRINT *,'dimension of m2 y axis is ',DIM(ub(1),lb(1))
  PRINT *,'dimension of m2 x axes is ',DIM(ub(2),lb(2))
  PRINT '(A,3(F10.2,1X))','first row of m2 is  ',m2(1,:)
  PRINT '(A,3(F10.2,1X))','second row of m2 is ',m2(2,:)
  PRINT '(A,2(F10.2,1X))','first  column of m2 is ',m2(:,1)
  PRINT '(A,2(F10.2,1X))','second column of m2 is ',m2(:,2)
  PRINT '(A,2(F10.2,1X))','third  column of m2 is ',m2(:,3)
  PRINT *,'m2(1:2,1:2)'
  PRINT '(2(F10.2,1X)/2(F10.2,1X))',m2(1:2,1:2)
  PRINT *,p
  PRINT *,p(u)
  PRINT *,string(vec, 3, 5:9:4)
  PRINT *,string(7, 3, 5), string(7, 3, 9), string(7, 3, 4)
  PRINT *,string(1, 3, 5), string(1, 3, 9), string(1, 3, 4)
  PRINT *,string(3, 3, 5), string(3, 3, 9), string(3, 3, 4)
  PRINT *,string(1, 3, 5), string(1, 3, 9), string(1, 3, 4)
  PRINT *,string(4, 3, 5), string(4, 3, 9), string(4, 3, 4)
  GOTO 9999
9000 PRINT *,'ERROR IN WRITING INTERNAL FILE ',ROW
9999 STOP
END
