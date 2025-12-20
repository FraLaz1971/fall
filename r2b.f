C Binary representation of a real number
c
         program chbf
c this program transforms the real number fnum in base 10
c in its rapresentation in base 2.
c
        implicit double precision (a-h,o-z)
        dimension ires(100),kres(100)
c
c input the number and set to zero's ires
        nba=2
100     continue
        print *,'Enter real number & enter , ctrl_d to exit'
        read (*,*,end=101) fnum
        n1=int(fnum)
        dec=fnum-float(n1)
c
c       zeros ires (integer part) kres (decimal part)
        do 10,n=1,100
          ires(n)=0
          kres(n)=0
10      continue
c
c change of base starts for the integer part
        do 15,n=1,100
            n2=n1/nba
            ires(n)=n1-n2*nba
            n1=n2
            if(n1.eq.0) goto 90
15      continue
90      continue
        ndint=n
c printing of the result for the real part only
        iaux=ndint/8
        if((8*iaux).lt.n)then
          nmax=8*(ndint/8+1)
        else
          nmax=iaux*8
        endif
        print *,' Integer part'
        print '(1x,4(8i1,1x))',(ires(n),n=nmax,1,-1)
        if(dec.eq.0.) goto 100
c
c change of base starts for the decimal part
        nbit=48
        x=dec
        do 20,n=1,nbit
            aux=0.5**n
            dif=x-aux
            if(dif.ge.0.) then
              kres(n)=1
              x=dif
            else
              kres(n)=0
            endif
20      continue
c
c Printing the resuls for the dec part
        print *,' Decimal part'
        print '(1x,6(8i1,1x))',(kres(n),n=1,nbit)
        goto 100
101     continue
        end
