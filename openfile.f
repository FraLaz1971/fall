      PROGRAM TI
C TEST INQUIRE INSTRUCTION
        CALL OPNFIL
      END
      SUBROUTINE OPNFIL
        IMPLICIT NONE
C THIS SUBROUTINE OPENS THREE FILES
C UNIT 7 IS THE OLD MASTER FILE
C UNIT 8 IS THE NEW MASTER FILE AND DOESN'T EXIST YET
C UNIT 10 IS NOT USED, BUT SHOULD BE DELETED
C          AT THE END OF AN ERROR-FREE PROGRAM EXECUTION
        INTEGER U(5),I,J
        LOGICAL F(3)
        CHARACTER*12 MFILE(3)
        DATA MFILE/'file1.txt','file2.txt','file3.txt'/, U/10,7,8,10,7/
C ESTABLISH WICH FILE DOES NOT EXIST
        DO 5,I=1,3
          INQUIRE(FILE=MFILE(I),EXIST=F(I))
          IF(F(I)) THEN
            PRINT *,'File ',MFILE(I),' EXIST'
          ELSE
            PRINT *,'File ',MFILE(I),' DOESN''T EXIST'
          END IF
5       CONTINUE
C SET J TO INDICATE UNIT NUMBERS FOR THE THREE FILES
        IF (F(1).AND.F(2)) THEN
C IF file1.txt and file2.txt exist
C IF file3.txt also exist goto 99
          IF (F(3)) GOTO 99
          J=0
        ELSE IF (F(2).AND.F(3)) THEN
C IF file2.txt and file3.txt exist,
C IF file1.txt also exist goto 99
          IF (F(1)) GOTO 99
          J=2
        ELSE IF (F(3).AND.F(1)) THEN
C IF file3.txt and file1.txt exist,
          IF (F(2)) GOTO 99
          J=1
        ELSE
          GOTO 99
        END IF
C open all 3 files
        DO 20,I=1,3
          OPEN(UNIT=U(I+J),FILE=MFILE(I),ACCESS='DIRECT',
     * RECL=56,ERR=98)
20      CONTINUE
        RETURN
C error during file opening
98      PRINT 298,MFILE(I)
298     FORMAT(1H1,'*** ERROR DURING OPENING OF ',A12,
     * ' - PROCESSING TERMINATED ***')
        STOP
C WRONG NUMBERS OF FILES EXIST
99      PRINT 299,(MFILE(I),F(I),I=1,3)
299     FORMAT(1H1,'*** INVALID FILE COMBINATION:'//
     1  ,'  FILE NAME     EXISTS'/
     2  3(A12,5X,L1/)/
     3  ,'PROCESSING TERMINATED')
        STOP
      END
