C program that reads in a time in seconds, and computes how many hours and
C minutes it contains. Thus, 3700 should yield: 1 hour, 1 minute, and 40 seconds.
C (Hint: use the mod function).
      PROGRAM time1
        IMPLICIT NONE
        INTEGER totsec,hour,mmin,sec,rest
        PRINT *,'Enter the number of seconds'
        READ *,totsec
        hour=totsec/3600
        rest=totsec-hour*3600
        mmin=rest/60
        sec=rest-mmin*60
        PRINT*,totsec,' seconds yeld to ',hour,' hours, ',mmin,' minutes
     & and ',sec,' seconds'
        STOP
      END
