*      SDP8                                              14 NOV 80
      SUBROUTINE SDP8(IFLAG,TSINCE)
      COMMON/E1/EPOCH,DS50,XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
     1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT
      COMMON/C1/CK2,CK4,E6A,QOMS2T,S,TOTHRD,
     1           XJ3,XKE,XKMPER,XMNPDA,AE
      DOUBLE PRECISION EPOCH, DS50
      DATA RHO/.15696615/

      IF (IFLAG .EQ. 0) GO TO 100

*      RECOVER ORIGINAL MEAN MOTION (XNODP) AND SEMIMAJOR AXIS (AODP)
*      FROM INPUT ELEMENTS --------- CALCULATE BALLISTIC COEFFICIENT
*      (B TERM) FROM INPUT B* DRAG TERM

      A1=(XKE/XNO)**TOTHRD
      COSI=COS(XINCL)
      THETA2=COSI*COSI
      TTHMUN=3.*THETA2-1.
      EOSQ=EO*EO
      BETAO2=1.-EOSQ
      BETAO=SQRT(BETAO2)
      DEL1=1.5*CK2*TTHMUN/(A1*A1*BETAO*BETAO2)
      AO=A1*(1.-DEL1*(.5*TOTHRD+DEL1*(1.+134./81.*DEL1)))
      DELO=1.5*CK2*TTHMUN/(AO*AO*BETAO*BETAO2)
      AODP=AO/(1.-DELO)
      XNODP=XNO/(1.+DELO)
      B=2.*BSTAR/RHO

*      INITIALIZATION

      PO=AODP*BETAO2
      POM2=1./(PO*PO)
      SINI=SIN(XINCL)
      SING=SIN(OMEGAO)
      COSG=COS(OMEGAO)
      TEMP=.5*XINCL
      SINIO2=SIN(TEMP)
      COSIO2=COS(TEMP)
      THETA4=THETA2**2
      UNM5TH=1.-5.*THETA2
      UNMTH2=1.-THETA2
      A3COF=-XJ3/CK2*AE**3
      PARDT1=3.*CK2*POM2*XNODP
      PARDT2=PARDT1*CK2*POM2
      PARDT4=1.25*CK4*POM2*POM2*XNODP
      XMDT1=.5*PARDT1*BETAO*TTHMUN
      XGDT1=-.5*PARDT1*UNM5TH
      XHDT1=-PARDT1*COSI
      XLLDOT=XNODP+XMDT1+
     2           .0625*PARDT2*BETAO*(13.-78.*THETA2+137.*THETA4)
      OMGDT=XGDT1+
     1      .0625*PARDT2*(7.-114.*THETA2+395.*THETA4)+PARDT4*(3.-36.*
     2         THETA2+49.*THETA4)
      XNODOT=XHDT1+
     1       (.5*PARDT2*(4.-19.*THETA2)+2.*PARDT4*(3.-7.*THETA2))*COSI
      TSI=1./(PO-S)
      ETA=EO*S*TSI
      ETA2=ETA**2
      PSIM2=ABS(1./(1.-ETA2))
      ALPHA2=1.+EOSQ
      EETA=EO*ETA
      COS2G=2.*COSG**2-1.
      D5=TSI*PSIM2
      D1=D5/PO
      D2=12.+ETA2*(36.+4.5*ETA2)
      D3=ETA2*(15.+2.5*ETA2)
      D4=ETA*(5.+3.75*ETA2)
      B1=CK2*TTHMUN
      B2=-CK2*UNMTH2
      B3=A3COF*SINI
      C0=.5*B*RHO*QOMS2T*XNODP*AODP*TSI**4*PSIM2**3.5/SQRT(ALPHA2)
      C1=1.5*XNODP*ALPHA2**2*C0
      C4=D1*D3*B2
      C5=D5*D4*B3
      XNDT=C1*(
     1  (2.+ETA2*(3.+34.*EOSQ)+5.*EETA*(4.+ETA2)+8.5*EOSQ)+
     1  D1*D2*B1+ C4*COS2G+C5*SING)
      XNDTN=XNDT/XNODP
      EDOT=-TOTHRD*XNDTN*(1.-EO)
      IFLAG=0
      CALL DPINIT(EOSQ,SINI,COSI,BETAO,AODP,THETA2,SING,COSG,
     1          BETAO2,XLLDOT,OMGDT,XNODOT,XNODP)

