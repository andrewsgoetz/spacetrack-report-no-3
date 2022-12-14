*      DEEP SPACE                                         31 OCT 80
      SUBROUTINE DEEP
      COMMON/E1/XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
     1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT,EPOCH,DS50
      COMMON/C1/CK2,CK4,E6A,QOMS2T,S,TOTHRD,
     1           XJ3,XKE,XKMPER,XMNPDA,AE
      COMMON/C2/DE2RA,PI,PIO2,TWOPI,X3PIO2
      DOUBLE PRECISION EPOCH, DS50
      DOUBLE PRECISION
     *     DAY,PREEP,XNODCE,ATIME,DELT,SAVTSN,STEP2,STEPN,STEPP
      DATA              ZNS,           C1SS,          ZES/
     A                  1.19459E-5,    2.9864797E-6,  .01675/
      DATA              ZNL,           C1L,           ZEL/
     A                  1.5835218E-4,  4.7968065E-7,  .05490/
      DATA              ZCOSIS,        ZSINIS,        ZSINGS/
     A                  .91744867,     .39785416,     -.98088458/
      DATA              ZCOSGS,        ZCOSHS,        ZSINHS/
     A                  .1945905,      1.0,           0.0/
      DATA Q22,Q31,Q33/1.7891679E-6,2.1460748E-6,2.2123015E-7/
      DATA G22,G32/5.7686396,0.95240898/
      DATA G44,G52/1.8014998,1.0508330/
      DATA G54/4.4108898/
      DATA ROOT22,ROOT32/1.7891679E-6,3.7393792E-7/
      DATA ROOT44,ROOT52/7.3636953E-9,1.1428639E-7/
      DATA ROOT54/2.1765803E-9/
      DATA THDT/4.3752691E-3/

*     ENTRANCE FOR DEEP SPACE INITIALIZATION

      ENTRY DPINIT(EQSQ,SINIQ,COSIQ,RTEQSQ,AO,COSQ2,SINOMO,COSOMO,
     1         BSQ,XLLDOT,OMGDT,XNODOT,XNODP)
      THGR=THETAG(EPOCH)
      EQ = EO
      XNQ = XNODP
      AQNV = 1./AO
      XQNCL = XINCL
      XMAO=XMO
      XPIDOT=OMGDT+XNODOT
      SINQ = SIN(XNODEO)
      COSQ = COS(XNODEO)
      OMEGAQ = OMEGAO

*     INITIALIZE LUNAR SOLAR TERMS

    5 DAY=DS50+18261.5D0
      IF (DAY.EQ.PREEP)    GO TO 10
      PREEP = DAY
      XNODCE=4.5236020-9.2422029E-4*DAY
      STEM=DSIN (XNODCE)
      CTEM=DCOS (XNODCE)
      ZCOSIL=.91375164-.03568096*CTEM
      ZSINIL=SQRT (1.-ZCOSIL*ZCOSIL)
      ZSINHL= .089683511*STEM/ZSINIL
      ZCOSHL=SQRT (1.-ZSINHL*ZSINHL)
      C=4.7199672+.22997150*DAY
      GAM=5.8351514+.0019443680*DAY
      ZMOL = FMOD2P(C-GAM)
      ZX= .39785416*STEM/ZSINIL
      ZY= ZCOSHL*CTEM+0.91744867*ZSINHL*STEM
      ZX=ACTAN(ZX,ZY)
      ZX=GAM+ZX-XNODCE
      ZCOSGL=COS (ZX)
      ZSINGL=SIN (ZX)
      ZMOS=6.2565837D0+.017201977D0*DAY
      ZMOS=FMOD2P(ZMOS)

*     DO SOLAR TERMS

   10 LS = 0
      SAVTSN=1.D20
      ZCOSG=ZCOSGS
      ZSING=ZSINGS
      ZCOSI=ZCOSIS
      ZSINI=ZSINIS
      ZCOSH=COSQ
      ZSINH=SINQ
      CC=C1SS
      ZN=ZNS
      ZE=ZES
      ZMO=ZMOS
      XNOI=1./XNQ
      ASSIGN 30 TO LS
   20 A1=ZCOSG*ZCOSH+ZSING*ZCOSI*ZSINH
      A3=-ZSING*ZCOSH+ZCOSG*ZCOSI*ZSINH
      A7=-ZCOSG*ZSINH+ZSING*ZCOSI*ZCOSH
      A8=ZSING*ZSINI
      A9=ZSING*ZSINH+ZCOSG*ZCOSI*ZCOSH
      A10=ZCOSG*ZSINI
      A2= COSIQ*A7+ SINIQ*A8
      A4= COSIQ*A9+ SINIQ*A10
      A5=- SINIQ*A7+ COSIQ*A8
      A6=- SINIQ*A9+ COSIQ*A10
