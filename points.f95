module geometry_mod
    implicit none
    ! Define the composed data structure
    type :: Point
        real :: x
        real :: y
    end type Point
contains
    ! Subroutine that takes the custom type as an argument
    subroutine update_point(p, new_x, new_y)
        type(Point), intent(inout) :: p  ! The structure as a dummy argument
        real, intent(in) :: new_x, new_y
        p%x = new_x  ! Access members using %
        p%y = new_y
    end subroutine update_point
end module geometry_mod

program main
    use geometry_mod
    implicit none
    type(Point) :: my_point
    ! Initialize the structure
    my_point = Point(0.0, 0.0)
    print *, "Before:", my_point%x, my_point%y
    ! Pass the structure to the subroutine
    call update_point(my_point, 10.5, 20.2)
    print *, "After: ", my_point%x, my_point%y
end program main
