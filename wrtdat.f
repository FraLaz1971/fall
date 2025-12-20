        SUBROUTINE scrividati(ave,sdev )
            implicit none
            LOGICAL EXST
            integer iunit, iunit2,icasi
            real spessore_par,ave,sdev,zz,xx,yy
            iunit = 12
            iunit2 = 13
            OPEN (iunit2,file='spessore.dat ',status='old')
            read (iunit2 , 101) spessore_par,icasi
100         format (f10.4,f10.4,f10.4)
101         format (f10.4,i2)
            INQUIRE(FILE='risultati.dat',EXIST=EXST )
            IF (EXST) THEN
              OPEN(iunit ,file='risultati.dat',status='old')
120           read (iunit ,100,end=130 )zz, xx ,yy
              go to 120
130           continue
              backspace iunit
              write(iunit,100) spessore_par,ave,sdev
              endfile iunit
              close (iunit)
              close (iunit2)
            ELSE
              OPEN(iunit,file='risultati.dat',status='new')
              write (iunit , 100)spessore_par, ave, sdev
              endfile iunit
              close (iunit)
              close (iunit2)
            END IF
            return
        END
        
       program wrtdat
         implicit none
         real ave,sdev
         data ave/33.12/,sdev/-100.06/
         call scrividati(ave,sdev)
         stop
       end