C
      X1=A1*COSOMO+A2*SINOMO
      X2=A3*COSOMO+A4*SINOMO
      X3=-A1*SINOMO+A2*COSOMO
      X4=-A3*SINOMO+A4*COSOMO
      X5=A5*SINOMO
      X6=A6*SINOMO
      X7=A5*COSOMO
      X8=A6*COSOMO
C
      Z31=12.*X1*X1-3.*X3*X3
      Z32=24.*X1*X2-6.*X3*X4
      Z33=12.*X2*X2-3.*X4*X4
      Z1=3.*(A1*A1+A2*A2)+Z31*EQSQ
      Z2=6.*(A1*A3+A2*A4)+Z32*EQSQ
      Z3=3.*(A3*A3+A4*A4)+Z33*EQSQ
      Z11=-6.*A1*A5+EQSQ *(-24.*X1*X7-6.*X3*X5)
      Z12=-6.*(A1*A6+A3*A5)+EQSQ *(-24.*(X2*X7+X1*X8)-6.*(X3*X6+X4*X5))
      Z13=-6.*A3*A6+EQSQ *(-24.*X2*X8-6.*X4*X6)
      Z21=6.*A2*A5+EQSQ *(24.*X1*X5-6.*X3*X7)
      Z22=6.*(A4*A5+A2*A6)+EQSQ *(24.*(X2*X5+X1*X6)-6.*(X4*X7+X3*X8))
      Z23=6.*A4*A6+EQSQ *(24.*X2*X6-6.*X4*X8)
      Z1=Z1+Z1+BSQ*Z31
      Z2=Z2+Z2+BSQ*Z32
      Z3=Z3+Z3+BSQ*Z33
      S3=CC*XNOI
      S2=-.5*S3/RTEQSQ
      S4=S3*RTEQSQ
      S1=-15.*EQ*S4
      S5=X1*X3+X2*X4
      S6=X2*X3+X1*X4
      S7=X2*X4-X1*X3
      SE=S1*ZN*S5
      SI=S2*ZN*(Z11+Z13)
      SL=-ZN*S3*(Z1+Z3-14.-6.*EQSQ)
      SGH=S4*ZN*(Z31+Z33-6.)
      SH=-ZN*S2*(Z21+Z23)
      IF(XQNCL.LT.5.2359877E-2) SH=0.0
      EE2=2.*S1*S6
      E3=2.*S1*S7
      XI2=2.*S2*Z12
      XI3=2.*S2*(Z13-Z11)
      XL2=-2.*S3*Z2
      XL3=-2.*S3*(Z3-Z1)
      XL4=-2.*S3*(-21.-9.*EQSQ)*ZE
      XGH2=2.*S4*Z32
      XGH3=2.*S4*(Z33-Z31)
      XGH4=-18.*S4*ZE
      XH2=-2.*S2*Z22
      XH3=-2.*S2*(Z23-Z21)
      GO TO LS

*     DO LUNAR TERMS

   30 SSE = SE
      SSI=SI
      SSL=SL
      SSH=SH/SINIQ
      SSG=SGH-COSIQ*SSH
      SE2=EE2
      SI2=XI2
      SL2=XL2
      SGH2=XGH2
      SH2=XH2
      SE3=E3
      SI3=XI3
      SL3=XL3
      SGH3=XGH3
      SH3=XH3
      SL4=XL4
      SGH4=XGH4
      LS=1
      ZCOSG=ZCOSGL
      ZSING=ZSINGL
      ZCOSI=ZCOSIL
      ZSINI=ZSINIL
      ZCOSH=ZCOSHL*COSQ+ZSINHL*SINQ
      ZSINH=SINQ*ZCOSHL-COSQ*ZSINHL
      ZN=ZNL
      CC=C1L
      ZE=ZEL
      ZMO=ZMOL
      ASSIGN 40 TO LS
      GO TO 20
   40 SSE = SSE+SE
      SSI=SSI+SI
      SSL=SSL+SL
      SSG=SSG+SGH-COSIQ/SINIQ*SH
      SSH=SSH+SH/SINIQ

