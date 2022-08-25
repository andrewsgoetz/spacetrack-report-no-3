*      SDP4                                               3 NOV 80
      SUBROUTINE SDP4(IFLAG,TSINCE)
      COMMON/E1/EPOCH,DS50,XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
     1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT
      COMMON/C1/CK2,CK4,E6A,QOMS2T,S,TOTHRD,
     1           XJ3,XKE,XKMPER,XMNPDA,AE
      DOUBLE PRECISION EPOCH, DS50

      IF  (IFLAG .EQ. 0) GO TO 100

*      RECOVER ORIGINAL MEAN MOTION (XNODP) AND SEMIMAJOR AXIS (AODP)
*      FROM INPUT ELEMENTS

      A1=(XKE/XNO)**TOTHRD
      COSIO=COS(XINCL)
      THETA2=COSIO*COSIO
      X3THM1=3.*THETA2-1.
      EOSQ=EO*EO
      BETAO2=1.-EOSQ
      BETAO=SQRT(BETAO2)
      DEL1=1.5*CK2*X3THM1/(A1*A1*BETAO*BETAO2)
      AO=A1*(1.-DEL1*(.5*TOTHRD+DEL1*(1.+134./81.*DEL1)))
      DELO=1.5*CK2*X3THM1/(AO*AO*BETAO*BETAO2)
      XNODP=XNO/(1.+DELO)
      AODP=AO/(1.-DELO)

*      INITIALIZATION

*      FOR PERIGEE BELOW 156 KM, THE VALUES OF
*      S AND QOMS2T ARE ALTERED

      S4=S
      QOMS24=QOMS2T
      PERIGE=(AODP*(1.-EO)-AE)*XKMPER
      IF(PERIGE .GE. 156.) GO TO 10
      S4=PERIGE-78.
      IF(PERIGE .GT. 98.) GO TO 9
      S4=20.
    9 QOMS24=((120.-S4)*AE/XKMPER)**4
      S4=S4/XKMPER+AE
   10 PINVSQ=1./(AODP*AODP*BETAO2*BETAO2)
      SING=SIN(OMEGAO)
      COSG=COS(OMEGAO)
      TSI=1./(AODP-S4)
      ETA=AODP*EO*TSI
      ETASQ=ETA*ETA
      EETA=EO*ETA
      PSISQ=ABS(1.-ETASQ)
      COEF=QOMS24*TSI**4
      COEF1=COEF/PSISQ**3.5
      C2=COEF1*XNODP*(AODP*(1.+1.5*ETASQ+EETA*(4.+ETASQ))+.75*
     1         CK2*TSI/PSISQ*X3THM1*(8.+3.*ETASQ*(8.+ETASQ)))
      C1=BSTAR*C2
      SINIO=SIN(XINCL)
      A3OVK2=-XJ3/CK2*AE**3
      X1MTH2=1.-THETA2
      C4=2.*XNODP*COEF1*AODP*BETAO2*(ETA*
     1         (2.+.5*ETASQ)+EO*(.5+2.*ETASQ)-2.*CK2*TSI/
     2         (AODP*PSISQ)*(-3.*X3THM1*(1.-2.*EETA+ETASQ*
     3         (1.5-.5*EETA))+.75*X1MTH2*(2.*ETASQ-EETA*
     4         (1.+ETASQ))*COS(2.*OMEGAO)))
      THETA4=THETA2*THETA2
      TEMP1=3.*CK2*PINVSQ*XNODP
      TEMP2=TEMP1*CK2*PINVSQ
      TEMP3=1.25*CK4*PINVSQ*PINVSQ*XNODP
      XMDOT=XNODP+.5*TEMP1*BETAO*X3THM1+.0625*TEMP2*BETAO*
     1         (13.-78.*THETA2+137.*THETA4)
      X1M5TH=1.-5.*THETA2
      OMGDOT=-.5*TEMP1*X1M5TH+.0625*TEMP2*(7.-114.*THETA2+
     1         395.*THETA4)+TEMP3*(3.-36.*THETA2+49.*THETA4)
      XHDOT1=-TEMP1*COSIO
      XNODOT=XHDOT1+(.5*TEMP2*(4.-19.*THETA2)+2.*TEMP3*(3.-
     1         7.*THETA2))*COSIO
      XNODCF=3.5*BETAO2*XHDOT1*C1
      T2COF=1.5*C1
      XLCOF=.125*A3OVK2*SINIO*(3.+5.*COSIO)/(1.+COSIO)
      AYCOF=.25*A3OVK2*SINIO
      X7THM1=7.*THETA2-1.
   90 IFLAG=0
      CALL DPINIT(EOSQ,SINIO,COSIO,BETAO,AODP,THETA2,
     1         SING,COSG,BETAO2,XMDOT,OMGDOT,XNODOT,XNODP)

