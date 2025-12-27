      PROGRAM BINARY
        IMPLICIT NONE
        CHARACTER STR*6,R*1,SBIN*17
        PRINT *,'CONVERT FROM DECIMAL TO BINARY'
        PRINT *,'AND FROM BINARY TO DECIMAL'
10      PRINT *,'HAVE YOU BINARY OR DECIMAL (B or D, X to stop)?'
        READ *,R
        PRINT *,'PLEASE ENTER YOUR NUMBER'
        IF ((R.EQ.'B').OR.(R.EQ.'b')) THEN
          SBIN='                 '
          READ *,SBIN
          CALL B2D(SBIN)
        ELSE IF ((R.EQ.'D').OR.(R.EQ.'d')) THEN
          STR='      '
          READ *,STR
          CALL D2B(STR)
        ELSE IF ((R.EQ.'X').OR.(R.EQ.'x')) THEN
          GOTO 9999
        ELSE
          PRINT *,'PLEASE SELECT B OR D OR X'
        END IF
        GOTO 10
9999  STOP
      END


C1110001__________     
      SUBROUTINE B2D(SBIN)
        IMPLICIT NONE
        CHARACTER SBIN*17
        INTEGER RES,I,CNTC
        RES=0
        CNTC=0
        DO 10,I=1,16
        IF (SBIN(I:I).NE.' ') THEN
            CNTC=CNTC+1
        END IF
10      CONTINUE
        DO 20,I=1,CNTC
        IF (SBIN(I:I).NE.' ') THEN
          RES=(ICHAR(SBIN(I:I))-48)*2**(CNTC-I)+RES
        END IF
20      CONTINUE
        PRINT 100,RES
100     FORMAT(I5)
      END
C      
      SUBROUTINE D2B(STR)
        IMPLICIT NONE
        CHARACTER STR*6,SBIN*17
        INTEGER DEC,STR2D,REST,I
        LOGICAL DEBUG
        SBIN='                 '
        DEBUG=.FALSE.
        I=0
        DEC=STR2D(STR)
10      REST=MOD(DEC,2)
        SBIN(16-I:16-I)=CHAR(REST+48)
        IF (DEBUG) PRINT 100,I,CHAR(REST+48),DEC
        DEC=DEC/2
        I = I+1
        IF (DEC.GT.0) GOTO 10
        IF (DEBUG) PRINT *,'I=',I,' SBIN=',SBIN
        PRINT *,SBIN(17-I:16)
100   FORMAT('SBIN(16-',I2,')=',A1,' DEC=',I6)
      END

      INTEGER FUNCTION STR2D(STR)
        IMPLICIT NONE
        CHARACTER*6 STR
        INTEGER I,POSI
        POSI=INDEX(STR,' ')
C        PRINT *,'STR=',STR,' POSI=',POSI
        STR2D=0
        DO 10,I=1,POSI-1
          IF (STR(I:I).NE.' ') THEN
            STR2D=(ICHAR(STR(I:I))-ICHAR('0'))*10**(POSI-I-1)+STR2D
          ELSE
          END IF
10      CONTINUE
        RETURN
      END
