program demo_cube_root
  real :: x
  print *,'enter a positive real number'
  read *,x
  print 100,x,cube_root(x)
100 format('the cube root of ',F8.2,' is',F8.2)
end program demo_cube_root

real function cube_root(x)
  real,intent(in) :: x
  cube_root=x**(1.0/3.0)
  return
end function cube_root
