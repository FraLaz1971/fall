!Write a program which first reads the number of people sitting an exame. It should then
!read their marks (or scores) and print the highest and lowest marks, followed by the
!average mark for the class.
program marks_data
  IMPLICIT NONE
  call create_dataset
end program marks_data
!scores in (0,10)
subroutine create_dataset
  IMPLICIT NONE
  INTEGER :: I,MDIM
  PARAMETER(MDIM=32)
  REAL MARK(MDIM),GETRAN
  CHARACTER*80 OFNAM
  character*20 MNAME(MDIM)
  DATA MNAME/'Mary Johns          ','Andrew Richley      ',&
     &            'James Smith ','John Johnson ',&
     &            'Robert Williams ','Barbara Brown ',&
     &            'Elizabeth Jones ','Jennifer Miller ',&
     &            'Maria Davis ','Charles Garcia ',&
     &            'Margaret Rodriguez ','Thomas Wilson ',&
     &            'Lisa Martinez ','Daniel Anderson ',&
     &            'Karen Taylor ','Mark Thomas ',&
     &            'Donald Hernandez ','Sandra Moore ',&
     &            'Donna Martin ','Steven Jackson ',&
     &            'Ruth Thompson ','Brian White ',&
     &            'Ronald Lopez ','Anthony Lee ',&
     &            'Sarah Gonzalez ','Jason Harris ',&
     &            'Deborah Clark ','Gary Lewis ',&
     &            'Timothy Robinson ','Jose Walker ',&
     &            'Angela Perez ','Jeffrey Hall '/
  OFNAM='marks_data_001.txt'
  call INI_RAN
  OPEN(11,FILE=OFNAM,ERR=9000)
  WRITE(11,'(I3)',ERR=9100) MDIM
  DO I=1,MDIM
    MARK(I)=GETRAN(10.0)+7.0
    IF (MARK(I).GT.10.0) MARK(I)=10.0 
 	WRITE(11,100,ERR=9100) MNAME(I),MARK(I)
  END DO
  CLOSE(11)
  GOTO 9999
100   FORMAT(A20,',',F4.1)
9000  PRINT *,'ERROR IN OPENING OUTPUT FILE ',OFNAM
  GOTO 9999
9100  PRINT *,'ERROR IN WRITING DATA '
9999  RETURN
end subroutine create_dataset