*     GEOPOTENTIAL RESONANCE INITIALIZATION FOR 12 HOUR ORBITS

      IRESFL=0
      ISYNFL=0
      IF(XNQ.LT.(.0052359877).AND.XNQ.GT.(.0034906585)) GO TO 70
      IF (XNQ.LT.(8.26E-3) .OR. XNQ.GT.(9.24E-3))    RETURN
      IF (EQ.LT.0.5)    RETURN
      IRESFL =1
      EOC=EQ*EQSQ
      G201=-.306-(EQ-.64)*.440
      IF(EQ.GT.(.65)) GO TO 45
      G211=3.616-13.247*EQ+16.290*EQSQ
      G310=-19.302+117.390*EQ-228.419*EQSQ+156.591*EOC
      G322=-18.9068+109.7927*EQ-214.6334*EQSQ+146.5816*EOC
      G410=-41.122+242.694*EQ-471.094*EQSQ+313.953*EOC
      G422=-146.407+841.880*EQ-1629.014*EQSQ+1083.435*EOC
      G520=-532.114+3017.977*EQ-5740*EQSQ+3708.276*EOC
      GO TO 55
   45 G211=-72.099+331.819*EQ-508.738*EQSQ+266.724*EOC
      G310=-346.844+1582.851*EQ-2415.925*EQSQ+1246.113*EOC
      G322=-342.585+1554.908*EQ-2366.899*EQSQ+1215.972*EOC
      G410=-1052.797+4758.686*EQ-7193.992*EQSQ+3651.957*EOC
      G422=-3581.69+16178.11*EQ-24462.77*EQSQ+12422.52*EOC
      IF(EQ.GT.(.715)) GO TO 50
      G520=1464.74-4664.75*EQ+3763.64*EQSQ
      GO TO 55
   50 G520=-5149.66+29936.92*EQ-54087.36*EQSQ+31324.56*EOC
   55 IF(EQ.GE.(.7)) GO TO 60
      G533=-919.2277+4988.61*EQ-9064.77*EQSQ+5542.21*EOC
      G521 = -822.71072+4568.6173*EQ-8491.4146*EQSQ+5337.524*EOC
      G532 = -853.666+4690.25*EQ-8624.77*EQSQ+5341.4*EOC
      GO TO 65
   60 G533=-37995.78+161616.52*EQ-229838.2*EQSQ+109377.94*EOC
      G521 = -51752.104+218913.95*EQ-309468.16*EQSQ+146349.42*EOC
      G532 = -40023.88+170470.89*EQ-242699.48*EQSQ+115605.82*EOC
   65 SINI2=SINIQ*SINIQ
      F220=.75*(1.+2.*COSIQ+COSQ2)
      F221=1.5*SINI2
      F321=1.875*SINIQ*(1.-2.*COSIQ-3.*COSQ2)
      F322=-1.875*SINIQ*(1.+2.*COSIQ-3.*COSQ2)
      F441=35.*SINI2*F220
      F442=39.3750*SINI2*SINI2
      F522=9.84375*SINIQ*(SINI2*(1.-2.*COSIQ-5.*COSQ2)
     1     +.33333333*(-2.+4.*COSIQ+6.*COSQ2))
      F523 = SINIQ*(4.92187512*SINI2*(-2.-4.*COSIQ+10.*COSQ2)
     *      +6.56250012*(1.+2.*COSIQ-3.*COSQ2))
      F542 = 29.53125*SINIQ*(2.-8.*COSIQ+COSQ2*(-12.+8.*COSIQ
     *      +10.*COSQ2))
      F543=29.53125*SINIQ*(-2.-8.*COSIQ+COSQ2*(12.+8.*COSIQ-10.*COSQ2))
      XNO2=XNQ*XNQ
      AINV2=AQNV*AQNV
      TEMP1 = 3.*XNO2*AINV2
      TEMP = TEMP1*ROOT22
      D2201 = TEMP*F220*G201
      D2211 = TEMP*F221*G211
      TEMP1 = TEMP1*AQNV
      TEMP = TEMP1*ROOT32
      D3210 = TEMP*F321*G310
      D3222 = TEMP*F322*G322
      TEMP1 = TEMP1*AQNV
      TEMP = 2.*TEMP1*ROOT44
      D4410 = TEMP*F441*G410
      D4422 = TEMP*F442*G422
      TEMP1 = TEMP1*AQNV
      TEMP = TEMP1*ROOT52
      D5220 = TEMP*F522*G520
      D5232 = TEMP*F523*G532
      TEMP = 2.*TEMP1*ROOT54
      D5421 = TEMP*F542*G521
      D5433 = TEMP*F543*G533
      XLAMO = XMAO+XNODEO+XNODEO-THGR-THGR
      BFACT = XLLDOT+XNODOT+XNODOT-THDT-THDT
      BFACT=BFACT+SSL+SSH+SSH
      GO TO 80

