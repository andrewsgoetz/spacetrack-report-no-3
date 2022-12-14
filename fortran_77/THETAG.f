      FUNCTION THETAG(EP)
      COMMON/E1/EPOCH,DS50,XMO,XNODEO,OMEGAO,EO,XINCL,XNO,XNDT2O,
     1           XNDD6O,BSTAR,X,Y,Z,XDOT,YDOT,ZDOT
      DOUBLE PRECISION EPOCH,D,THETA,TWOPI,YR,TEMP,EP,DS50
      TWOPI=6.28318530717959D0
      YR=(EP+2.D-7)*1.D-3
      JY=YR
      YR=JY
      D=EP-YR*1.D3
      IF(JY.LT.10) JY=JY+80
      N=(JY-69)/4
      IF(JY.LT.70) N=(JY-72)/4
      DS50=7305.D0 + 365.D0*(JY-70) +N + D
      THETA=1.72944494D0 + 6.3003880987D0*DS50
      TEMP=THETA/TWOPI
      I=TEMP
      TEMP=I
      THETAG=THETA-TEMP*TWOPI
      IF(THETAG.LT.0.D0) THETAG=THETAG+TWOPI
      RETURN
      END
