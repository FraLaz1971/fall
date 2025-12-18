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
C NBH=NUMBER OF BASIC HOURS X EMPLOYEE
C ENAME=EMPLOYEE NAME (NAME, SURNAME IN A SINGLE STRING)
C STANUM=STAFF NUMBER
        INTEGER NBH(NEMPL),STANUM(NEMPL),WTWH(NEMPL),WTWM(NEMPL)
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
        DO 10,I=1,NEMPL
          PRINT *,STANUM(I),ENAME(I)(1:16)
10      CONTINUE
      END
