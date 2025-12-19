C Employees of a certain organization have their weekly pay this way:
C (a) GROSS PAY: N hours * basic rate +  M plus subsequent hours * higher rate
C For each employee, the 2 rates and n. of basic hours are fixed
C (b) Tax is a fixed percentage of the (GROSS PAY - tax_free_allowance)
C (c) Health insurance is a fixed percentage of that part of the gross pay
C wich falls below a fixed limit
C (d) The nett pay is the GROSS PAY less tax and health insurance deduction
C A file is kept which contains details of all weekly paid employees in increasing
C order of their staff number
C Each week a file of data is prepared containing, for each employee, their
C staff number, the hours worked in hours and minutes during the previous week
C This data is sorted into increasing order of staff numbers before input to the
C rest of the program.
C write a program to update the master file and to produce weekly payslips showing
C staff_number, surname,  name , gross_pay, deductions, nett_pay
      PROGRAM PAYROL
        IMPLICIT NONE
C NEMPL=NUMBER OF EMPLOYEES
        INTEGER NEMPL,I
        PARAMETER(NEMPL=10)
C NBH=NUMBER OF BASIC HOURS x EMPLOYEE
C NSH=NUMBER OF SUBSEQUENT HOURS x EMPLOYEE
C ENAME=EMPLOYEE NAME (NAME, SURNAME IN A SINGLE STRING)
C STANUM=STAFF NUMBER
        INTEGER NBH(NEMPL),STANUM(NEMPL),WTWH(NEMPL),WTWM(NEMPL)
        INTEGER WTWH2(NEMPL),WTWM2(NEMPL)
        INTEGER NSH(NEMPL)
        CHARACTER*32 ENAME(NEMPL)
        CHARACTER*10 EDATE
C BASRAT=BASIC RATE HIGRAT: HIGHER RATE
C TFA=TAX FREE ALLOWANCE, HEAINS=HEALTH INSURANCE THAT IS A FIXED %
C OF THAT PART OF THE GROPAY THAT IS UNDER A FIXED LIMIT
C NETPAY(I) = GROPAY(I)-TAX(I)+HEAINS(I)
C UFILE is the unsorted data file
        REAL GROPAY(NEMPL),BASRAT(NEMPL),HIGRAT(NEMPL),TFA(NEMPL)
     &,HEAINS(NEMPL),NETPAY(NEMPL)
        CHARACTER*64 UFILE,OFILE
        DATA ENAME/'Mary Johns','Andrew Richley','Mary Smith',
     & 'John Johnson','Linda Williams','Barbara Brown','Elizabeth Jones' 
     &,'David Miller','Richard Davis','Susan Garcia'/
         OFILE='2025-12-15_data.dat'
         CALL ODF(OFILE,NEMPL)
         OFILE='2025-12-08_data.dat'
         CALL ODF(OFILE,NEMPL)
      END
C ORDER DATA FILE: SUBROUTINE THAT READ A UNORDERED EMPLOYEE DATA FILE
C AND GIVES A ORDERED FOR STAFF N. DATA FILE
      SUBROUTINE ODF(IFNAM,NEMPL)
        IMPLICIT NONE
        INTEGER NCHAN
        LOGICAL CHANGE
        CHARACTER*32 IFNAM,OFNAM
        CHARACTER*10 ROW
        INTEGER NEMPL,STANUM(NEMPL),WTWH(NEMPL),WTWM(NEMPL)      
        INTEGER TANU1,TWH1,TWM1,POSI,I,J,IOS,IO
        DO 30,I=1,NEMPL
          STANUM(I)=0
          WTWH(I)=0
          WTWM(I)=0
