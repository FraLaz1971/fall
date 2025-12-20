      PROGRAM FUN101
C f(x)=sin(x)exp(-x/a) for values of x included between 
c x=0 and x=2. in step of dx=0.1
        INTEGER I,NPOINT
        REAL X,Y,A,XMIN,XMAX,DX
        DIMENSION Y(200)
        DATA A/0.65/,XMIN/0.0/,XMAX/2.0/,DX/0.1/
        X=XMIN
        NPOINT=(XMAX-XMIN)/DX+1.0001
        DO 10,I=1,NPOINT
          Y(I)=SIN(X)*EXP(-X/A)
          X=X+DX
          PRINT 100,X,Y(I)
10      CONTINUE
100     FORMAT(F3.1,1X,F10.6)
        STOP
      END
