      PROGRAM READFU
        implicit none
        real x,y
        integer n,npoint,I,IER,PGBEG
        dimension x(161),y(161)
        character*50 filename
100     continue
        print *,'Enter name of the file with the data'
        read(*,'(a)',err=100) filename
c
        open(unit=20,file=filename,status='old',err=100)
c
        do 10,n=1,1000
          read (20,*,end=110,err=120) x(n),y(n)
10      continue
110     close(20)
        npoint=n-1
        IER = PGBEG(0,'/CPS',1,1)
        IF (IER.NE.1) STOP
        CALL PGENV(-100.0,-92.0,-5.2,5.0,0,1)
        CALL PGLAB('(x)', '(y)', 'mydata.dat')
        CALL PGLINE(npoint,x,y)
        CALL PGEND        
        goto 9999
120     print *,'error in opening file ',filename
9999    stop
        end
    
