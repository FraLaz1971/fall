# fall
all kind of fortran examples
###
append.f
###
common.f
###
endf2unf.f
###
endfile.f
###
files.f
###
files.f is a program based on the example 12.3 of Ellis,1982 (PAYROL)
Employees of a certain organization have their weekly pay this way:
- (a) GROSS PAY: N hours * basic rate +  M plus subsequent hours * higher rate
For each employee, the 2 rates and n. of basic hours are fixed
- (b) Tax is a fixed percentage of the (GROSS PAY - tax_free_allowance)
- (c) Health insurance is a fixed percentage of that part of the gross pay
wich falls below a fixed limit
- (d) The nett pay is the GROSS PAY less tax and health insurance deduction
A file is kept which contains details of all weekly paid employees in increasing
order of their staff number.
Each week another file of data is prepared containing, for each employee, their
staff number, the hours worked in hours and minutes during the previous week.
This data file is sorted into increasing order of staff numbers before input to the
rest of the program.
The file 2025-12-15_data.dat contains the data on what worked for each employee in the
week between monday 8/12 and friday 12/12 2025
The file 2025-12-08_data.dat contains the data on what worked for each employee in the
week between monday 1/12 and friday 5/12 2025
write a program to update the master file and to produce weekly payslips showing
staff_number, name , gross_pay, deductions, nett_pay
###
this is the schema of the program
1. Open old and new files
2. Read fixed rates, ... etc
3. Repeat the following until the end of the master file
-  3.1 Read next employee record
-  3.2 Read next data record
-  3.3 If they match then:
-      3.3.1  Calculate gross weekly pay
-      3.3.2  Calculate deductions
-      3.3.3  Calculate nett pay
-      3.3.4  Write updated record to new file
-      3.3.5  Print payslip
-      otherwise
-      3.3.6  Print warning message
-      3.3.7  Update tax details
-      3.3.8  Write updated record to new file
-      3.3.9  Print payslip
-      3.3.10 'Backspace' file of data records
###
iostat.f
###
limits.f
###
openfile.f
###
readunf1.f
###
