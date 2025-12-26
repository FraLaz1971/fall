!This program takes in input
!the coefficients a,b,c
!of a second degree equation
!and gives back the roots
!The program will use the formula
!x = (−b ± √ b2 − 4ac) /2a
!where
!ax2 + bx + c = 0
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
  if (mdelta.ge.eps) then
    x1=(-1*b+sqrt(mdelta))/(2*a)
    x2=(-1*b-sqrt(mdelta))/(2*a)
  else if (mdelta.gt.(-1*eps)) then
    x1=-1*b/(2*a)
    x2=-1*b/(2*a)
  else if (mdelta.le.(-1*eps)) then
    print *,'there are not real roots'
  end if
  print 100,x1,x2
100 format('the roots are x1=',F10.2,' x2=',F10.2)
end program quadroots

real function delta(a,b,c)
  real,intent(in) :: a,b,c
  delta=b**2-4*a*c
end function delta
