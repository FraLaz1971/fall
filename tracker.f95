SUBROUTINE TRACKER(INC)
    INTEGER INC,COUNT,TOTAL
    SAVE COUNT
    DATA COUNT /0/  ! Initialize count to 0 only once at start
    ! Entry 1: Increment and show
    COUNT = COUNT + INC
    PRINT *, "Current Total: ", COUNT
    RETURN

ENTRY GET_TOTAL(TOTAL)
    ! Entry 2: Just return the current state without changing it
    TOTAL = COUNT
    RETURN

ENTRY RESET_TRACKER()
    ! Entry 3: Reset the shared state
    COUNT = 0
    PRINT *, "Tracker reset to zero."
    RETURN
END SUBROUTINE

PROGRAM USETRK
 IMPLICIT NONE
 INTEGER I,TOTAL
 DO I=1,10
   CALL TRACKER(2)
 END DO
 CALL GET_TOTAL(TOTAL)
 PRINT *,'TOTAL COUNTS',TOTAL
 CALL RESET_TRACKER
 PRINT *,'JUST RESET THE TRACKER'
 CALL GET_TOTAL(TOTAL)
 PRINT *,'NOW TOTAL COUNTS',TOTAL
END PROGRAM