* UPDATE FOR SECULAR GRAVITY AND ATMOSPHERIC DRAG

  100 Z1=.5*XNDT*TSINCE*TSINCE
      Z7=3.5*TOTHRD*Z1/XNODP
      XMAMDF=XMO+XLLDOT*TSINCE
      OMGASM=OMEGAO+OMGDT*TSINCE+Z7*XGDT1
      XNODES=XNODEO+XNODOT*TSINCE+Z7*XHDT1
      XN=XNODP
      CALL DPSEC(XMAMDF,OMGASM,XNODES,EM,XINC,XN,TSINCE)
      XN=XN+XNDT*TSINCE
      EM=EM+EDOT*TSINCE
      XMAM=XMAMDF+Z1+Z7*XMDT1
      CALL DPPER(EM,XINC,OMGASM,XNODES,XMAM,TSINCE,SINI,COSI)
      XMAM=FMOD2P(XMAM)

*      SOLVE KEPLERS EQUATION

      ZC2=XMAM+EM*SIN(XMAM)*(1.+EM*COS(XMAM))
      DO 130 I=1,10
      SINE=SIN(ZC2)
      COSE=COS(ZC2)
      ZC5=1./(1.-EM*COSE)
      CAPE=(XMAM+EM*SINE-ZC2)*
     1   ZC5+ZC2
      IF(ABS(CAPE-ZC2) .LE. E6A) GO TO 140
  130 ZC2=CAPE

*      SHORT PERIOD PRELIMINARY QUANTITIES

  140 AM=(XKE/XN)**TOTHRD
      BETA2M=1.-EM*EM
      SINOS=SIN(OMGASM)
      COSOS=COS(OMGASM)
      AXNM=EM*COSOS
      AYNM=EM*SINOS
      PM=AM*BETA2M
      G1=1./PM
      G2=.5*CK2*G1
      G3=G2*G1
      BETA=SQRT(BETA2M)
      G4=.25*A3COF*SINI
      G5=.25*A3COF*G1
      SNF=BETA*SINE*ZC5
      CSF=(COSE-EM)*ZC5
      FM=ACTAN(SNF,CSF)
      SNFG=SNF*COSOS+CSF*SINOS
      CSFG=CSF*COSOS-SNF*SINOS
      SN2F2G=2.*SNFG*CSFG
      CS2F2G=2.*CSFG**2-1.
      ECOSF=EM*CSF
      G10=FM-XMAM+EM*SNF
      RM=PM/(1.+ECOSF)
      AOVR=AM/RM
      G13=XN*AOVR
      G14=-G13*AOVR
      DR=G2*(UNMTH2*CS2F2G-3.*TTHMUN)-G4*SNFG
      DIWC=3.*G3*SINI*CS2F2G-G5*AYNM
      DI=DIWC*COSI
      SINI2=SIN(.5*XINC)

*      UPDATE FOR SHORT PERIOD PERIODICS

      SNI2DU=SINIO2*(
     1   G3*(.5*(1.-7.*THETA2)*SN2F2G-3.*UNM5TH*G10)-G5*SINI*CSFG*(2.+
     2         ECOSF))-.5*G5*THETA2*AXNM/COSIO2
      XLAMB=FM+OMGASM+XNODES+G3*(.5*(1.+6.*COSI-7.*THETA2)*SN2F2G-3.*
     1      (UNM5TH+2.*COSI)*G10)+G5*SINI*(COSI*AXNM/(1.+COSI)-(2.
     2      +ECOSF)*CSFG)
      Y4=SINI2*SNFG+CSFG*SNI2DU+.5*SNFG*COSIO2*DI
      Y5=SINI2*CSFG-SNFG*SNI2DU+.5*CSFG*COSIO2*DI
      R=RM+DR
      RDOT=XN*AM*EM*SNF/BETA+G14*(2.*G2*UNMTH2*SN2F2G+G4*CSFG)
      RVDOT=XN*AM**2*BETA/RM+
     1      G14*DR+AM*G13*SINI*DIWC

*      ORIENTATION VECTORS

      SNLAMB=SIN(XLAMB)
      CSLAMB=COS(XLAMB)
      TEMP=2.*(Y5*SNLAMB-Y4*CSLAMB)
      UX=Y4*TEMP+CSLAMB
      VX=Y5*TEMP-SNLAMB
      TEMP=2.*(Y5*CSLAMB+Y4*SNLAMB)
      UY=-Y4*TEMP+SNLAMB
      VY=-Y5*TEMP+CSLAMB
      TEMP=2.*SQRT(1.-Y4*Y4-Y5*Y5)
      UZ=Y4*TEMP
      VZ=Y5*TEMP

*      POSITION AND VELOCITY

      X=R*UX
      Y=R*UY
      Z=R*UZ
      XDOT=RDOT*UX+RVDOT*VX
      YDOT=RDOT*UY+RVDOT*VY
      ZDOT=RDOT*UZ+RVDOT*VZ

      RETURN
      END
