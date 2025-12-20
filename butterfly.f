        program btfly
            implicit double precision(a-h,q-z)
            integer n,npoint,I,IER,PGBEG
            print *, ' enter number of point, number of turns'
            read *, npoint, nturn
            pi=2.0*acos(0.0)
            dth=2.0*pi*dfloat(nturn)/dfloat(npoint)
            IER = PGBEG(0,'/CPS',1,1)
            IF (IER.NE.1) STOP
            th0=0.0
            CALL PGSWIN(-10.0,-1.0,10.0,1.0) 
            do 10,i=0,npoint-1
                th=th0+dth*dfloat(i)
                r=exp(cos(th))-2.0*cos(4.0*th)+sin(th/12.0)**5
                x1=r*cos(th+pi/2.0)
                y1=r*sin(th+pi/2.0)
c
                th=th0+dth*float(i+1)
                r=exp(cos(th))-2.0*cos(4.0*th)+sin(th/12.0)**5
                x2=r*cos(th+pi/2.0)
                y2=r*sin(th+pi/2.0)    
                call pgdraw(x1,y1,x2,y2)
10              continue
c             si puo' fare di meglio provateci
            CALL pgend        
c
            stop
        end
        
