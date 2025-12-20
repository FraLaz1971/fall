C FACTORIAL OF AN INTEGER NUMBER
      DOUBLE PRECISION FUNCTION FACTRL(N)
        IMPLICIT NONE
        INTEGER N,I,TEMP
        FACTRL=0.0
C        PRINT *,'COMPUTING FACTRL() N =',N
        IF (N.LT.0) THEN
          GOTO 9999
        ELSE IF (N.EQ.0) THEN
          FACTRL=1.0
          RETURN
        ELSE
          FACTRL=1.0
          DO 10,I=N,2,-1
            FACTRL=I*FACTRL
10        CONTINUE
        END IF
        GOTO 9999
9000    PRINT *,'ERR.:IMPOSSIBLE COMPUT FACTORIAL OF A NEGATIVE NUM.'        
9999    RETURN
      END
C MYSIN calculate sin of the first argument
C with the Taylor series development e and gives back the sin
C with a precision = 10−7      
      PROGRAM TAYSIN
        IMPLICIT NONE
        DOUBLE PRECISION FACTRL
        REAL X,MYSIN
        INTEGER P
        PRINT *,'ENTER A REAL NUMBER (-2PI,2PI) AND INT. NUMBER OF PASS 
     &   (X,P)'
        READ *,X,P
        PRINT '(''X:'',F10.6,'' P:'',I2)',X,P
        PRINT *,'FACTRL(',2*P+1,')=',FACTRL(2*P+1)
        PRINT 100,X,MYSIN(X,P)
        STOP
100   FORMAT('SIN(',F10.6,') =',F10.6)
      END
      
      REAL FUNCTION MYSIN(P1,P2)
          IMPLICIT NONE
          REAL P1,DELTA
          DOUBLE PRECISION FACTRL
          INTEGER P2
          MYSIN = P1
          DO 10,P2 = 1,100
            DELTA = (-1)**P2 * P1**(2*P2+1) / FACTRL(2*P2+1)
            IF (ABS(DELTA).LT. 1E-7) RETURN
            MYSIN = MYSIN + DELTA
10        CONTINUE
          RETURN
      END
