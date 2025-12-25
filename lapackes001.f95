program solve_system
    implicit none (type, external)
    external :: sgesv
    real :: a(2,2), b(2), pivot(2)
    integer :: n = 2, nrhs = 1, info

    ! Define matrix A (2.0 1.0; 3.0 1.0) and vector b [5.0, 6.0]
    a = reshape([2.0, 3.0, 1.0, 1.0], [2, 2])
    b = [5.0, 6.0]

    ! Solve AX = B
    call sgesv(n, nrhs, a, n, pivot, b, n, info)

    if (info == 0) then
        print 100, b
    else
        print *, 'Error code: ', info
    end if
100 format('Solution x1, x2: ', 2(F6.1,1X))
end program solve_system
