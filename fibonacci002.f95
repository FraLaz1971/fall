!Consider the Fibonacci series:
!1 1 2 3 5 8 13 …
!Each number in the series (except the first two, which are 1) is the sum from the two
!previous numbers. Write a program that reads in an integer limit, and which prints
!the first limit terms of the series. Use an nested if block structure. (You need to
!distinguish between several cases: limit < 0, limit =1, etc.)
PROGRAM FIB2
  IMPLICIT NONE
  INTEGER :: x,i,MAXDIM
  PARAMETER(MAXDIM=2048)
  INTEGER :: sx(0:MAXDIM),sy(0:MAXDIM),IER,PGBEG
  REAL :: rx(0:MAXDIM),ry(0:MAXDIM)
5 PRINT *,'ENTER A POSITIVE INTEGER'
  READ(*,*,ERR=9000) x
  IF (x.LT.0) goto 9050
  do i=0,x
    if(i.lt.2) then
      sy(i)=1
    else
      sy(i)=sy(i-2)+sy(i-1)
    end if
      sx(i)=i
      print *,sy(i)
      rx(i)=real(i)
      ry(i)=real(sy(i))
  end do
  IER=PGBEG(0,'/CPS',1,1)
  IF(IER.NE.1) GOTO 9100
  CALL PLOT(x,rx,ry)
  PRINT *,'The Fibonacci series for ',x,' is ',sy(x)
  goto 9999
9000 PRINT *,'ERROR IN INPUT OF THE NUMBER'  
  GOTO 5
9050 PRINT *,'ERROR, THE SERIES IS DEFINED ONLY FOR POSITIVE INTEGERS'
  goto 9999
9100    PRINT *,'ERROR IN BEGINNING PLOT'
9999 STOP
END PROGRAM FIB2

SUBROUTINE PLOT(x,rx,ry)
  INTEGER :: x,i,IER,PCBEG,MAXDIM
  PARAMETER(MAXDIM=2048)
  REAL,INTENT(OUT) :: rx(0:MAXDIM),ry(0:MAXDIM)
  CALL PGENV(0.0,real(x),1.0,ry(x),0,1)
  CALL PGLAB('(x)','(y)','fibonacci')
!  CALL PGPT(1,x,ry(x),9)
  CALL PGLINE(x+1,rx,ry)
  CALL PGEND
  GOTO 9999
9100    PRINT *,'ERROR IN BEGINNING PLOT'
9999 RETURN
END SUBROUTINE PLOT

FUNCTION fib(x)
  INTEGER,INTENT(IN) :: x
  INTEGER :: fib,i,sx(0:x),sy(0:x),IER,PCBEG
  REAL :: rx(0:x),ry(0:x)
  IF (x.LT.0) goto 9000
  do i=0,x
    if(i.lt.2) then
      sy(i)=1
    else
      sy(i)=sy(i-2)+sy(i-1)
    end if
      sx(i)=i
  end do
  rx=real(sx)
  ry=real(sy)
!  IER=PGBEG(0,'/CPS',1,1)
!  IF(IER.NE.1) GOTO 9100
!  CALL PGENV(0,x,1,sy(x),0,1)
!  CALL PGLAB('(x)','(y)','fibonacci')
!!  CALL PGPT(MDIM,x,y,9)
!  CALL PGLINE(x+1,rx,ry)
!  CALL PGEND
  fib=sy(x)
  goto 9999
9000 PRINT *,'ERROR, THE SERIES IS DEFINED ONLY FOR POSITIVE INTEGERS'
     fib=-1
  goto 9999
9100    PRINT *,'ERROR IN BEGINNING PLOT'
9999 RETURN
END
