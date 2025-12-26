!Write a program which will demonstrate the use of the subroutine roots to calculate the
!square root, the cube root and the fourth root of a positive real number.
program demo_roots
  real :: x,msqrt,mcurt,mfrt
  print *,'enter a positive real number'
  read *,x
  call roots(x,msqrt,mcurt,mfrt)
  print 100,x,msqrt
  print 110,x,mcurt
  print 120,x,mfrt
100 format('the square root of ',F8.2,' is ',F8.2)
110 format('the cube root of ',F8.2,' is ',F8.2)
120 format('the fourth root of ',F8.2,' is ',F8.2)
end program demo_roots

subroutine roots(x,msqrt,mcurt,mfrt)
  real,intent(in) :: x
  real,intent(out) :: msqrt,mcurt,mfrt
  msqrt=x**0.5
  mcurt=x**(1.0/3.0)
  mfrt=x**0.25
  return
end subroutine roots
