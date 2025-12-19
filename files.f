C Employees of a certain organization have their weekly pay this way:
C (a) GROSS PAY = N hours * basic rate +  M plus subsequent hours * higher rate
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
C TP: TAX PERCENTAGE
C HP: HEALTH INSURANCE PERCENTAGE

        INTEGER NBH(NEMPL),STANUM(NEMPL),WTWH(NEMPL),WTWM(NEMPL)
        INTEGER WTWH2(NEMPL),WTWM2(NEMPL)
        INTEGER NSH(NEMPL),TP,HP
        CHARACTER*32 ENAME(NEMPL)
        CHARACTER*10 EDATE
C BASRAT=BASIC RATE HIGRAT: HIGHER RATE
C TFA=TAX FREE ALLOWANCE, HEAINS=HEALTH INSURANCE THAT IS A FIXED %
C OF THAT PART OF THE GROPAY THAT IS UNDER A FIXED LIMIT (HFL)
C NETPAY(I) = GROPAY(I)-(TAX(I)+HEAINS(I))
C UFILE is the unsorted data file
        REAL GROPAY(NEMPL),BASRAT(NEMPL),HIGRAT(NEMPL),TFA,HFL
     &,HEAINS(NEMPL),NETPAY(NEMPL),TAX(NEMPL)
        CHARACTER*64 UFILE,OFILE
        COMMON /CONST/TFA,HFL,TP,HP
C TAX FREE ALLOWANCE IS 300 $
C GROSS PAY FIXED LIMIT FOR HEALTH INSURANCE IS 200 $
        DATA TFA/300.0/,HFL/200.0/,TP/32/,HP/16/
        CALL CAPARO(NEMPL,STANUM,ENAME,BASRAT,HIGRAT,NBH,GROPAY,TAX
     &,HEAINS,NETPAY)
      END
C CAlculate PAyROl: THIS SUBROUTINE OPEN THE EMPLOYEE FILE
C AND ONE OF THE WEEKLY DATA FILES
C FOR EACH EMPLOYEE IDENTIFIED BY STAFF NUMBER (BOTH FILES ARE ORDERED
C FROM SMALLER TO GREATER STAFF NUMBER), COMPUTE GROSS WEEKLY PAY
      SUBROUTINE CAPARO(N,STANUM,ENAME,BASRAT,HIGRAT,NBH,GROPAY,TAX
     &,HEAINS,NETPAY)
        IMPLICIT NONE
C GROPAY SAVES THE COMPUTED GROSS PAY AS OUTPUT
C EFNAM: EMPLOYEES DATA FILE NAME
C WPFNAM: WEEKLY PAY FILE NAME (ONE FOR WEEK)
        INTEGER N,I,STANUM(N),STANU2(N),NBH(N),MAXEMP,WTWH(N)
     &,WTWM(N),TP,HP
        PARAMETER(MAXEMP=100)
        REAL BASRAT(N),HIGRAT(N),GROPAY(N),WWH(N),TFA,HFL,TAX(N)
     &,HEAINS(N),NETPAY(N)
        CHARACTER*32 ENAME(N)
        CHARACTER*64 EFNAM,WPFNM1,WPFNM2,PSW1,PSW2
        LOGICAL DEBUG
        COMMON /CONST/TFA,HFL,TP,HP
        DATA EFNAM/'employee_data.txt'/
        DATA WPFNM1/'2025-12-08_data_o.dat'/
        DATA WPFNM2/'2025-12-15_data_o.dat'/
        DATA PSW1/'paysleep_w49.dat'/
        DATA PSW2/'paysleep_w50.dat'/
        DEBUG=.FALSE.
C READ AND PROCESS PAYMENT DATA FROM WEEK 1 TO 5 DECEMBER 2025 
C OPEN EMPLOYEES DATA FILE
        IF (DEBUG) PRINT *,'OPENING FILE ',EFNAM
        OPEN(11,FILE=EFNAM,ERR=8000)
C OPEN FIRST WEEKLY PAY DATA FILE
        IF (DEBUG) PRINT *,'OPENING FILE ',WPFNM1
        OPEN(12,FILE=WPFNM1,ERR=8100)
C OPEN FOR WRITING FIRST PAYSLEEP
        IF (DEBUG) PRINT *,'OPENING FILE ',PSW1
        OPEN(13,FILE=PSW1,ERR=8200)
        IF (DEBUG) PRINT *,'#n ','stn','  name        ',
     &'bas.rate ','hi.rate ','#bas.h.'
        PRINT *,'stn','  name           ','GROPAY    ','TAX','  HEAINS '
     &   ,'NETPAY'
C FOR EACH EMPLOYEE
        DO 10,I=1,MAXEMP
          READ(11,100,END=80,ERR=9100)STANUM(I),ENAME(I),BASRAT(I)
     &,HIGRAT(I),NBH(I)
          READ(12,200,END=90,ERR=9200)STANU2(I),WTWH(I),WTWM(I)
          IF(STANUM(I).EQ.STANU2(I)) THEN
            IF(DEBUG)PRINT 110,I,STANUM(I),ENAME(I),BASRAT(I),HIGRAT(I)
     &,NBH(I)
C CALCULATE GRO(SS)PAY = N.hrs*basrat+ M.sub.hrs*higrat
C n. of worked hours x employee as real number
            WWH(I)=REAL(WTWH(I))+REAL(WTWM(I))/60.0
C CALCULATE GROSS PAY
            GROPAY(I)=NBH(I)*BASRAT(I)+(WWH(I)-NBH(I))*HIGRAT(I)
