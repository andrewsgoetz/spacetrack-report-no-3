#ifndef STR3_H
#define STR3_H

struct C1 {
  double ck2;
  double ck4;
  double e6a;
  double qoms2t;
  double s;
  double tothrd;
  double xj3;
  double xke;
  double xkmper;
  double xmnpda;
  double ae;
};

struct C2 {
  double de2ra;
  double pi;
  double pio2;
  double twopi;
  double x3pio2;
};

struct E1 {
  double xmo;
  double xnodeo;
  double omegao;
  double eo;
  double xincl;
  double xno;
  double xndt2o;
  double xndd6o;
  double bstar;
  double x;
  double y;
  double z;
  double xdot;
  double ydot;
  double zdot;
  double epoch;
  double ds50;
};

double actan(struct C2 * C2, double sinx, double cosx);
double fmod2p(struct C2 * C2, double x);
void sgp(struct C1 * C1, struct C2 * C2, struct E1 * E1, int * iflag, double tsince);

#endif

