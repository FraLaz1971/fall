!Write a program which will read a file containing book references, will select those that
!contain a character string specified by the user and will print the selected references to
!another file.
!the file has the structure
!Title,Author,Year,ISBN-13
!each field is separated by commas
!Structure plan:
!1.Read unit numbers in unit and out unit
!2.Read file names in file and out file
!3.Read string
!4.Use intrinsic function LEN TRIM to obtain the length
!  of string, without counting any trailing blank characters.
!5.Call subroutine read write to perform the required selection.
!The subroutine read write will depend on the form of the file in file that contains the book
!references. In the example shown it is supposed that each book reference is composed by
!a variable number of 80 character lines, the last line terminated by the character string
!”//”. Book references are separated by a blank line. Only the first line of each book
!reference is searched for the string "string".
PROGRAM books
!--------------------
! FJR / 2.NOV.1994 / 22.OUT.2003
!--------------------
	IMPLICIT NONE
	CHARACTER (LEN=32) :: in_file, out_file
	CHARACTER (LEN=10) :: string
	INTEGER :: in_unit, out_unit, len_string
	!--------------------
	PRINT *, "input unit, output unit = ?"
	READ *, in_unit, out_unit
	!--------------------
	PRINT *, "input file, output file = ?"
	READ *, in_file, out_file
	!--------------------
	OPEN (UNIT=in_unit, FILE=in_file , STATUS="OLD",ERR=9000)
	OPEN (UNIT=out_unit, FILE=out_file, STATUS="NEW",ERR=9100)
	!--------------------
	PRINT *, "string = ? (1 <= LEN(string) <= 10"
	READ *, string
	!--------------------
	len_string=LEN_TRIM(string)
	CALL read_write(string, len_string, in_unit, out_unit)
	!--------------------
    GOTO 9999
9000 PRINT *,'ERROR OPENING FILE ',in_file,' FOR READING'
     PRINT *,'DOES THE FILE EXIST?'
    GOTO 9999
9100 PRINT *,'ERROR OPENING FILE ',out_file,' FOR WRITING'
     PRINT *,'DOES THE FILE EXIST YET? REMOVE IT'
9999 STOP
	END PROGRAM books
	
	SUBROUTINE read_write(string, mlen, mmin, mout)
	IMPLICIT NONE
	INTEGER :: mmin, mout, mlen, ix, iy
	CHARACTER (LEN=80) :: c1, c2
	CHARACTER (LEN=mlen) :: string
	CHARACTER (LEN=2), PARAMETER :: cs="//"
	!-------------------------
	DO
		READ (UNIT=mmin, FMT=100, ERR=9000, END=9100) c1
		IF (c1(1:7) == "ENDFILE") RETURN
		ix=INDEX(c1,string)
		IF (ix .GT. 0) THEN
			WRITE (UNIT=mout, FMT=100,ERR=9200) TRIM(c1)
		ELSE
		    CYCLE
		END IF
		!--------------------
		DO
			READ (UNIT=mmin, FMT=100,ERR=9000, END=9100) c2
			WRITE (UNIT=mout, FMT=100,ERR=9200) TRIM(c2)
			iy = INDEX(c2,cs)
			!---------------
			IF (iy .GT. 0) THEN
				READ (UNIT=mmin, FMT=100,ERR=9000, END=9100) c2
				WRITE (UNIT=mout, FMT=100,ERR=9200) TRIM(c2)
				EXIT
			END IF
			!---------------
		END DO
	!--------------------
	END DO
!-------------------------
    GOTO 9999
100 FORMAT(A)
    GOTO 9999
9000 PRINT *,'ERROR READING FROM FILE UNIT ',mmin
    GOTO 9999
9100 PRINT *,'END OF FILE REACHED '
    GOTO 9999
9200 PRINT *,'ERROR WRITING ON FILE UNIT ',mout
    CLOSE(mmin)
    CLOSE(mout)
9999 RETURN
END SUBROUTINE read_write
