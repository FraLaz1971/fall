program show_select
    integer :: number
5   print *,'enter an integer number [-inf,+inf]'
    print *,'type E to exit'
    read(*,*,ERR=9999) number
	select case (number)
	case ( : -1)
		print*, 'number is negative'
	case (0)
		print*, 'number is zero'
	case (1 : )
		print*, 'number is positive'
	end select
	goto 5
9999 stop
end program show_select
