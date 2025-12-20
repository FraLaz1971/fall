      PROGRAM FUN100
C f(x)=sin(x)exp(-x/a) for values of x included between 
c x=0 and x=2. in step of dx=0.1
        INTEGER I
        REAL X(21),Y(21),A
        DATA A/0.2/
        DO 10,I=1,21
          X(I)=(I-1)/10.0
          Y(I)=SIN(X(I))*EXP(-X(I)/A)
          PRINT 100,X(I),Y(I)
10      CONTINUE
100     FORMAT(F3.1,1X,F10.6)
        STOP
      END
