PROGRAM vectors_and_matrices
	IMPLICIT NONE
	INTEGER, DIMENSION(2, 3) :: matrix_a = &
	RESHAPE( (/ 1, 2, 2, 3, 3, 4 /), (/ 2, 3 /) )
	INTEGER, DIMENSION(3, 2) :: matrix_b
	INTEGER, DIMENSION(2, 2) :: matrix_ab
	INTEGER, DIMENSION(2) :: vector_c = (/ 1, 2 /)
	INTEGER, DIMENSION(3) :: vector_bc
	! matrix_a is the matrix
	! [ 1 2 3 ] 
	! [ 2 3 4 ]
	print *,'printing matrix_a (vector style)'
	print *,matrix_a
	print *,'printing matrix_a (matrix style)'
	call show(matrix_a,2,3)
	!
	! Set matrix_b as the transpose of matrix_a
	matrix_b = TRANSPOSE(matrix_a)
	! matrix_b is now the matrix
	! [ 1 2 ]
	! [ 2 3 ]
	! [ 3 4 ]
	print *,'printing matrix_b (vector style)'
	print *,matrix_b
	print *,'printing matrix_b (matrix style)'
	call show(matrix_b,3,2)
	! Calculate matrix products
	matrix_ab = MATMUL(matrix_a, matrix_b)
	! matrix_ab is now the matrix 
	![ 14 20 ]
	![ 20 29 ]
	print *,'printing matrix_ab (vector style)'
	print *,matrix_ab
	print *,'printing matrix_ab (matrix style)'
	call show(matrix_ab,2,2)
	! matrix_b is the matrix
	! [ 1 2 ]
	! [ 2 3 ]
	! [ 3 4 ]
	! vector c is
	! [ 1 2 ]
	vector_bc = MATMUL(matrix_b, vector_c)
	! vector_bc= [ 1+4 2+6 3+8 ]
	! vector_bc is now the vector [ 5 8 11 ]
	!
	print *,'printing vector_bc (row)'
	print *,vector_bc
	print *,'printing vector_bc (column)'
	call show(vector_bc,3,1)
END PROGRAM vectors_and_matrices

SUBROUTINE show(m,y,x)
    IMPLICIT NONE
	INTEGER,INTENT(IN) :: y,x
	INTEGER,INTENT(IN) :: m(y,x)
	INTEGER :: i,j
    CHARACTER*(x*11) :: row
	do i=1,y
	  do j=1,x
	    write(row((j-1)*11+1:j*11),'(I10,1X)') m(i,j)
	  end do
	  print *,row
	  row=' '
	end do
END SUBROUTINE