*     SYNCHRONOUS RESONANCE TERMS INITIALIZATION

   70 IRESFL=1
      ISYNFL=1
      G200=1.0+EQSQ*(-2.5+.8125*EQSQ)
      G310=1.0+2.0*EQSQ
      G300=1.0+EQSQ*(-6.0+6.60937*EQSQ)
      F220=.75*(1.+COSIQ)*(1.+COSIQ)
      F311=.9375*SINIQ*SINIQ*(1.+3.*COSIQ)-.75*(1.+COSIQ)
      F330=1.+COSIQ
      F330=1.875*F330*F330*F330
      DEL1=3.*XNQ*XNQ*AQNV*AQNV
      DEL2=2.*DEL1*F220*G200*Q22
      DEL3=3.*DEL1*F330*G300*Q33*AQNV
      DEL1=DEL1*F311*G310*Q31*AQNV
      FASX2=.13130908
      FASX4=2.8843198
      FASX6=.37448087
      XLAMO=XMAO+XNODEO+OMEGAO-THGR
      BFACT = XLLDOT+XPIDOT-THDT
      BFACT=BFACT+SSL+SSG+SSH
   80 XFACT=BFACT-XNQ
C
C     INITIALIZE INTEGRATOR
C
      XLI=XLAMO
      XNI=XNQ
      ATIME=0.D0
      STEPP=720.D0
      STEPN=-720.D0
      STEP2 = 259200.D0
      RETURN

*     ENTRANCE FOR DEEP SPACE SECULAR EFFECTS

      ENTRY DPSEC(XLL,OMGASM,XNODES,EM,XINC,XN,T)
      XLL=XLL+SSL*T
      OMGASM=OMGASM+SSG*T
      XNODES=XNODES+SSH*T
      EM=EO+SSE*T
      XINC=XINCL+SSI*T
      IF(XINC .GE. 0.) GO TO 90
      XINC = -XINC
      XNODES = XNODES + PI
      OMGASM = OMGASM - PI
   90 IF(IRESFL .EQ. 0) RETURN
  100 IF (ATIME.EQ.0.D0)    GO TO 170
      IF(T.GE.(0.D0).AND.ATIME.LT.(0.D0)) GO TO 170
      IF(T.LT.(0.D0).AND.ATIME.GE.(0.D0)) GO TO 170
  105 IF(DABS(T).GE.DABS(ATIME)) GO TO 120
      DELT=STEPP
      IF (T.GE.0.D0)    DELT = STEPN
  110 ASSIGN 100 TO IRET
      GO TO 160
  120 DELT=STEPN
      IF (T.GT.0.D0)    DELT = STEPP
  125 IF (DABS(T-ATIME).LT.STEPP)    GO TO 130
      ASSIGN 125 TO IRET
      GO TO 160
  130 FT = T-ATIME
      ASSIGN 140 TO IRETN
      GO TO 150
  140 XN = XNI+XNDOT*FT+XNDDT*FT*FT*0.5
      XL = XLI+XLDOT*FT+XNDOT*FT*FT*0.5
      TEMP = -XNODES+THGR+T*THDT
      XLL = XL-OMGASM+TEMP
      IF (ISYNFL.EQ.0)    XLL = XL+TEMP+TEMP
      RETURN
