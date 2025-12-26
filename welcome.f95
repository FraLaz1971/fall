PROGRAM welcome
	IMPLICIT NONE
	!
	! This program manipulates character strings to produce a
	! properly formatted welcome message
	!
	! Variable declarations
	CHARACTER(LEN=10) :: title
	CHARACTER(LEN=20) :: first_name, last_name
	CHARACTER(LEN=50) :: full_name
	!
	! Ask for name, etc
	PRINT *, "Please give your full name in the form requested"
	PRINT *, "Title (Mr./Mrs./Ms./etc.): "
	READ *, title
	PRINT *, "First name: "
	READ *, first_name
	PRINT *, "Last name: "
	READ *, last_name
	!
	! Create full name
	full_name=TRIM(title)//" "//TRIM(first_name)//" "//last_name
	!
	! Print messages
	PRINT *, "Welcome ", full_name
	PRINT *, "May I call you ",TRIM(first_name),"?"
	!
END PROGRAM welcome
