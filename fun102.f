      PROGRAM FUN100
C f(x)=cos(x)exp(-x*a) for values of x included between 
c x=-100 and x=-92. in step of dx=0.05
        INTEGER I
        REAL X(161),Y(161),A
        DATA A/7.5/
        DO 10,I=1,161
          X(I)=-100+(I-1)*0.05
          Y(I)=COS(X(I))*(EXP(-X(I)/A))**0.125
          PRINT 100,X(I),Y(I)
10      CONTINUE
100     FORMAT(F7.2,1X,F10.6)
        STOP
      END