* UPDATE FOR SECULAR GRAVITY AND ATMOSPHERIC DRAG

  100 XMDF=XMO+XMDOT*TSINCE
      OMGADF=OMEGAO+OMGDOT*TSINCE
      XNODDF=XNODEO+XNODOT*TSINCE
      TSQ=TSINCE*TSINCE
      XNODE=XNODDF+XNODCF*TSQ
      TEMPA=1.-C1*TSINCE
      TEMPE=BSTAR*C4*TSINCE
      TEMPL=T2COF*TSQ
      XN=XNODP
      CALL DPSEC(XMDF,OMGADF,XNODE,EM,XINC,XN,TSINCE)
      A=(XKE/XN)**TOTHRD*TEMPA**2
      E=EM-TEMPE
      XMAM=XMDF+XNODP*TEMPL
      CALL DPPER(E,XINC,OMGADF,XNODE,XMAM,TSINCE,SINIO,COSIO)
      XL=XMAM+OMGADF+XNODE
      BETA=SQRT(1.-E*E)
      XN=XKE/A**1.5

* LONG PERIOD PERIODICS

      AXN=E*COS(OMGADF)
      TEMP=1./(A*BETA*BETA)
      XLL=TEMP*XLCOF*AXN
      AYNL=TEMP*AYCOF
      XLT=XL+XLL
      AYN=E*SIN(OMGADF)+AYNL

* SOLVE KEPLERS EQUATION

      CAPU=FMOD2P(XLT-XNODE)
      TEMP2=CAPU
      DO 130 I=1,10
      SINEPW=SIN(TEMP2)
      COSEPW=COS(TEMP2)
      TEMP3=AXN*SINEPW
      TEMP4=AYN*COSEPW
      TEMP5=AXN*COSEPW
      TEMP6=AYN*SINEPW
      EPW=(CAPU-TEMP4+TEMP3-TEMP2)/(1.-TEMP5-TEMP6)+TEMP2
      IF(ABS(EPW-TEMP2) .LE. E6A) GO TO 140
  130 TEMP2=EPW

* SHORT PERIOD PRELIMINARY QUANTITIES

  140 ECOSE=TEMP5+TEMP6
      ESINE=TEMP3-TEMP4
      ELSQ=AXN*AXN+AYN*AYN
      TEMP=1.-ELSQ
      PL=A*TEMP
      R=A*(1.-ECOSE)
      TEMP1=1./R
      RDOT=XKE*SQRT(A)*ESINE*TEMP1
      RFDOT=XKE*SQRT(PL)*TEMP1
      TEMP2=A*TEMP1
      BETAL=SQRT(TEMP)
      TEMP3=1./(1.+BETAL)
      COSU=TEMP2*(COSEPW-AXN+AYN*ESINE*TEMP3)
      SINU=TEMP2*(SINEPW-AYN-AXN*ESINE*TEMP3)
      U=ACTAN(SINU,COSU)
      SIN2U=2.*SINU*COSU
      COS2U=2.*COSU*COSU-1.
      TEMP=1./PL
      TEMP1=CK2*TEMP
      TEMP2=TEMP1*TEMP

* UPDATE FOR SHORT PERIODICS

      RK=R*(1.-1.5*TEMP2*BETAL*X3THM1)+.5*TEMP1*X1MTH2*COS2U
      UK=U-.25*TEMP2*X7THM1*SIN2U
      XNODEK=XNODE+1.5*TEMP2*COSIO*SIN2U
      XINCK=XINC+1.5*TEMP2*COSIO*SINIO*COS2U
      RDOTK=RDOT-XN*TEMP1*X1MTH2*SIN2U
      RFDOTK=RFDOT+XN*TEMP1*(X1MTH2*COS2U+1.5*X3THM1)

* ORIENTATION VECTORS

      SINUK=SIN(UK)
      COSUK=COS(UK)
      SINIK=SIN(XINCK)
      COSIK=COS(XINCK)
      SINNOK=SIN(XNODEK)
      COSNOK=COS(XNODEK)
      XMX=-SINNOK*COSIK
      XMY=COSNOK*COSIK
      UX=XMX*SINUK+COSNOK*COSUK
      UY=XMY*SINUK+SINNOK*COSUK
      UZ=SINIK*SINUK
      VX=XMX*COSUK-COSNOK*SINUK
      VY=XMY*COSUK-SINNOK*SINUK
      VZ=SINIK*COSUK

* POSITION AND VELOCITY

      X=RK*UX
      Y=RK*UY
      Z=RK*UZ
      XDOT=RDOTK*UX+RFDOTK*VX
      YDOT=RDOTK*UY+RFDOTK*VY
      ZDOT=RDOTK*UZ+RFDOTK*VZ

      RETURN
      END
