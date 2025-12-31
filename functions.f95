!program which calculates the roots of the quadratic equation a*x**2 + b*x + c = 0.
!Distinguish between the three cases for which the discriminant (b**2 - 4*a*c) is positive,
!negative, or equal to zero. x = (−b ± √ (b2 − 4*a*c) )/2*a
!Use an if construct. You will also need to use the intrinsic
!function cmplx.
PROGRAM funcs
  IMPLICIT NONE
  REAL :: a,b,c,delta,x1,x2,eps
  COMPLEX :: xc1,xc2
  PARAMETER(eps=1E-7)
  PRINT *,'#Calculate the roots of a quadratic equation ax+by+c=0'
  PRINT *,'#Enter a,b,c separated by commas'
  READ (*,*,ERR=9000,END=9100) a,b,c
! calculate delta
  delta=b**2-4*a*c
  print 100,a,b,c
  IF (delta.GT.eps) THEN
    x1=(-1*b+sqrt(delta))/(2*a)
    x2=(-1*b-sqrt(delta))/(2*a)
    print *,'#has solutions'
    print '(''#x1 = '',F8.2)',x1
    print '(''#x2 = '',F8.2)',x2
  ELSE IF (delta.GT.(-1*eps)) THEN
    x1=-1*b/(2*a)
    x2=x1
    print '(A,F8.2)','#has solutions x1=x2=',x1
  ELSE
    print *,'#has not real solutions'
    xc1 = cmplx((-1*b)/(2*a),+sqrt(-1*delta)/(2*a))
    xc2 = cmplx((-1*b)/(2*a),-sqrt(-1*delta)/(2*a))
    x1=real(xc1)
    x2=real(xc2)
    print *,'#It has complex solution'
    print 110,real(xc1),aimag(xc1),real(xc2),aimag(xc1)
  END IF
    CALL PARAB(a,b,c,x1,x2)
    GOTO 9999
100  FORMAT('#the equation ',F8.2,'*x^2 +',F8.2,'*x +',F8.2,' = 0')
110  FORMAT('#x1.Re = ',F8.2,' x1.Im = ',F8.2,'  x2.Re = ',F8.2,' x2.Im = ',F8.2)
9000 PRINT *,'ERROR IN READING INPUT DATA'
    GOTO 9999
9100 PRINT *,'NO MORE DATA TO READ'
9999 STOP
END PROGRAM funcs
!
SUBROUTINE PLOT(a,b,c,x1,x2)
  INTEGER :: MDIM,i,posi
  CHARACTER*128 title
  CHARACTER*80 OFNAM
  CHARACTER*100 driver
  PARAMETER(MDIM=2048)
  INTEGER :: IER,PGBEG
  REAL :: a,b,c,x1,x2,x(MDIM),y(MDIM),xmin,xmax,step,m
  PARAMETER(m=1.0)
  REAL :: XS(2),YS(2),ymin,ymax
! create title
  WRITE(title,110,ERR=9100) a,b,c
! create plot filename
  WRITE(OFNAM,120,ERR=9200) a,b,c
  posi=index(OFNAM,'.ps')
  DO i=1,posi-1
    if ((OFNAM(i:i).EQ.'.').OR.(OFNAM(i:i).EQ.' ')) OFNAM(i:i)='_'
  END DO
! create driver string
  WRITE(driver,130,ERR=9300) OFNAM
! roots points
  XS(1)=x1
  XS(2)=x2
  YS(1)=a*x1**2 + b*x1 + c
  YS(2)=a*x2**2 + b*x2 + c
! set the x range for the plot
  IF (x1.LE.x2) THEN
    xmin=x1-m
    xmax=x2+m
  ELSE
    xmin=x2-m
    xmax=x1+m
  END IF
	step=(xmax-xmin)/2048.0
	ymin=1E30
	ymax=1E-30
! find the y range
  DO i=1,2048
    x(i)=xmin+(i-1)*step
    y(i)=a*x(i)**2 + b*x(i) + c
    if (y(i).LT.ymin) ymin=y(i)
    if (y(i).GT.ymax) ymax=y(i)
!    PRINT 100,x(i),y(i)
  END DO
  ymin=ymin-m
  ymax=ymax+m
  IER=PGBEG(0,driver,1,1)
  IF(IER.NE.1) GOTO 9000
! SUBROUTINE PGENV (XMIN, XMAX, YMIN, YMAX, JUST, AXIS)
! REAL XMIN, XMAX, YMIN, YMAX
! INTEGER JUST, AXIS
! Define coordinate range of graph (xmin<x<xmax,ymin<y<ymax)
! X A and Y scaled independently (JUST=0) and draw axes (AXIS=1),
  CALL PGENV(xmin,xmax,ymin,ymax,0,1)
  CALL PGLAB('(x)','(y)',title)
! plot the points of the roots
  CALL PGPT(2,XS,YS,9)
! plot the curve
  CALL PGLINE(2048,x,y)
  CALL PGEND
  GOTO 9999
100  FORMAT(F9.4,1X,F9.4)
110  FORMAT('y=',F8.2,'*x^2 + ',F8.2,'*x + ',F8.2)
120  FORMAT(BZ,'parab_',F8.2,'_',F8.2,'_',F8.2,'.ps')
130  FORMAT(A,'/PS')
9000    PRINT *,'ERROR IN BEGINNING PLOT'
  GOTO 9999
9100    PRINT *,'ERROR IN CREATING TITLE'
  GOTO 9999
9200    PRINT *,'ERROR IN CREATING OUTPUT FILE NAME'
  GOTO 9999
9300    PRINT *,'ERROR IN CREATING DRIVER STRING'
9999    STOP
END SUBROUTINE PARAB
!
FUNCTION f1(x)
  REAL :: f1
  REAL,INTENT(IN) :: x
  f1 = x*sin(x)  
END FUNCTION
