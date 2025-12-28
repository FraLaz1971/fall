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
PROGRAM vectors
  implicit none
  integer i
  REAL :: x(3),y(3),c(3),b,d,z
  x=(/10.0,-5.25,33.12/)
  y=(/-20.22,-15.75,100.23/)
  c=(/(0.0,i=1,3)/)
  b=3
  print 110,x
  print 120,y
  print 130,b
  call dot(x,y,z)
  print 100,z
  call prod(x,y,c)
  print 140,c
  print 150,b*x
  c=(/1.0,10.0,100.0/)
  print '(''c= '',3(f8.2,1x))',c
  call triple(x,y,c,d)
  print 160,d
100 format('dot(x,y) = ',f8.2)  
110 format('x = ',3(f8.2,1x))
120 format('y = ',3(f8.2,1x))
130 format('b = ',f8.2)
140 format('prod(x,y) = ',3(f8.2,1x))
150 format('b*x = ',3(f8.2,1x))
160 format('triple = ',f10.2)
  stop
END PROGRAM vectors
!
SUBROUTINE dot(x,y,z)
  implicit none
  INTEGER :: i
  REAL,INTENT(IN) :: x(3),y(3)
  REAL,INTENT(OUT) :: z
  z=0
  do i=1,3
    z=x(i)*y(i)+z
  end do
  return
END SUBROUTINE dot
!
!a × b = (a2*b3 − a3*b2 , a3*b1 − a1*b3 , a1*b2 − a2*b1 )
SUBROUTINE prod(x,y,c)
  implicit none
  REAL,INTENT(IN) :: x(3),y(3)
  REAL,INTENT(OUT) :: c(3)
    c(1)=x(2)*y(3) - x(3)*y(2)
    c(2)=x(3)*y(1) - x(1)*y(3)
    c(3)=x(1)*y(2) - x(2)*y(1)
  return
END SUBROUTINE prod
!
![abc] = a · (b × c)
SUBROUTINE triple(x,y,c,d)
  implicit none
  REAL,INTENT(IN) :: x(3),y(3),c(3)
  REAL,INTENT(OUT) :: d
  REAL :: t1(3)
  call prod(y,c,t1)
  call dot(x,t1,d)
  return
END SUBROUTINE triple
