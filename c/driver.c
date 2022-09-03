#include "str3.h"

#include <math.h>
#include <stdio.h>

//      DRIVER                                                 3 NOV 80
//   WGS-72 PHYSICAL AND GEOPOTENTIAL CONSTANTS
//          CK2= .5*J2*AE**2     CK4=-.375*J4*AE**4

int main(void) {
      const char * const c700 = "%1d%10f%10f%10f\n";
      const char * const c701a = "";
      const char * const c701b = "";//FORMAT(29X,D14.8,1X,3F8.4,/,6X,F8.7,F8.4,1X,2F11.9,1X,F6.5,I2,4X,F8.7,I2)
      const char * const c702a = "";
      const char * const c702b = "";//FORMAT(18X,D14.8,1X,F10.8,2(1X,F6.5,I2),/,7X,2(1X,F8.4),1X,F7.7,2(1X,F8.4),1X,F11.8)
      // 703 unused
      const char * const c704 = "";//FORMAT(1H1,A80,/,1X,A80,//,1X,A4,7H TSINCE,14X,1HX,16X,1HY,16X,1HZ,14X,4HXDOT,13X,4HYDOT,13X,4HZDOT,//)
      const char * const c705 = "";//FORMAT(7F17.8)
      const int abuf_len_706 = 82;
      const int itype_ix_707 = 79;
      const char * const c930 = "SHOULD USE DEEP SPACE EPHEMERIS\n";
      const char * const c940 = "SHOULD USE NEAR EARTH EPHEMERIS\n";
      const char * const c950 = "EPHEMERIS NUMBER%2d NOT LEGAL, WILL SKIP THIS CASE\n";

      const char ihg = 'G';

      struct C1 C1;
      struct C2 C2;
      struct E1 E1;

      C2.de2ra = 0.174532925E-1;
      C1.e6a = 1.E-6;
      C2.pi = 3.14159265;
      C2.pio2 = 1.57079633;
      const double qo = 120.;
      const double so = 78.;
      C1.tothrd = 0.66666667;
      C2.twopi = 6.2831853;
      C2.x3pio2 = 4.71238898;
      const double xj2 = 1.082616E-3;
      C1.xj3 = -0.253881E-5;
      const double xj4 = -1.65597E-6;
      C1.xke = 0.743669161E-1;
      C1.xkmper = 6378.135;
      C1.xmnpda = 1440.;
      C1.ae = 1.;

      char * iset[5];
      char abuf[2][82] = {{'\0'}, {'\0'}};
      iset[0] = "SGP"; iset[1] = "SGP4"; iset[2] = "SDP4"; iset[3] = "SGP8"; iset[4] = "SDP8";

//     SELECT EPHEMERIS TYPE AND OUTPUT TIMES

      C1.ck2 = 0.5 * xj2 * (C1.ae * C1.ae);
      C1.ck4 = -0.375 * xj4 * (C1.ae * C1.ae * C1.ae * C1.ae);
      C1.qoms2t = pow((qo - so) * C1.ae / C1.xkmper, 4);
      C1.s = C1.ae * (1. + so / C1.xkmper);
      int iept;
      double ts;
      double tf;
      double delt;
  l2: scanf(c700, &iept, &ts, &tf, &delt);
      if (iept <= 0) return 0;
      int ideep = 0;

//     READ IN MEAN ELEMENTS FROM 2 CARD T(TRANS) OR G(INTERN) FORMAT

      fgets(abuf[0], abuf_len_706, stdin);
      fgets(abuf[1], abuf_len_706, stdin);
      int iexp;
      int ibexp;
      const char itype = abuf[0][itype_ix_707];
      if (itype == ihg) goto l5;
      sscanf(abuf[0], c702a, &(E1.epoch), &(E1.xndt2o), &(E1.xndd6o), &iexp, &(E1.bstar), &ibexp);
      sscanf(abuf[1], c702b, &(E1.xincl), &(E1.xnodeo), &(E1.eo), &(E1.omegao), &(E1.xmo), &(E1.xno));
      goto l7;
  l5: sscanf(abuf[0], c701a, &(E1.epoch), &(E1.xmo), &(E1.xnodeo), &(E1.omegao));
      sscanf(abuf[1], c701b, &(E1.eo), &(E1.xincl), &(E1.xno), &(E1.xndt2o), &(E1.xndd6o), &iexp, &(E1.bstar), &ibexp);
  l7: if (E1.xno <= 0.) return 0;
      printf(c704, abuf[0], abuf[1], iset[iept - 1]);
      if (iept > 5) goto l900;
      E1.xndd6o = E1.xndd6o * pow(10., iexp);
      E1.xnodeo = E1.xnodeo * C2.de2ra;
      E1.omegao = E1.omegao * C2.de2ra;
      E1.xmo = E1.xmo * C2.de2ra;
      E1.xincl = E1.xincl * C2.de2ra;
      double temp = C2.twopi / C1.xmnpda / C1.xmnpda;
      E1.xno = E1.xno * temp * C1.xmnpda;
      E1.xndt2o = E1.xndt2o * temp;
      E1.xndd6o = E1.xndd6o * temp / C1.xmnpda;

//     INPUT CHECK FOR PERIOD VS EPHEMERIS SELECTED
//     PERIOD GE 225 MINUTES IS DEEP SPACE

      const double a1 = pow(C1.xke / E1.xno, C1.tothrd);
      temp = 1.5 * C1.ck2 * (3. * cos(E1.xincl) * cos(E1.xincl) - 1.) / pow(1. - E1.eo * E1.eo, 1.5);
      const double del1 = temp / (a1 * a1);
      const double ao = a1 * (1. - del1 * (0.5 * C1.tothrd + del1 * (1. + 134./81. * del1)));
      const double delo = temp/(ao * ao);
      const double xnodp = E1.xno / (1. + delo);
      if ((C2.twopi / xnodp / C1.xmnpda) >= 0.15625) ideep = 1;

      E1.bstar = E1.bstar * pow(10., ibexp) / C1.ae;
      double tsince = ts;
      int iflag = 1;
      if (ideep == 1 && (iept == 1 || iept == 2 || iept == 4)) goto l800;
  l9: if (ideep == 0 && (iept == 3 || iept == 5)) goto l850;
 l10: if (iept == 1) goto l21; else if (iept == 2) goto l22; else if (iept == 3) goto l23; else if (iept == 4) goto l24; else if (iept == 5) goto l25;
 l21: sgp(&C1, &C2, &E1, &iflag, tsince);
      goto l60;
 l22: printf("SGP4 NOT YET SUPPORTED\n");//sgp4(&C1, &C2, &E1, &iflag, tsince);
      goto l60;
 l23: printf("SDP4 NOT YET SUPPORTED\n");//sdp4(&C1, &C2, &E1, &iflag, tsince);
      goto l60;
 l24: printf("SGP8 NOT YET SUPPORTED\n");//sgp8(&C1, &C2, &E1, &iflag, tsince);
      goto l60;
 l25: printf("SDP8 NOT YET SUPPORTED\n");//sdp8(&C1, &C2, &E1, &iflag, tsince);
 l60: E1.x = E1.x * C1.xkmper / C1.ae;
      E1.y = E1.y * C1.xkmper / C1.ae;
      E1.z = E1.z * C1.xkmper / C1.ae;
      E1.xdot = E1.xdot * C1.xkmper / C1.ae * C1.xmnpda / 86400.;
      E1.ydot = E1.ydot * C1.xkmper / C1.ae * C1.xmnpda / 86400.;
      E1.zdot = E1.zdot * C1.xkmper / C1.ae * C1.xmnpda / 86400.;
      printf(c705, tsince, E1.x, E1.y, E1.z, E1.xdot, E1.ydot, E1.zdot);
      tsince = tsince + delt;
      if (fabs(tsince) > fabs(tf)) goto l2;
      goto l10;
l800: printf(c930);
      goto l9;
l850: printf(c940);
      goto l10;
l900: printf(c950, iept);
      goto l2;
}
