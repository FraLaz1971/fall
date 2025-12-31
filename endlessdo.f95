program integer_sum
! this program sums a series of numbers given by the user
! example of the use of the endless do construct
	implicit none
	integer :: number, msum
	msum = 0
5	do
		print*, 'give an integer number (type -1 to exit): '
		read (*,*,ERR=9000) number
		if (number == -1) exit
		msum = msum + number
	end do
	print*, 'The sum of the integers is ', msum
	goto 9999
9000 PRINT *,'Error in reading the number'
     goto 5
9999 STOP
end program integer_sum
