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
      PROGRAM PAYDAT
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
        DATA WTWH/35,38,36,41,45,38,39,40,42,25/
        DATA WTWM/02,12,26,44,58,13,06,31,17,20/
        DATA BASRAT/13.50,12.00,14.00,11.40,11.30,15.00,12.20
     &,11.20,13.70,12.25/
        DATA HIGRAT/16.50,14.80,15.20,13.65,15.25,18.10,15.10
     &,14.75,16.15,15.75/
        DATA NBH/35,36,34,35,33,37,35,37,40,38/
        OFILE='2025-12-08_data.dat'
        CALL CRDATF(OFILE,STANUM,WTWH,WTWM,NEMPL)
        DATA WTWH2/32,36,40,42,35,39,39,42,41,39/
        DATA WTWM2/12,15,36,53,54,23,16,01,18,30/
        OFILE='2025-12-15_data.dat'
        CALL CRDATF(OFILE,STANUM,WTWH2,WTWM2,NEMPL)
        STANUM(1)= 32
        STANUM(2)= 95
        STANUM(3)=114
        STANUM(4)=122
        STANUM(5)=165
        STANUM(6)=204
        STANUM(7)=205
        STANUM(8)=212
        STANUM(9)=244
        STANUM(10)=247    
        CALL WEMFIL(NEMPL,STANUM,ENAME,BASRAT,HIGRAT,NBH)
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
C WEMFIL:WRITE EMPLOYEE FILE, THAT CONTAIN ALL EMPLOYEE RELATED INFO
C BASIC RATE (BASRAT) HIGHER RATE (HIRAT) AND NUMBER OF BASIC HOURS
C (NBH)
      SUBROUTINE WEMFIL(N,STANUM,ENAME,BASRAT,HIGRAT,NBH)
        IMPLICIT NONE
C N=NUMBER OF EMPLOYEE
        INTEGER N,I,STANUM(N),NBH(N)
        REAL BASRAT(N),HIGRAT(N)
        CHARACTER*32 ENAME(N)
        CHARACTER*64 OFNAM
        OFNAM='employee_data.txt'
        OPEN(11,FILE=OFNAM)
        DO 10,I=1,N
          WRITE(11,100) STANUM(I),ENAME(I),BASRAT(I),HIGRAT(I),NBH(I)
10      CONTINUE
        CLOSE(11)
100   FORMAT(I3,1X,A16,2(1X,F6.2),1X,I2)
9999  RETURN
      END
