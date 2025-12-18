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
order of their staff number
Each week a file of data is prepared containing, for each employee, their
staff number, the hours worked in hours and minutes during the previous week
This data is sorted into increasing order of staff numbers before input to the
rest of the program.
write a program to update the master file and to produce weekly payslips showing
staff_number, surname,  name , gross_pay, deductions, nett_pay

###
iostat.f
###
limits.f
###
openfile.f
###
readunf1.f
###
