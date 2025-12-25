         PROGRAM FMTS
         IMPLICIT NONE
         INTEGER A,B,C
         REAL RA,RB,RC,RD
         A=5
         B = -10
         C = 2224
         WRITE ( *, 20 ) A, B, C
20      FORMAT(3I4)
         WRITE ( *, 21 ) A, B, C
21      FORMAT(3(1X,I4))
         WRITE ( *, 22 ) A, B, C
22      FORMAT(1X,'A = ',I2 ,1X,'B = ',I3,1X,'C = ',I5,/)
         RA = 12
         RB = 25.4
         RC = -1.23
         WRITE ( *, 120 ) RA, RB, RC
120      FORMAT(F3.0,F4.1,F5.2)
         WRITE ( *, 121 ) RA, RB, RC
121      FORMAT(F3.0,1X,2(E12.4,1X))
         WRITE ( *, 122 ) RA, RB, RC
122      FORMAT(F3.0,1X,E12.4,1X,D12.4)
         RA = 1.
         RB = 10.
         RC = 100.
         RD = 1000.
         WRITE ( *, 220 ) RA, RB, RC, RD
220      FORMAT(5G10.4)
        WRITE ( *, 221 ).TRUE.,.FALSE.
221      FORMAT(2L2)
        WRITE ( *, 222 ) 'BUONGIORNO'
222      FORMAT(A6)
        END
