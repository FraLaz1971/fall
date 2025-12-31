program alloc_basic
  implicit none
  real, allocatable :: x(:)
  integer :: n,i
  n = 100
  allocate(x(n))
  x = 0.0
  x = [(real(i), i=1,n)]
  print *, 'x(1)=', x(1), ' x(n)=', x(n)
  deallocate(x)
end program alloc_basic
!ALLOCATABLE declares a variable with deferred size
!ALLOCATE assigns memory at runtime
!DEALLOCATE explicitly releases it
!After DEALLOCATE, the variable becomes unallocated
