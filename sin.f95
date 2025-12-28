program msin
  implicit none
  character*80 ofnam
  integer i,msize
  parameter(msize=1024)
  real :: x(msize),y(msize),pi,step
  parameter(pi=3.1459)
  ofnam='sin.log'
  open(11,file=ofnam,err=9000)
  write(11,*)'size(x)=',size(x)
  write(11,*)'size(y)=',size(y)
  write(11,*)'lower bound(x,1)=',lbound(x,1)
  write(11,*)'upper bound(x,1)=',ubound(x,1)
  step=2.0*pi/1024.0
  do i=1,msize
    x(i)=-1*pi+(i-1)*step
  end do
  y=sin(x)
  do i=1,msize
    print 100,x(i),y(i)
  end do
  close(11)
  goto 9999
100 format(f9.3,1x,f9.3)
9000 print *,'error in opening file ',ofnam
9999 stop
end program msin
