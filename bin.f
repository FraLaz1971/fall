      PROGRAM BINARY
        IMPLICIT NONE
        CHARACTER STR*6,R*1,SBIN*17
        PRINT *,'CONVERT FROM DECIMAL TO BINARY'
        PRINT *,'AND FROM BINARY TO DECIMAL'
10      PRINT *,'HAVE YOU BINARY OR DECIMAL (B or D)?'
        READ *,R
        PRINT *,'PLEASE ENTER YOUR NUMBER'
        IF ((R.EQ.'B').OR.(R.EQ.'b')) THEN
          READ *,SBIN
          CALL B2D(SBIN)
        ELSE IF ((R.EQ.'D').OR.(R.EQ.'d')) THEN
          READ *,STR
          CALL D2B(STR)
        ELSE
          PRINT *,'PLEASE SELECT B OR D'
          GOTO 10
        END IF
      END
C256______________      
      SUBROUTINE B2D(SBIN)
        IMPLICIT NONE
        CHARACTER*17 SBIN
        INTEGER RES,I
        RES=0
        DO 10,I=2,17
        IF (SBIN(18-I:18-I).NE.' ') THEN
            RES=(ICHAR(SBIN(18-I:18-I))-48)*2**(17-I)+RES
        END IF
10      CONTINUE
        PRINT *,'RES= ',RES
      END
C      
      SUBROUTINE D2B(STR)
        IMPLICIT NONE
        CHARACTER STR*6,SBIN*17,STEMP*17
        INTEGER DEC,STR2D,REST,I,J
        DATA SBIN/'                 '/,STEMP/'                 '/
        I=0
        DEC=STR2D(STR)
10      REST=MOD(DEC,2)
        SBIN(17-I:17-I)=CHAR(REST+48)
c        PRINT 100,I,CHAR(REST+48),DEC
        DEC=DEC/2
        I = I+1
        IF (DEC.GT.0) GOTO 10
C        PRINT *,'I=',I,' SBIN=',SBIN
        DO 20,J=1,I
          STEMP(J:J)=SBIN(J+(17-I):J+(17-I))
20      CONTINUE
        DO 30,I=1,17
        IF ((STEMP(I:I).GE.'0').AND.(STEMP(I:I).LE.'9')) THEN
          SBIN(I:I)=STEMP(I:I)
        ELSE
          SBIN(I:I)=' '
        END IF
30      CONTINUE
        PRINT *,' SBIN=',SBIN
100   FORMAT('SBIN(17-',I2,')=',A1,' DEC=',I6)
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
