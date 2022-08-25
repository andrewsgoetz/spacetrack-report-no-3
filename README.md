# spacetrack-report-no-3

This repository contains the code from the paper "Spacetrack Report No. 3: Models for Propagation of NORAD Element Sets" by Hoots and Roehrich, as well as modified versions of that code intended for compilers that are currently widely available.

## The Original Code

The original code as it appears in the paper is in the `fortran_iv` directory. I was not able to find a compiler that successfully compiled the original code. (However, I didn't try terribly hard.) The closest I came to compiling the code was with Intel's Fortran compiler `ifort` (version 2021.6.0).

    $ ifort -f66 *.f
    DEEP.f(307): warning #7319: This argument's data type is incompatible with this intrinsic procedure; procedure assumed EXTERNAL.   [DABS]
      105 IF(DABS(T).GE.DABS(ATIME)) GO TO 120
    --------------^
    DEEP.f(4): remark #6375: Because of COMMON, the alignment of object is inconsistent with its type - potential performance impact.   [EPOCH]
         1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---------------------------------------------------^
    DEEP.f(4): remark #6375: Because of COMMON, the alignment of object is inconsistent with its type - potential performance impact.   [DS50]
         1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---------------------------------------------------------^
    DRIVER.f(34): error #6059: A REAL or INTEGER or LOGICAL data type is required in this context.   [ABUF]
          DECODE(ABUF(1),707)  ITYPE
    -------------^
    DRIVER.f(34): error #6741: This statement is invalid.
          DECODE(ABUF(1),707)  ITYPE
    ^
    DRIVER.f(36): error #6059: A REAL or INTEGER or LOGICAL data type is required in this context.   [ABUF]
          DECODE (ABUF,702) EPOCH,XNDT2O,XNDD6O,IEXP,BSTAR,IBEXP,XINCL,
    --------------^
    DRIVER.f(36): error #6741: This statement is invalid.
          DECODE (ABUF,702) EPOCH,XNDT2O,XNDD6O,IEXP,BSTAR,IBEXP,XINCL,
    ^
    DRIVER.f(39): error #6059: A REAL or INTEGER or LOGICAL data type is required in this context.   [ABUF]
        5 DECODE(ABUF,701) EPOCH,XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    -------------^
    DRIVER.f(39): error #6741: This statement is invalid.
        5 DECODE(ABUF,701) EPOCH,XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    ^
    DRIVER.f(95): remark #8291: Recommended relationship between field width 'W' and the number of fractional digits 'D' in this edit descriptor is 'W>=D+7'.
      702 FORMAT(18X,D14.8,1X,F10.8,2(1X,F6.5,I2),/,7X,2(1X,F8.4),1X,
    ------------------^
    DRIVER.f(93): remark #8291: Recommended relationship between field width 'W' and the number of fractional digits 'D' in this edit descriptor is 'W>=D+7'.
      701 FORMAT(29X,D14.8,1X,3F8.4,/,6X,F8.7,F8.4,1X,2F11.9,1X,F6.5,I2,
    ------------------^
    compilation aborted for DRIVER.f (code 1)
    SDP4.f(4): remark #6375: Because of COMMON, the alignment of object is inconsistent with its type - potential performance impact.   [EPOCH]
         1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---------------------------------------------------^
    SDP4.f(4): remark #6375: Because of COMMON, the alignment of object is inconsistent with its type - potential performance impact.   [DS50]
         1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---------------------------------------------------------^
    SDP8.f(4): remark #6375: Because of COMMON, the alignment of object is inconsistent with its type - potential performance impact.   [EPOCH]
         1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---------------------------------------------------^
    SDP8.f(4): remark #6375: Because of COMMON, the alignment of object is inconsistent with its type - potential performance impact.   [DS50]
         1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---------------------------------------------------------^
    SGP4.f(4): remark #6375: Because of COMMON, the alignment of object is inconsistent with its type - potential performance impact.   [EPOCH]
         1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---------------------------------------------------^
    SGP4.f(4): remark #6375: Because of COMMON, the alignment of object is inconsistent with its type - potential performance impact.   [DS50]
         1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---------------------------------------------------------^
    SGP8.f(4): remark #6375: Because of COMMON, the alignment of object is inconsistent with its type - potential performance impact.   [EPOCH]
         1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---------------------------------------------------^
    SGP8.f(4): remark #6375: Because of COMMON, the alignment of object is inconsistent with its type - potential performance impact.   [DS50]
         1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---------------------------------------------------------^
    SGP.f(4): remark #6375: Because of COMMON, the alignment of object is inconsistent with its type - potential performance impact.   [EPOCH]
         1         X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ------------------------------------^
    SGP.f(4): remark #6375: Because of COMMON, the alignment of object is inconsistent with its type - potential performance impact.   [DS50]
         1         X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ------------------------------------------^
    THETAG.f(3): remark #6375: Because of COMMON, the alignment of object is inconsistent with its type - potential performance impact.   [EPOCH]
         1 X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ----------------------------^
    THETAG.f(3): remark #6375: Because of COMMON, the alignment of object is inconsistent with its type - potential performance impact.   [DS50]
         1 X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ----------------------------------^

There are several failures and even more warnings. I was curious about the failures concerning the `DECODE` statements. The paper states that the code is written in FORTRAN IV and implemented on a Honeywell-6000 series computer. After some searching, I was able to find an old document "Handbook for Conversion of IBM 360 Application Programs to the Honeywell Series 6000" published by the Defense Communications Agency. On page 54 one finds

    3.3.3 H-6000 Only Feature.  The 6000 FORTRAN encode-decode
    feature is a H-6000 only feature.  It allows internal conversion
    from a data format to a character (BCD) format, and vice versa.
    For example, to convert a floating point value currently stored
    in Y to its character equivaalent, and to store that character
    string in X, the ENCODE statement would be used as follows:

                            ENCODE (X,3)Y
    
                        3   FORMAT (F8.2)
    
    where FORMAT statement number 3 is the statement describing the
    format of the floating point variable Y.
    
          Similarly, to convert a character representation of vari-
    able K to its integer equivalent, and store the resultant integer
    in J, the DECODE statement would be used as follows:
    
                            DECODE (K,4)J
    
                        4   FORMAT (I2)
    
    where FORMAT statement number 4 is the statement describing the
    format of the newly created integer variable J.

Concluding that it was rather unlikely I would be able to find a compiler supporting the Honeywell Series 6000 dialect of Fortran IV, I decided to update the code for the Fortran 77 standard, which is the oldest version of Fortran still widely supported. The modified code is in the directory `fortran_77`. To see the modifications that I made, simply do a diff between the `fortran_iv` and `fortran_77` directories. I compiled the Fortran 77 code using the GNU Fortran compiler `gfortran`.

    gfortran -o DRIVER -std=legacy *.f

To run `DRIVER`