C TAX(I) = fixed % of (GROSS PAY - tax_free_allowance)
C CALCULATE TAX(I)
            IF ((GROPAY(I)-TFA).GT.0) THEN
              TAX(I)=(TP/100.0)*(GROPAY(I)-TFA)
            ELSE
              TAX(I)=0.0
            END IF
C CALCULATE HEAINS(I)
C HEAINS(I)=HFL*(HP/100.0)
            IF(GROPAY(I).GE.HFL) THEN
              HEAINS(I)=HFL*(HP/100.0)
            ELSE
              HEAINS(I)=0.0
            END IF
C CALCULATE NETPAY
C NETPAY(I)=GROPAY(I)-(TAX(I)-HEAINS(I))
            NETPAY(I)=GROPAY(I)-(TAX(I)+HEAINS(I))
            PRINT 120,STANUM(I),ENAME(I),GROPAY(I),TAX(I),HEAINS(I)
     &,NETPAY(I)
            WRITE(13,120,ERR=9300)STANUM(I),ENAME(I),GROPAY(I),TAX(I)
     &,HEAINS(I),NETPAY(I)
          ELSE
            GOTO 9000
          END IF
10      CONTINUE
80      REWIND(11)
90      CLOSE(12)
        CLOSE(13)
        PRINT *,'WEEK 1. THERE ARE ',I-1,'EMPLOYEES'
C OPEN SECOND WEEKLY PAY DATA FILE
        IF (DEBUG) PRINT *,'OPENING FILE ',WPFNM2
        OPEN(12,FILE=WPFNM2,ERR=9400)
        IF (DEBUG) PRINT *,'OPENING FILE ',PSW2
        OPEN(13,FILE=PSW2,ERR=9500)
C OPEN SECOND PAYSLIP FILE TO WRITE
        IF (DEBUG) PRINT *,'#n ','stn','  name        ',
     &'bas.rate ','hi.rate ','#bas.h.'
        PRINT *,'stn','  name           ','GROPAY    ','TAX','  HEAINS '
     &   ,'NETPAY'
C FOR EACH EMPLOYEE
        DO 20,I=1,MAXEMP
          READ(11,100,END=180,ERR=9100)STANUM(I),ENAME(I),BASRAT(I)
     &,HIGRAT(I),NBH(I)
          READ(12,200,END=190,ERR=9600)STANU2(I),WTWH(I),WTWM(I)
          IF(STANUM(I).EQ.STANU2(I)) THEN
            IF(DEBUG)PRINT 110,I,STANUM(I),ENAME(I),BASRAT(I),HIGRAT(I)
     &,NBH(I)
C CALCULATE GRO(SS)PAY = N.hrs*basrat+ M.sub.hrs*higrat
C n. of worked hours x employee as real number
            WWH(I)=REAL(WTWH(I))+REAL(WTWM(I))/60.0
C CALCULATE GROSS PAY
            GROPAY(I)=NBH(I)*BASRAT(I)+(WWH(I)-NBH(I))*HIGRAT(I)
C TAX(I) = fixed % of (GROSS PAY - tax_free_allowance)
C CALCULATE TAX(I)
            IF ((GROPAY(I)-TFA).GT.0) THEN
              TAX(I)=(TP/100.0)*(GROPAY(I)-TFA)
            ELSE
              TAX(I)=0.0
            END IF
C CALCULATE HEAINS(I)
C HEAINS(I)=HFL*(HP/100.0)
            IF(GROPAY(I).GE.HFL) THEN
              HEAINS(I)=HFL*(HP/100.0)
            ELSE
              HEAINS(I)=0.0
            END IF
C CALCULATE NETPAY
C NETPAY(I)=GROPAY(I)-(TAX(I)-HEAINS(I))
            NETPAY(I)=GROPAY(I)-(TAX(I)+HEAINS(I))
            PRINT 120,STANUM(I),ENAME(I),GROPAY(I),TAX(I),HEAINS(I)
     &,NETPAY(I)
            WRITE(13,120,ERR=9700)STANUM(I),ENAME(I),GROPAY(I),TAX(I)
     &,HEAINS(I),NETPAY(I)
          ELSE
            GOTO 9000
          END IF
20      CONTINUE
180     CONTINUE
190     CONTINUE
        PRINT *,'WEEK 2. THERE ARE ',I-1,'EMPLOYEES'
        GOTO 9999
100   FORMAT(I3,1X,A16,2(1X,F6.2),1X,I2)
110   FORMAT(I2,1X,I3,1X,A16,2(1X,F6.2),1X,I2)
120   FORMAT(I3,1X,A16,4(1X,F6.2))
200     FORMAT(I3,1X,I2,1X,I2)
8000    PRINT *,'ERROR OPENING FILE',EFNAM
        GOTO 9999
8100    PRINT *,'ERROR OPENING FILE',WPFNM1
        GOTO 9999
8200    PRINT *,'ERROR OPENING FILE',PSW1
        GOTO 9999
9000    PRINT *,'DATA NOT ORDERED: EXITING'
        GOTO 9999
9100    PRINT *,'ERROR READING FILE',EFNAM
        GOTO 9999
9200    PRINT *,'ERROR READING FILE',WPFNM1
        GOTO 9999
9300    PRINT *,'ERROR WRITING FILE',PSW1
        GOTO 9999
9400    PRINT *,'ERROR OPENING FILE',WPFNM2,'FOR READING'
        GOTO 9999
9500    PRINT *,'ERROR OPENING FILE',PSW2,'FOR WRITING'
        GOTO 9999
9600    PRINT *,'ERROR READING FILE',WPFNM2,'FOR WRITING'
        GOTO 9999
9700    PRINT *,'ERROR WRITING FILE',PSW2
9999    RETURN
      END
