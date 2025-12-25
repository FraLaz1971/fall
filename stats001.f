      PROGRAM STATS1
        IMPLICIT NONE
        REAL X,AVG,STDEV,GETRAN
        INTEGER N,I,M
        PARAMETER(N=100000)
        DIMENSION X(N)
C AVERAGE: 1/N*(SUM X_i (i=1,n))
        DATA X/-10.,15.77,66.23,-121.12,-1000.87,13.3333,66.99,0.0,
     & 22.7,-24000.13,99990*0/
        M=10
        PRINT 100,AVG(X,M)
        PRINT 200,STDEV(X,M)
        M=100000
        CALL INI_RAN
        DO 10,I=1,M
          X(I)=GETRAN(10000.)
10      CONTINUE
        PRINT 100,AVG(X,M)
        PRINT 200,STDEV(X,M)
        STOP
100   FORMAT('THE average of X is: ',F9.2)
200   FORMAT('THE std. dev. of X is: ',F9.2)
      END
C AVG TAKES AS INPUT THE ARRAY X OF ELEMENTS ON WICH COMPUTE
C THE AVERAGE AND THE SIZE N OF THE (PORTION OF THE) ARRAY 
      REAL FUNCTION AVG(X,N)
        IMPLICIT NONE
        REAL X(N),MSUM
        INTEGER N,I
        MSUM=0.0
        DO 10,I=1,N
          MSUM=MSUM+X(I)
10      CONTINUE
        AVG=MSUM/N
        RETURN
      END
      REAL FUNCTION STDEV(X,N)
        IMPLICIT NONE
        INTEGER N,I
C XM IS THE AVERAGE OF X_i
        REAL X(N),XM,QSUM,AVG
        XM=AVG(X,N)
        QSUM=0.0
        DO 10,I=1,N
          QSUM=QSUM+(X(I)-XM)**2
10      CONTINUE
        STDEV=SQRT(1.0/(N-1.0)*QSUM)
        RETURN
      END
