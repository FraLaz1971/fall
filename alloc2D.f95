program alloc_2d
  implicit none
  real, allocatable :: a(:,:)
  integer :: nx, ny
  nx = 200
  ny = 300
  allocate(a(nx, ny))
  a = 1.0
  print *, 'Total elements of a = ', size(a)
  deallocate(a)
  if (.not. allocated(a)) then
    allocate(a(10,10))
  end if
  print *, 'Now total elements of a = ', size(a)
end program alloc_2d
