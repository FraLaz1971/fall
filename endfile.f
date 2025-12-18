      PROGRAM ENDF
        IMPLICIT NONE
        CHARACTER*64 IFNAM
        CHARACTER*1024 LINE
        INTEGER I,IOS
        PRINT *,'ENTER INPUT FILE NAME'
        READ *,IFNAM
        I=1
        OPEN(11,FILE=IFNAM)
10      READ(11,'(A)',END=80,ERR=9000,IOSTAT=IOS) LINE
          PRINT '(A,I4,A,A80)','LINE ',I,': ',LINE(1:80)
          IF(I.EQ.6) THEN 
             BACKSPACE(11)
c            ENDFILE(11)
c            REWIND(11)
          END IF
          I=I+1
          GOTO 10
80        CLOSE(11)
        PRINT *,'END OF FILE REACHED: EXITING'
        GOTO 9999
9000    PRINT 100,I,IOS
9999    STOP
100     FORMAT('ERROR IN READING LINE',I4,' IOSTAT: ',I4)
      END
