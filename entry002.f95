SUBROUTINE CALCULATE(A, B)
    INTEGER A, B, SAVED_VAL
!    SAVE SAVED_VAL
    
    ! Main entry point
    SAVED_VAL = A + B
    PRINT *, "Main sum: ", SAVED_VAL
    RETURN

    ENTRY RESET_VAL(NEW_VAL)
    ! Alternative entry point
    SAVED_VAL = NEW_VAL
    PRINT *, "Value reset to: ", SAVED_VAL
    RETURN
END SUBROUTINE

PROGRAM USE_ENTRY
  CALL CALCULATE(10, 5)     ! Outputs: Main sum: 15
  CALL RESET_VAL(100)       ! Outputs: Value reset to: 100
END PROGRAM
