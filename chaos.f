        program caotico
c            include 'fgraph.fi'
c            include 'fgraph.fd'
c            record /videoconfig/ vc
c            record /xycoord/ xy
            integer*2 dummy,xt(4),yt(4),x0,y0,xmedio,ymedio
            integer IER,PGBEG
            data xt/320,590,50,320/
            data yt/5,450,450,5/
c
            print *, ' enter number off calls'
            read *,ncalls
c           call getvideoconfig (vc)
c            if(vc.adapter.eq.$vga) idummy=setvideomode($vres2color)
c
c
c            inizializza lo schermo grafico
c            call getvideoconfig (vc)
             IER = PGBEG(0,'/XWINDOW',1,1)
c
c
c             disegna il triangolo
c            call moveto(xt(1),yt(1),xy)
            do 10,i=2,4
             call pgdraw(xt(1),yt(1),xt(i),yt(i))
c            dummy=lineto(xt(i),yt(i))
10          continue
c
c
c
            x0=0
c           starting point
            y0=0
c           starting point
            CALL RANDOM_SEED()
            do 20,n=1,ncalls
                CALL RANDOM_NUMBER(ran)
                ip=3.*ran+1
                xmedio=(x0+xt(ip))/2.0
                ymedio=(y0+yt(ip))/2.0
c               call moveto(xmedio,ymedio,xy)
c               dummy=lineto(xmedio,ymedio)
                call pgdraw(xmedio,ymedio,xmedio,ymedio)
                x0=xmedio
                y0=ymedio
20          continue
            if (ncalls.gt.49999) then
c            call settextposition(2,2,xy)
c            call outtext(' The CAOS game')
c            call settextposition(3,2,xy)
c            call outtext(' Sierpinski gasket')
            else
c            call settextposition(2,2,xy)
c            call outtext(' End Iteration')
            endif
            print *,'enter a number'
            read (*,*) temp
c            idummy=setvideomode($defaultmode)
            CALL PGEND        
            stop
        end
