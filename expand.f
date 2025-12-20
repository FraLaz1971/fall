      REAL FUNCTION EXPAND(XX,YY)
        IMPLICIT NONE
        INTEGER I
        REAL XX,YY
        DIMENSION XX(*),YY(1:*)
        EXPAND=0.0
        XX(5)=4.67
        YY(3)=100.87
        YY(4)=-600.52
        YY(5)=25.2
        DO 10,I=1,5
          EXPAND=XX(I)*YY(I)+EXPAND
10      CONTINUE
      END
      PROGRAM UEXPAN
        IMPLICIT NONE
        REAL A,B,EXPAND
        DIMENSION A(4),B(2)
        DATA A/-10.2,101.23,0.77,-1001.45/,B/2.2,-1001.67/
        PRINT 100,EXPAND(A,B)
100   FORMAT('EXPAND = ',F11.3)
      END
