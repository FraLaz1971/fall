c this program implements the Euclid algorithm to calculate the Greatest Common Factor (GCF)
c between two integer number (m,n).
c
      program euclid 
        implicit none
        integer n,m,r
c n,m are the input, r is the rest
        print *,'write 2 integer numbers n,m'
        read *,n,m
        if(m.eq.n) stop 'm=n'        
10          r=n-(n/m)*m
            if(r.eq.0)then
                print '(a,1i5)','Greatest Common Factor (GCF) ', m
                goto 101
            else
                n=m
                m=r
            endif
            goto 10
101     continue
        stop
      end
c
c
c E' piu' conveniente richiamare la funzione del Fortran
c MOD(n,m)=n-(n/m)*m
