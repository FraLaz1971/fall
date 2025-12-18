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
        DATA STANUM/205,165,247,114,204,244,95,212,32,122/
c        DO 10,I=1,NEMPL
c          PRINT *,STANUM(I),ENAME(I)(1:16)
c10      CONTINUE
        DATA WTWH/35,38,36,41,45,38,39,40,42,25/
        DATA WTWM/02,12,26,44,58,13,06,31,17,20/
        OFILE='2025-12-08_data.dat'
c        CALL CRDATF(OFILE,STANUM,WTWH,WTWM,NEMPL)
        DATA WTWH2/32,36,40,42,35,39,39,42,41,39/
        DATA WTWM2/12,15,36,53,54,23,16,01,18,30/
        OFILE='2025-12-15_data.dat'
c        CALL CRDATF(OFILE,STANUM,WTWH2,WTWM2,NEMPL)
         OFILE='2025-12-15_data.dat'
         CALL ODF(OFILE,NEMPL)
         OFILE='2025-12-08_data.dat'
         CALL ODF(OFILE,NEMPL)
      END
C subroutine to Create Data Files
      SUBROUTINE CRDATF(FNAM,STANUM,WTWH,WTWM,NEMPL)
        IMPLICIT NONE
        CHARACTER*20 FNAM
        CHARACTER*10 ROW
        INTEGER I,J,NEMPL
        INTEGER STANUM(NEMPL),WTWH(NEMPL),WTWM(NEMPL)
        OPEN(11,FILE=FNAM)
        DO 10,I=1,NEMPL
          WRITE(ROW,100)STANUM(I),WTWH(I),WTWM(I)
          DO 20,J=5,LEN(ROW)
            IF (ROW(J:J).EQ.' ') ROW(J:J)='0'
20        CONTINUE
          WRITE(11,'(A9)')ROW
10      CONTINUE
        CLOSE(11)
100     FORMAT(I3,1X,I2,':',I2)
        RETURN
      END
C ORDER DATA FILE: SUBROUTINE THAT READ A UNORDERED EMPLOYEE DATA FILE
C AND GIVES A ORDERED FOR STAFF N. DATA FILE
      SUBROUTINE ODF(IFNAM,NEMPL)
        IMPLICIT NONE
        CHARACTER*32 IFNAM,OFNAM
        INTEGER NEMPL,STANUM(NEMPL),WTWH(NEMPL),WTWM(NEMPL)      
        INTEGER TANU1,TWH1,TWM1,POSI,I,J,K,IOS,IO
        LOGICAL CHANGE
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
        I=1
        K=1      
       DO 10,I=1,NEMPL,2
          READ(11,100,ERR=9000,END=5)STANUM(I),WTWH(I),WTWM(I)
          PRINT *,'READ',STANUM(I),WTWH(I),WTWM(I)
          READ(11,100,ERR=9200,END=5)STANUM(I+1),WTWH(I+1),WTWM(I+1)
          PRINT *,'READ',STANUM(I+1),WTWH(I+1),WTWM(I+1)
10     CONTINUE
       I=1
5      IF(STANUM(I+1).LT.STANUM(I)) THEN
            TANU1=STANUM(I)
            TWH1=WTWH(I)
            TWM1=WTWM(I)
            STANUM(I)=STANUM(I+1)
            WTWH(I)=WTWH(I+1)
            WTWM(I)=WTWM(I+1)
            STANUM(I+1)=TANU1
            WTWH(I+1)=TWH1
            WTWH(I+1)=TWM1
        END IF
        IF((I+1).GE.NEMPL) GOTO 20
        I=I+1
        GOTO 5
20      CONTINUE
        K=K+1
        IF (K.LT.NEMPL) THEN
          PRINT *,'RESTARTING CHECKING FROM ROW ',K
          I=K
          GOTO 5
        END IF
        CLOSE(11)
        PRINT *,'WRITING FILE ',OFNAM
60      OPEN(12,FILE=OFNAM)
        DO 40,I=1,NEMPL
          WRITE(*,200)STANUM(I),WTWH(I),WTWM(I)
          WRITE(12,200)STANUM(I),WTWH(I),WTWM(I)
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
