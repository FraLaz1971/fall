      PROGRAM FORM1
        INTEGER MDIM,I
        PARAMETER(MDIM=512)
        CHARACTER*256 LINE(MDIM)
        CHARACTER*64 OFNAM
        LINE(1)='Il metodo usato per trasferire record a o da '
     &//'file e'' ' 
     &//'chiamato modalita'' di accesso'
        LINE(2)='A Graph Marker is a symbol, such as a cross,'
     &//' dot, or circle, drawn on a graph to mark a specific point.'
        LINE(3)='For example, for a seven-bit character, the '
     &//'internal representation of the first character is ''0000000'''
     &//' binary (0 decimal) and the last character is ''1111111''' 
     &//' binary (127 decimal).'
        DO 5,I=1,3
          LINE(I)(255:255)=CHAR(13)
          LINE(I)(256:256)=CHAR(10)
5      CONTINUE
        OFNAM='outfile001.dat'
        OPEN(11,FILE=OFNAM,FORM='UNFORMATTED',ACCESS='DIRECT',RECL=256,
     &ERR=8000)
        DO 10,I=1,3
          WRITE(11,REC=I,ERR=9000) LINE(I)
10      CONTINUE
        CLOSE(11)
        GOTO 9999
8000    PRINT *,'ERROR OPENING FILE ',OFNAM
        GOTO 9999
9000    PRINT *,'ERROR IN WRITING DATA ',LINE(I)
9999    STOP
      END
