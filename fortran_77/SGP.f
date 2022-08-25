*      SGP                                             31 OCT 80
      SUBROUTINE SGP(IFLAG,TSINCE)
      COMMON/E1/EPOCH,DS50,XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
     1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT
      COMMON/C1/CK2,CK4,E6A,QOMS2T,S,TOTHRD,
     1        XJ3,XKE,XKMPER,XMNPDA,AE
      DOUBLE PRECISION EPOCH, DS50

      IF(IFLAG.EQ.0) GO TO 19

*      INITIALIZATION

      C1= CK2*1.5
      C2= CK2/4.0
      C3= CK2/2.0
      C4= XJ3*AE**3/(4.0*CK2)
      COSIO=COS(XINCL)
      SINIO=SIN(XINCL)
      A1=(XKE/XNO)**TOTHRD
      D1=     C1/A1/A1*(3.*COSIO*COSIO-1.)/(1.-EO*EO)**1.5
      AO=A1*(1.-1./3.*D1-D1*D1-134./81.*D1*D1*D1)
      PO=AO*(1.-EO*EO)
      QO=AO*(1.-EO)
      XLO=XMO+OMEGAO+XNODEO
      D1O= C3 *SINIO*SINIO
      D2O= C2 *(7.*COSIO*COSIO-1.)
      D3O=C1*COSIO
      D4O=D3O*SINIO
      PO2NO=XNO/(PO*PO)
      OMGDT=C1*PO2NO*(5.*COSIO*COSIO-1.)
      XNODOT=-2.*D3O*PO2NO
      C5=.5*C4*SINIO*(3.+5.*COSIO)/(1.+COSIO)
      C6=C4*SINIO
      IFLAG=0

*      UPDATE FOR SECULAR GRAVITY AND ATMOSPHERIC DRAG

   19 A=XNO+(2.*XNDT2O+3.*XNDD6O*TSINCE)*TSINCE
      A=AO*(XNO/A)**TOTHRD
      E=E6A
      IF(A.GT.QO) E=1.-QO/A
      P=A*(1.-E*E)
      XNODES= XNODEO+XNODOT*TSINCE
      OMGAS= OMEGAO+OMGDT*TSINCE
      XLS=FMOD2P(XLO+(XNO+OMGDT+XNODOT+(XNDT2O+XNDD6O*TSINCE)*
     1 TSINCE)*TSINCE)

*      LONG PERIOD PERIODICS

      AXNSL=E*COS(OMGAS)
      AYNSL=E*SIN(OMGAS)-C6/P
      XL=FMOD2P(XLS-C5/P*AXNSL)

*      SOLVE KEPLERS EQUATION

      U=FMOD2P(XL-XNODES)
      ITEM3=0
      EO1=U
      TEM5=1.
   20 SINEO1=SIN(EO1)
      COSEO1=COS(EO1)
      IF(ABS(TEM5).LT.E6A) GO TO 30
      IF(ITEM3.GE.10) GO TO 30
      ITEM3=ITEM3+1
      TEM5=1.-COSEO1*AXNSL-SINEO1*AYNSL
      TEM5=(U-AYNSL*COSEO1+AXNSL*SINEO1-EO1)/TEM5
      TEM2=ABS(TEM5)
      IF(TEM2.GT.1.) TEM5=TEM2/TEM5
      EO1=EO1+TEM5
      GO TO 20

*      SHORT PERIOD PRELIMINARY QUANTITIES

   30 ECOSE=AXNSL*COSEO1+AYNSL*SINEO1
      ESINE=AXNSL*SINEO1-AYNSL*COSEO1
      EL2=AXNSL*AXNSL+AYNSL*AYNSL
      PL=A*(1.-EL2)
      PL2=PL*PL
      R=A*(1.-ECOSE)
      RDOT=XKE*SQRT(A)/R*ESINE
      RVDOT=XKE*SQRT(PL)/R
      TEMP=ESINE/(1.+SQRT(1.-EL2))
      SINU=A/R*(SINEO1-AYNSL-AXNSL*TEMP)
      COSU=A/R*(COSEO1-AXNSL+AYNSL*TEMP)
      SU=ACTAN(SINU,COSU)

*      UPDATE FOR SHORT PERIODICS

      SIN2U=(COSU+COSU)*SINU
      COS2U=1.-2.*SINU*SINU
      RK=R+D1O/PL*COS2U
      UK=SU-D2O/PL2*SIN2U
      XNODEK=XNODES+D3O*SIN2U/PL2
      XINCK =XINCL+D4O/PL2*COS2U

*      ORIENTATION VECTORS

      SINUK=SIN(UK)
      COSUK=COS(UK)
      SINNOK=SIN(XNODEK)
      COSNOK=COS(XNODEK)
      SINIK=SIN(XINCK)
      COSIK=COS(XINCK)
      XMX=-SINNOK*COSIK
      XMY=COSNOK*COSIK
      UX=XMX*SINUK+COSNOK*COSUK
      UY=XMY*SINUK+SINNOK*COSUK
      UZ=SINIK*SINUK
      VX=XMX*COSUK-COSNOK*SINUK
      VY=XMY*COSUK-SINNOK*SINUK
      VZ=SINIK*COSUK

*      POSITION AND VELOCITY

      X=RK*UX
      Y=RK*UY
      Z=RK*UZ
      XDOT=RDOT*UX
      YDOT=RDOT*UY
      ZDOT=RDOT*UZ
      XDOT=RVDOT*VX+XDOT
      YDOT=RVDOT*VY+YDOT
      ZDOT=RVDOT*VZ+ZDOT

      RETURN
      END