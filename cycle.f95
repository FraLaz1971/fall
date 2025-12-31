program cycle_example
	implicit none
	character (len=1) :: answer
	integer :: i
	do i = 1, 10
		print*, 'print i (y or n)?'
		read*, answer
		if (answer .EQ. 'n') cycle
		print*, i
	end do
end program cycle_example
