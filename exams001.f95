!Write a program which first reads the number of people sitting an exame. It should then
!read their marks (or scores) and print the highest and lowest marks, followed by the
!average mark for the class.
program marks
  IMPLICIT NONE
  call marks_stat
end program marks
!scores in (0,10)
subroutine marks_stat
  IMPLICIT NONE
  INTEGER :: I,MDIM,RDIM
  PARAMETER(MDIM=1024)
  REAL MARK(MDIM),HMARK,LMARK,MSUM,AVG
  CHARACTER*80 IFNAM
  character*20 MNAME(MDIM)
  IFNAM='marks_data_001.txt'
  HMARK=-1.0
  LMARK=11.0
  MSUM=0.0
  I=0
  OPEN(11,FILE=IFNAM,ERR=9000)
  READ(11,'(I3)',ERR=9100) RDIM
  DO I=1,RDIM
    READ(11,100,ERR=9100) MNAME(I),MARK(I)
    IF(MARK(I).GT.HMARK) HMARK=MARK(I)
    IF(MARK(I).LT.LMARK) LMARK=MARK(I)
    MSUM=MSUM+MARK(I)
  END DO
  CLOSE(11)
  AVG=MSUM/RDIM
  PRINT 110,HMARK,LMARK,AVG
  goto 9999
100   FORMAT(A20,1X,F4.1)
110   FORMAT('MAX SCORE: ',F4.1,' MIN SCORE: ',F4.1,' CLASS AVERAGE: ',F4.1)
9000  PRINT *,'ERROR IN OPENING INPUT FILE ',IFNAM
  GOTO 9999
9100  PRINT *,'ERROR IN READING DATA RECORD',I
9999  RETURN  
end subroutine marks_stat
