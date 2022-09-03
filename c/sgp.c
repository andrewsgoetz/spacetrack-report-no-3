#include "str3.h"

#include <math.h>

//      SGP                                             31 OCT 80
void sgp(struct C1 * const C1, struct C2 * const C2, struct E1 * const E1, int * iflag, const double tsince) {
     if (*iflag == 0) goto l19;

//      INITIALIZATION

     static double ao = 0.;
     static double qo = 0.;
     static double xlo = 0.;
     static double d1o = 0.;
     static double d2o = 0.;
     static double d3o = 0.;
     static double d4o = 0.;
     static double omgdt = 0.;
     static double xnodot = 0.;
     static double c5 = 0.;
     static double c6 = 0.;

     const double c1 = C1->ck2 * 1.5;
     const double c2 = C1->ck2 / 4.;
     const double c3 = C1->ck2 / 2.;
     const double c4 = C1->xj3 * (C1->ae * C1->ae * C1->ae) / (4. * C1->ck2);
     const double cosio = cos(E1->xincl);
     const double sinio = sin(E1->xincl);
     const double a1 = pow(C1->xke / E1->xno, C1->tothrd);
     const double d1 = c1 / a1 / a1 * (3. * cosio * cosio - 1.) / pow(1. - E1->eo * E1->eo, 1.5);
     ao = a1 * (1. - 1. / 3. * d1 - d1 * d1 - 134. / 81. * d1 * d1 * d1);
     const double po = ao * (1. - E1->eo * E1->eo);
     qo = ao * (1. - E1->eo);
     xlo = E1->xmo + E1->omegao + E1->xnodeo;
     d1o = c3 * sinio * sinio;
     d2o = c2 * (7. * cosio * cosio - 1.);
     d3o = c1 * cosio;
     d4o = d3o * sinio;
     const double po2no = E1->xno / (po * po);
     omgdt = c1 * po2no * (5. * cosio * cosio - 1.);
     xnodot = -2. * d3o * po2no;
     c5 = 0.5 * c4 * sinio * (3. + 5. * cosio) / (1. + cosio);
     c6 = c4 * sinio;
     *iflag = 0;

//      UPDATE FOR SECULAR GRAVITY AND ATMOSPHERIC DRAG

l19: ;
     double a = E1->xno + (2. * E1->xndt2o + 3. * E1->xndd6o * tsince) * tsince;
     a = ao * pow(E1->xno / a, C1->tothrd);
     double e = C1->e6a;
     if (a > qo) e = 1. - qo / a;
     const double p = a * (1. - e * e);
     const double xnodes = E1->xnodeo + xnodot * tsince;
     const double omgas = E1->omegao + omgdt * tsince;
     const double xls = fmod2p(C2, xlo + (E1->xno + omgdt + xnodot + (E1->xndt2o + E1->xndd6o * tsince) * tsince) * tsince);

//      LONG PERIOD PERIODICS

     const double axnsl = e * cos(omgas);
     const double aynsl = e * sin(omgas) - c6 / p;
     const double xl = fmod2p(C2, xls - c5 / p * axnsl);

//      SOLVE KEPLERS EQUATION

     const double u = fmod2p(C2, xl - xnodes);
     int item3 = 0;
     double eo1 = u;
     double tem5 = 1.;
l20: ;
     double sineo1 = sin(eo1);
     double coseo1 = cos(eo1);
     if (fabs(tem5) < C1->e6a) goto l30;
     if (item3 >= 10) goto l30;
     item3 = item3 + 1;
     tem5 = 1. - coseo1 * axnsl - sineo1 * aynsl;
     tem5 = (u - aynsl * coseo1 + axnsl * sineo1 - eo1) / tem5;
     const double tem2 = fabs(tem5);
     if (tem2 > 1.) tem5 = tem2 / tem5;
     eo1 = eo1 + tem5;
     goto l20;

//      SHORT PERIOD PRELIMINARY QUANTITIES

l30: ;
     const double ecose = axnsl * coseo1 + aynsl * sineo1;
     const double esine = axnsl * sineo1 - aynsl * coseo1;
     const double el2 = axnsl * axnsl + aynsl * aynsl;
     const double pl = a * (1. - el2);
     const double pl2 = pl * pl;
     const double r = a * (1. - ecose);
     const double rdot = C1->xke * sqrt(a) / r * esine;
     const double rvdot = C1->xke * sqrt(pl) / r;
     const double temp = esine / (1. + sqrt(1. - el2));
     const double sinu = a / r * (sineo1 - aynsl - axnsl * temp);
     const double cosu = a / r * (coseo1 - axnsl + aynsl * temp);
     const double su = actan(C2, sinu, cosu);

//      UPDATE FOR SHORT PERIODICS

     const double sin2u = (cosu + cosu) * sinu;
     const double cos2u = 1. - 2. * sinu * sinu;
     const double rk = r + d1o / pl * cos2u;
     const double uk = su - d2o / pl2 * sin2u;
     const double xnodek = xnodes + d3o * sin2u / pl2;
     const double xinck = E1->xincl + d4o / pl2 * cos2u;

//      ORIENTATION VECTORS

     const double sinuk = sin(uk);
     const double cosuk = cos(uk);
     const double sinnok = sin(xnodek);
     const double cosnok = cos(xnodek);
     const double sinik = sin(xinck);
     const double cosik = cos(xinck);
     const double xmx = -sinnok * cosik;
     const double xmy = cosnok * cosik;
     const double ux = xmx * sinuk + cosnok * cosuk;
     const double uy = xmy * sinuk + sinnok * cosuk;
     const double uz = sinik * sinuk;
     const double vx = xmx * cosuk - cosnok * sinuk;
     const double vy = xmy * cosuk - sinnok * sinuk;
     const double vz = sinik * cosuk;

//      POSITION AND VELOCITY

     E1->x = rk * ux;
     E1->y = rk * uy;
     E1->z = rk * uz;
     E1->xdot = rdot * ux;
     E1->ydot = rdot * uy;
     E1->zdot = rdot * uz;
     E1->xdot = rvdot * vx + E1->xdot;
     E1->ydot = rvdot * vy + E1->ydot;
     E1->zdot = rvdot * vz + E1->zdot;
}