30      CONTINUE
        POSI=INDEX(IFNAM,'.')
        OFNAM=IFNAM(1:POSI-1)//'_o.dat'
        INQUIRE(FILE=IFNAM,IOSTAT=IOS)
        IF(IOS.LT.0) GOTO 8100
        OPEN(11,FILE=IFNAM,ERR=8000,IOSTAT=IO)
        PRINT *,'OPENED FILE ',IFNAM,' IO= ',IO
        PRINT *,'GOING TO READ',NEMPL,'RECORDS'
        DO 10,I=1,NEMPL,2
          READ(11,100,ERR=9000,END=5)STANUM(I),WTWH(I),WTWM(I)
          PRINT *,'READ',STANUM(I),WTWH(I),WTWM(I)
          READ(11,100,ERR=9200,END=5)STANUM(I+1),WTWH(I+1),WTWM(I+1)
          PRINT *,'READ',STANUM(I+1),WTWH(I+1),WTWM(I+1)
10     CONTINUE
       CLOSE(11)
5       CHANGE=.TRUE.
        NCHAN=0
        DO 70,I=1,NEMPL
            IF(CHANGE) THEN
              CALL SHOW(STANUM,WTWH,WTWM,NEMPL)
              CALL PASS(STANUM,WTWH,WTWM,I,NEMPL,CHANGE)
              NCHAN=NCHAN+1
            ELSE
                IF (NCHAN.GT.1) GOTO 5
            END IF
70      CONTINUE
        CALL SHOW(STANUM,WTWH,WTWM,NEMPL)
        PRINT *,'WRITING FILE ',OFNAM
60      OPEN(12,FILE=OFNAM)
        DO 40,I=1,NEMPL
          WRITE(ROW,200)STANUM(I),WTWH(I),WTWM(I)
          DO 20,J=5,LEN(ROW)
            IF (ROW(J:J).EQ.' ') ROW(J:J)='0'
20        CONTINUE
          WRITE(12,'(A9)')ROW
c          WRITE(*,200)STANUM(I),WTWH(I),WTWM(I)
c          WRITE(12,200)STANUM(I),WTWH(I),WTWM(I)
40      CONTINUE
        CLOSE(12)
        GOTO 9999
100     FORMAT(I3,1X,I2,1X,I2)
200     FORMAT(I3,1X,I2,':',I2)
8000    PRINT *,'ERROR OPENING FILE ',IFNAM
        GOTO 9999
8100    PRINT *,'FILE ',IFNAM,'DOES NOT EXIST'
        GOTO 9999
9000    PRINT *,'ERROR IN READING DATA ROW',I
        GOTO 9999
9100    PRINT *,'END OF FILE REACHED, ROW N.',I
        GOTO 9999
9200    PRINT *,'ERROR IN READING DATA ROW',I+1
        GOTO 9999
9300    PRINT *,'END OF FILE REACHED, ROW N.',I+1
        GOTO 9999
9999    RETURN
      END
C
      SUBROUTINE SHOW(STANUM,WTWH,WTWM,N)
        IMPLICIT NONE
        INTEGER I,N
        INTEGER STANUM(N),WTWH(N),WTWM(N)
        PRINT *,'SHOWING ARRAY'
        DO 10,I=1,N
          PRINT '(I3,1X,I2,'':'',I2)', STANUM(I),WTWH(I),WTWM(I)
10      CONTINUE
      END
C
      SUBROUTINE PASS(STANUM,WTWH,WTWM,START,N,CHANGE)
        IMPLICIT NONE
        INTEGER I,N,START
        INTEGER STANUM(N),WTWH(N),WTWM(N),TANU1,TWH1,TWM1
        LOGICAL CHANGE
        CHANGE=.FALSE.
        PRINT *,'SORTING PASS',START
        DO 10,I=START,N-1
          IF(STANUM(I+1).LT.STANUM(I)) THEN
            CALL INVERT(STANUM(I),STANUM(I+1))
            CALL INVERT(WTWH(I),WTWH(I+1))
            CALL INVERT(WTWM(I),WTWM(I+1))
            CHANGE=.TRUE.
          END IF
10      CONTINUE
      END
C
      SUBROUTINE INVERT(U,V)
        INTEGER U,V,T
            T=U
            U=V
            V=T
      END
