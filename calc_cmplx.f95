!Write two functions for use in a complex arithmetic package using the complex number
!derived type which was created in Example 3.4. The functions should each take two
!complex arguments and return as their result the result of adding and multiplying the
!two numbers.
! z=x+iy
!z1 = x1 + iy1 ,
!z2 = x2 + iy2 ,
!z1 + z2 = x1 + x2 + i (y1 + y2 )
!z1 × z2 = x1 × x2 − y1 × y2 + i (x1 × y2 + x2 × y1 )

program calc_complex
  use complex_data
  implicit none
  TYPE(mcomplex) :: z1,z2,c_add,c_mul,c_sum,c_prod 
  PRINT *,'ENTER 2 COMPLEX NUMBERS (Re,Im)'
  PRINT *,'COMPLEX NUMBER N.1?'
  READ *,z1%x,z1%y
  PRINT *,'COMPLEX NUMBER N.2?'
  READ *,z2%x,z2%y
  c_sum=c_add(z1,z2)
  c_prod=c_mul(z1,z2)
  PRINT 100,c_sum%x,c_sum%y
  PRINT 110,c_prod%x,c_prod%y
100 FORMAT('z1+z2=',F10.4,'+i*',F10.4)
110 FORMAT('z1*z2=',F10.4,'+i*',F10.4)
end program calc_complex

module complex_data
  implicit none
  save
  TYPE mcomplex
  REAL :: x,y
  END TYPE mcomplex
end module complex_data

function c_add(z1,z2)
!z1 + z2 = x1 + x2 + i (y1 + y2 )
  use complex_data
  implicit none
  TYPE(mcomplex),intent(in) :: z1,z2
  TYPE(mcomplex) :: c_add
  c_add%x=z1%x+z2%y
  c_add%y=z1%y+z2%y
end function c_add

function c_mul(z1,z2)
!z1 × z2 = x1 × x2 − y1 × y2 + i (x1 × y2 + x2 × y1 )
  use complex_data
  implicit none
  TYPE(mcomplex),intent(in) :: z1,z2
  TYPE(mcomplex) :: c_mul
  c_mul%x=z1%x*z2%y-z1%y*z2%y
  c_mul%y=z1%x*z2%y+z2%x+z1%y
end function c_mul
