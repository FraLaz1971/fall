program angv1v2
	implicit none
    character*80 IFNAM
	real, parameter :: pi = 3.141593
	real, dimension (3) :: v1, v2
	real :: ang
	! define two vectors v1 and v2
!	v1(1) = 1.0
!	v1(2) = 0.0
!	v1(3) = 2.0
!	v2(1) = 1.5
!	v2(2) = 3.7
!	v2(3) = 2.0
    IFNAM='vectors.csv'
    call readve(IFNAM,v1,v2)
	print*, 'angle = ',ang(v1, v2),' rad'
	print*, 'angle = ',(ang(v1, v2)*180)/pi,' deg'
end program angv1v2
! rad/deg=pi/180 ---> deg=(rad*180)/pi -->(6.28*180)/3.14 = 2*180=360
! ang computes the angle between 2 vectors vect1 and vect2
! v1.v2 = |v1|*|v2|*cos(ang) --->
! cos(ang) = v1.v2/(|v1|*|v2|) 
function ang (vect1, vect2 )
	implicit none
	! function result
	real :: ang
	! dummy arguments
	real, dimension (3), intent (in) :: vect1, vect2
	! local variables
	real :: cosang, norm
	cosang = vect1(1)*vect2(1) + vect1(2)*vect2(2) + vect1(3)*vect2(3)
	cosang = cosang / (norm(vect1)*norm(vect2))
	ang = acos (cosang)
end function ang
! norm returns the norm of the vector v
function norm (v)
	implicit none
	real :: norm
	! dummy arguments
	real, dimension (3) :: v
	norm = sqrt ( v(1)**2 + v(2)**2 + v(3)**2)
end function norm
! readve: read vectors
subroutine readve(IFNAM,v1,v2)
	implicit none
	integer :: i
    character*80 IFNAM
	real, dimension (3), intent (inout) :: v1, v2
	open(11,file=IFNAM)
	do i=1,3
	  read(11,'(F4.1,1X,F4.1)') v1(i),v2(i)
	end do
	close(11)
end subroutine readve
