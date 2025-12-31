program auto_alloc
  implicit none
  real, allocatable :: x(:)
  x = [1.0, 2.0, 3.0, 4.0]   ! x is allocated automatically
  print *, size(x)
end program auto_alloc
