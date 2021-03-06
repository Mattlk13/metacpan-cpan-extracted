! --------------------------------------------------------------------
! PROGRAM  MeanVariance:
!    This program reads in an array and computes the mean, variance
! and standard deviation of the data stored in the array.  Then, it
! displays an analysis table.  If a value is greater than the value
! of (mean + standard deviation), it displays a "good".  If a value
! is less than the value of (mean - standard deviation), it displays
! a "bad".
! --------------------------------------------------------------------

PROGRAM  MeanVariance
   IMPLICIT  NONE

   INTEGER, PARAMETER :: MAX_SIZE = 50       ! maximum array size
   REAL, DIMENSION(1:MAX_SIZE) :: Data       ! input array
   REAL               :: Mean, Variance, StdDev   ! results
   INTEGER            :: n                   ! actual array size
   INTEGER            :: i                   ! running index
   CHARACTER(LEN=40)  :: TitleHeading = '(1X, A//1X, A/1X, A)'
   CHARACTER(LEN=20)  :: For_Data     = '(I4, F7.2)'
   CHARACTER(LEN=50)  :: ResultFormat = '(/1X, A, F15.7/1X, A, F15.7/1X, A, F15.7/)'
   CHARACTER(LEN=20)  :: For_Analysis = '(I4, 2F7.2, A)'

   READ(*,*)  n                              ! read in input array
   READ(*,*)  (Data(i), i = 1, n)
   WRITE(*,TitleHeading)  "Input Data:", &
                          " No  Data",   &
                          "=== ======"
   WRITE(*,For_Data)   (i, Data(i), i = 1, n)

   Mean = 0.0                                ! compute mean
   DO i = 1, n
      Mean = Mean + Data(i)
   END DO
   Mean = Mean / n

   Variance = 0.0                            ! compute variance
   DO i = 1, n
      Variance = Variance + (Data(i) - Mean)**2
   END DO
   Variance = Variance / (n - 1)
   StdDev   = SQRT(Variance)                 ! compute standard deviation

   WRITE(*,ResultFormat)  "Mean               : ", Mean,      &
                          "Variance           : ", Variance,  &
                          "Standard Deviation : ", StdDev
   WRITE(*,TitleHeading)  "Analysis Table:",     &
                          " No  Data    Dev ",   &
                          "=== ======  ====="
   DO i = 1, n
      IF (Data(i) > Mean + StdDev) THEN
         WRITE(*,For_Analysis)  i, Data(i), Data(i) - Mean, " <-- Good"
      ELSE IF (Data(i) < Mean - StdDev) THEN
         WRITE(*,For_Analysis)  i, Data(i), Data(i) - Mean, " <-- Bad"
      ELSE
         WRITE(*,For_Analysis)  i, Data(i), Data(i) - Mean
      END IF
   END DO

END PROGRAM  MeanVariance
