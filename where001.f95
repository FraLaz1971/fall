program where_example
  implicit none
  real :: a(5), b(5)
  a = [-2.0, -1.0, 0.0, 3.0, 2.0]
  where (a .NE. 0.0)
    b = 1.0 / a
  elsewhere
    b = 0.0
  end where
  print *, 'a = ', a
  print *, 'b = ', b
end program where_example
