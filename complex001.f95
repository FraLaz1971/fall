PROGRAM complex_arithmetics
! z=x+iy
!z1 = x1 + iy1 ,
!z2 = x2 + iy2 ,
!z1 + z2 = x1 + x2 + i (y1 + y2 )
!z1 × z2 = x1 × x2 − y1 × y2 + i (x1 × y2 + x2 × y1 )
  TYPE mcomplex
  REAL x,y
  END TYPE mcomplex
  TYPE(mcomplex) :: z1,z2
  PRINT *,'ENTER 2 COMPLEX NUMBERS (Re,Im)'
  PRINT *,'COMPLEX NUMBER N.1?'
  READ *,z1%x,z1%y
  PRINT *,'COMPLEX NUMBER N.2?'
  READ *,z2%x,z2%y
  PRINT 100,z1%x+z2%x,z1%y+z2%y
  PRINT 110,z1%x*z2%x-z1%y*z2%y,z1%x*z2%y+z2%x*z1%y
100 FORMAT('z1+z2=',F10.4,'+i*',F10.4)
110 FORMAT('z1*z2=',F10.4,'+i*',F10.4)
END PROGRAM complex_arithmetics
