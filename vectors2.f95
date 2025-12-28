!Write a program to calculate: 
!(1) the dot product of two three-dimensional vectors; 
!(2) the vector product of two three-dimensional vectors; 
!(3) the scalar triple product of three three-dimensional vectors.
!Analysis
!Consider the two three-dimensional vectors
!a = (a1 , a2, a3 ),b = (b1 , b2, b3 ).
!The dot product of the two vectors a and b is the scalar a · b defined by:
!a · b = a1*b1 + a2*b2 + a3*b3
!The vector product of the two vectors a and b is the vector c = a × b defined by:
!c = (a2*b3 − a3*b2 , a3*b1 − a1*b3 , a1*b2 − a2*b1 )
!The scalar triple product of the three vectors a, b and c is the scalar [abc] defined by:
![abc] = a · (b × c)
!
MODULE products
IMPLICIT NONE
SAVE
!
CONTAINS
!
!
FUNCTION dot(x,y)
  implicit none
  INTEGER :: i
  REAL,INTENT(IN) :: x(3),y(3)
  REAL :: dot
  dot=0
  do i=1,3
    dot=x(i)*y(i)+dot
  end do
  return
END FUNCTION dot
!
!a × b = (a2*b3 − a3*b2 , a3*b1 − a1*b3 , a1*b2 − a2*b1 )
FUNCTION prod(x,y)
  implicit none
  REAL,INTENT(IN) :: x(3),y(3)
  REAL,DIMENSION(3) :: prod
    prod(1)=x(2)*y(3) - x(3)*y(2)
    prod(2)=x(3)*y(1) - x(1)*y(3)
    prod(3)=x(1)*y(2) - x(2)*y(1)
  return
END FUNCTION prod
!
![abc] = a · (b × c)
FUNCTION triple(x,y,c)
  implicit none
  REAL,INTENT(IN) :: x(3),y(3),c(3)
  REAL :: triple
  REAL,DIMENSION(3) :: t1
  t1 = prod(y,c)
  triple = dot(x,t1)
  return
END FUNCTION triple
!
END MODULE products
!
PROGRAM vec2
  use products
  implicit none
  integer i
  REAL, DIMENSION(3) :: a, b, c, vp
  REAL :: dp, stp,b1,d,z
  INTEGER :: selector
  REAL :: x(3),y(3)
  x=(/10.0,-5.25,33.12/)
  y=(/-20.22,-15.75,100.23/)
  c=(/(0.0,i=1,3)/)
  b1=3.0
  print 110,x
  print 120,y
  print 130,b1
  z = dot(x,y)
  print 100,z
  c = prod(x,y)
  print 140,c
  print 150,b1*x
  c=(/1.0,10.0,100.0/)
  print '(''c= '',3(f8.2,1x))',c
  d = triple(x,y,c)
  print 160,d
  PRINT*, 'selector = ? (1(dp), 2(vp), 3(stp))'
	READ*, selector
	!
	SELECT CASE (selector)
	CASE (1)
		PRINT*, 'a = ?'
		READ*, a(1), a(2), a(3)
		PRINT*, 'b = ?'
		READ*, b(1), b(2), b(3)
		dp = dot(a, b)
		PRINT*, 'a . b = ', dp
	CASE (2)
		PRINT*, 'a = ?'
		READ*,a(1), a(2), a(3)
		PRINT*, 'b = ?'
		READ*,b(1), b(2), b(3)
		vp = prod(a, b)
		PRINT*, 'a x b = ', vp
	CASE (3)
		PRINT*, 'a = ?'
		READ*,a(1), a(2), a(3)
		PRINT*, 'b = ?'
		READ*,b(1), b(2), b(3)
		PRINT*, 'c = ?'
		READ*,c(1), c(2), c(3)
		stp = triple(a,b,c)
		PRINT*, 'a . b x c = ', stp
	END SELECT
!
100 format('x.y = ',f8.2)  
110 format('x = ',3(f8.2,1x))
120 format('y = ',3(f8.2,1x))
130 format('b1 = ',f8.2)
140 format('X x Y = ',3(f8.2,1x))
150 format('b1*x = ',3(f8.2,1x))
160 format('x.(y x c) = ',f10.2)
  stop
END PROGRAM vec2
