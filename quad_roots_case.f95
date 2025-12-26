!This program takes in input
!the coefficients a,b,c
!of a second degree equation
!and gives back the roots
!The program will use the formula
!x = (−b ± √ b2 − 4ac) /2a
!where
!ax^2 + bx + c = 0
!2*x**2-5*x+2 -->delta=(-5)**2-4*2*2=25-16=9-->
!x1=5+sqrt(9))/4=(5+3)/4=2
!x2=5-sqrt(9))/4=(5-3)/4=0.5
! and
! a .NE. 0.
!There are three possible cases:
!(1) b2 − 4ac ≥ ε Equation has two real roots
!(2) |b2 − 4ac| < ε Equation has one real root
!(3) b2 − 4ac ≤ −ε Equation has no real roots
!ε is a very small positive number
program quadroots
  implicit none
  real :: a,b,c,mdelta,delta,eps,x1,x2
  parameter(eps=1E-7)
  print *,'this program solves a quadratic equation'
  print *,'enter the coefficients a,b,c'
  read *,a,b,c
  mdelta=delta(a,b,c)
  SELECT CASE (int(mdelta/eps))
  CASE (1:)
    x1=(-1*b+sqrt(mdelta))/(2*a)
    x2=(-1*b-sqrt(mdelta))/(2*a)
  CASE (0)
    x1=-1*b/(2*a)
    x2=-1*b/(2*a)
  CASE DEFAULT
    print *,'there are not real roots'
    goto 9999
  END SELECT
  print 100,x1,x2
100 format('the roots are x1=',F10.2,' x2=',F10.2)
9999 stop
end program quadroots

real function delta(a,b,c)
  real,intent(in) :: a,b,c
  delta=b**2-4*a*c
end function delta