C
C     DOT TERMS CALCULATED
C
  150 IF (ISYNFL.EQ.0)    GO TO 152
      XNDOT=DEL1*SIN (XLI-FASX2)+DEL2*SIN (2.*(XLI-FASX4))
     1     +DEL3*SIN (3.*(XLI-FASX6))
      XNDDT = DEL1*COS(XLI-FASX2)
     *       +2.*DEL2*COS(2.*(XLI-FASX4))
     *       +3.*DEL3*COS(3.*(XLI-FASX6))
      GO TO 154
  152 XOMI = OMEGAQ+OMGDT*ATIME
      X2OMI = XOMI+XOMI
      X2LI = XLI+XLI
      XNDOT = D2201*SIN(X2OMI+XLI-G22)
     *       +D2211*SIN(XLI-G22)
     *       +D3210*SIN(XOMI+XLI-G32)
     *       +D3222*SIN(-XOMI+XLI-G32)
     *       +D4410*SIN(X2OMI+X2LI-G44)
     *       +D4422*SIN(X2LI-G44)
     *       +D5220*SIN(XOMI+XLI-G52)
     *       +D5232*SIN(-XOMI+XLI-G52)
     *       +D5421*SIN(XOMI+X2LI-G54)
     *       +D5433*SIN(-XOMI+X2LI-G54)
      XNDDT = D2201*COS(X2OMI+XLI-G22)
     *       +D2211*COS(XLI-G22)
     *       +D3210*COS(XOMI+XLI-G32)
     *       +D3222*COS(-XOMI+XLI-G32)
     *       +D5220*COS(XOMI+XLI-G52)
     *       +D5232*COS(-XOMI+XLI-G52)
     *       +2.*(D4410*COS(X2OMI+X2LI-G44)
     *       +D4422*COS(X2LI-G44)
     *       +D5421*COS(XOMI+X2LI-G54)
     *       +D5433*COS(-XOMI+X2LI-G54))
  154 XLDOT=XNI+XFACT
      XNDDT = XNDDT*XLDOT
      GO TO IRETN
C
C     INTEGRATOR
C
  160 ASSIGN 165 TO IRETN
      GO TO 150
  165 XLI = XLI+XLDOT*DELT+XNDOT*STEP2
      XNI = XNI+XNDOT*DELT+XNDDT*STEP2
      ATIME=ATIME+DELT
      GO TO IRET
C
C     EPOCH RESTART
C
  170 IF (T.GE.0.D0) GO TO 175
      DELT=STEPN
      GO TO 180
  175 DELT = STEPP
  180 ATIME = 0.D0
      XNI=XNQ
      XLI=XLAMO
      GO TO 125
C
C     ENTRANCES FOR LUNAR-SOLAR PERIODICS
C
C
      ENTRY DPPER(EM,XINC,OMGASM,XNODES,XLL)
      SINIS = SIN(XINC)
      COSIS = COS(XINC)
      IF (DABS(SAVTSN-T).LT.(30.D0))    GO TO 210
      SAVTSN=T
      ZM=ZMOS+ZNS*T
  205 ZF=ZM+2.*ZES*SIN (ZM)
      SINZF=SIN (ZF)
      F2=.5*SINZF*SINZF-.25
      F3=-.5*SINZF*COS (ZF)
      SES=SE2*F2+SE3*F3
      SIS=SI2*F2+SI3*F3
      SLS=SL2*F2+SL3*F3+SL4*SINZF
      SGHS=SGH2*F2+SGH3*F3+SGH4*SINZF
      SHS=SH2*F2+SH3*F3
      ZM=ZMOL+ZNL*T
      ZF=ZM+2.*ZEL*SIN (ZM)
      SINZF=SIN (ZF)
      F2=.5*SINZF*SINZF-.25
      F3=-.5*SINZF*COS (ZF)
      SEL=EE2*F2+E3*F3
      SIL=XI2*F2+XI3*F3
      SLL=XL2*F2+XL3*F3+XL4*SINZF
      SGHL=XGH2*F2+XGH3*F3+XGH4*SINZF
      SHL=XH2*F2+XH3*F3
      PE=SES+SEL
      PINC=SIS+SIL
      PL=SLS+SLL
  210 PGH=SGHS+SGHL
      PH=SHS+SHL
      XINC = XINC+PINC
      EM = EM+PE
      IF(XQNCL.LT.(.2)) GO TO 220
      GO TO 218
C
C     APPLY PERIODICS DIRECTLY
C
  218 PH=PH/SINIQ
      PGH=PGH-COSIQ*PH
      OMGASM=OMGASM+PGH
      XNODES=XNODES+PH
      XLL = XLL+PL
      GO TO 230
C
C     APPLY PERIODICS WITH LYDDANE MODIFICATION
C
  220 SINOK=SIN(XNODES)
      COSOK=COS(XNODES)
      ALFDP=SINIS*SINOK
      BETDP=SINIS*COSOK
      DALF=PH*COSOK+PINC*COSIS*SINOK
      DBET=-PH*SINOK+PINC*COSIS*COSOK
      ALFDP=ALFDP+DALF
      BETDP=BETDP+DBET
      XLS = XLL+OMGASM+COSIS*XNODES
      DLS=PL+PGH-PINC*XNODES*SINIS
      XLS=XLS+DLS
      XNODES=ACTAN(ALFDP,BETDP)
      XLL = XLL+PL
      OMGASM = XLS-XLL-COS(XINC)*XNODES
  230 CONTINUE
      RETURN
      END
