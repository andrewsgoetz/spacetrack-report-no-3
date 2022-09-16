# spacetrack-report-no-3

This repository contains

- the paper "Spacetrack Report No. 3: Models for Propagation of NORAD Element Sets" by Hoots and Roehrich
- the Fortran IV code from the paper
- updated Fortran 77 code intended for compilers that are currently widely available.

## The Paper

Two versions of the paper are available.

- `Spacetrack_Report_No_3_original_scanned.pdf` - A scanned version of the original document.
- `Spacetrack_Report_No_3_Kelso_version.pdf` - A typset version of the paper compiled by T.S. Kelso.

If you're interested in reading the paper, I suggest using the Kelso version.

## The Original Fortran IV Code

The original code as it appears in the paper is in the `fortran_iv` directory. I was not able to find a compiler that successfully compiled the original code. The closest I came to compiling the code was with Intel's Fortran compiler `ifort` (version 2021.6.0).

    $ cd fortran_iv
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

## The Updated Fortran 77 CODE

Concluding that it was rather unlikely I would be able to find a compiler supporting the Honeywell Series 6000 dialect of Fortran IV, I decided to update the code for the Fortran 77 standard, which is the oldest version of Fortran still widely supported. The modified code is in the directory `fortran_77`. The updates are:

- Reordering the `COMMON/E1` blocks so that the double precision variables `EPOCH` and `DS50` are listed before the single precision variables.
- Replacing the `DECODE` statements in `DRIVER.f` with `READ` statements.
- Adding three parameters `T`, `SINIQ`, `COSIQ` to the `ENTRY DPPER` entrypoint in `DEEP.f`, and updating the `CALL DPPER` statements in `SDP4.f` and `SDP8.f` appropriately.
- Replacing `DABS(T)` by `ABS(T)` on line 307 of `DEEP.f`.
- Updating the declaration of `ABUF` on line 18 of `DRIVER.f`.

To see all the updates, simply do a diff between the `fortran_iv` and `fortran_77` directories.

    $ diff fortran_iv fortran_77
    diff fortran_iv/DEEP.f fortran_77/DEEP.f
    3,4c3,4
    <       COMMON/E1/XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    <      1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---
    >       COMMON/E1/EPOCH,DS50,XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    >      1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT
    307c307
    <   105 IF(DABS(T).GE.DABS(ATIME)) GO TO 120
    ---
    >   105 IF( ABS(T).GE.DABS(ATIME)) GO TO 120
    386c386
    <       ENTRY DPPER(EM,XINC,OMGASM,XNODES,XLL)
    ---
    >       ENTRY DPPER(EM,XINC,OMGASM,XNODES,XLL,T,SINIQ,COSIQ)
    diff fortran_iv/DRIVER.f fortran_77/DRIVER.f
    6,7c6,7
    <       COMMON/E1/XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,XNDD6O,BSTAR,
    <      1            X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---
    >       COMMON/E1/EPOCH,DS50,XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    >      1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT
    18c18
    <       CHARACTER ABUF*80(2)
    ---
    >       CHARACTER*80 ABUF(2)
    34c34
    <       DECODE(ABUF(1),707)  ITYPE
    ---
    >       READ  (ABUF(1),707)  ITYPE
    36c36
    <       DECODE (ABUF,702) EPOCH,XNDT2O,XNDD6O,IEXP,BSTAR,IBEXP,XINCL,
    ---
    >       READ   (ABUF,702) EPOCH,XNDT2O,XNDD6O,IEXP,BSTAR,IBEXP,XINCL,
    39c39
    <     5 DECODE(ABUF,701) EPOCH,XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    ---
    >     5 READ  (ABUF,701) EPOCH,XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    diff fortran_iv/SDP4.f fortran_77/SDP4.f
    3,4c3,4
    <       COMMON/E1/XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    <      1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---
    >       COMMON/E1/EPOCH,DS50,XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    >      1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT
    98c98
    <       CALL DPPER(E,XINC,OMGADF,XNODE,XMAM)
    ---
    >       CALL DPPER(E,XINC,OMGADF,XNODE,XMAM,TSINCE,SINIO,COSIO)
    diff fortran_iv/SDP8.f fortran_77/SDP8.f
    3,4c3,4
    <       COMMON/E1/XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    <      1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---
    >       COMMON/E1/EPOCH,DS50,XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    >      1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT
    97c97
    <       CALL DPPER(EM,XINC,OMGASM,XNODES,XMAM)
    ---
    >       CALL DPPER(EM,XINC,OMGASM,XNODES,XMAM,TSINCE,SINI,COSI)
    diff fortran_iv/SGP.f fortran_77/SGP.f
    3,4c3,4
    <       COMMON/E1/XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,XNDD6O,BSTAR,
    <      1         X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---
    >       COMMON/E1/EPOCH,DS50,XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    >      1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT
    diff fortran_iv/SGP4.f fortran_77/SGP4.f
    3,4c3,4
    <       COMMON/E1/XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    <      1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---
    >       COMMON/E1/EPOCH,DS50,XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    >      1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT
    diff fortran_iv/SGP8.f fortran_77/SGP8.f
    3,4c3,4
    <       COMMON/E1/XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    <      1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---
    >       COMMON/E1/EPOCH,DS50,XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    >      1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT
    diff fortran_iv/THETAG.f fortran_77/THETAG.f
    2,3c2,3
    <       COMMON /E1/XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,XNDD6O,BSTAR,
    <      1 X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
    ---
    >       COMMON/E1/EPOCH,DS50,XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
    >      1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT

I compiled the Fortran 77 code using the GNU Fortran compiler `gfortran`.

    $ cd fortran_77
    $ gfortran -o DRIVER -std=legacy -fno-automatic *.f

If the `-Wall` flag is included, the compiler generates warnings about unused labels, Hollerith constants, and conversions from `REAL(8)` to `REAL(4)`. I did not think it worthwhile to update the code further to remove these warnings. Note the `-fno-automatic` flag, which instructs the compiler to reserve memory for every local variable instead of using the stack.

To run `DRIVER` on the test cases provided in the paper:

    $ ./DRIVER < ../sample_test_cases/ALGORITHM.txt

where `ALGORITHM` is one of `sgp.txt`, `sgp4.txt`, `sgp8.txt`, `sdp4.txt`, and `sdp8.txt`. The results don't exactly match the paper's results, but I wouldn't expect them to.
