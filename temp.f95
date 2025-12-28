program temp
  integer i
  real :: arr1,arr2
  dimension arr1(4),arr2(4)
  arr1 = (/20.11,-77.4,1023.0,-12.78/)
  arr2 = (/(2.0,i=1,4)/)
  print 100,arr1*arr2
  print *,'HUGE(1)=',HUGE(1)
100 format(4(f7.2,1x))
end program temp
