#include "str3.h"

double thetag(struct E1 * const E1, const double ep) {
  const double twopi = 6.28318530717959;
  double yr = (ep + 2E-7) * 1E-3;
  int jy = (int) yr;
  yr = jy;
  const double d = ep - yr * 1E3;
  if (jy < 10) jy = jy + 80;
  int n = (jy - 69) / 4;
  if (jy < 70) n = (jy - 72) / 4;
  E1->ds50 = 7305. + 365. * (jy - 70) + n + d;
  const double theta = 1.72944494 + 6.3003880987 * E1->ds50;
  double temp = theta / twopi;
  const int i = (int) temp;
  temp = i;
  double thetag = theta - temp * twopi;
  if (thetag < 0.) thetag = thetag + twopi;
  return thetag;
}

