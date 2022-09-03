#include "str3.h"

double fmod2p(struct C2 * const C2, const double x) {
  double fmod2p = x;
  const int i = fmod2p / C2->twopi;
  fmod2p = fmod2p - i * C2->twopi;
  if (fmod2p < 0.) fmod2p = fmod2p + C2->twopi;
  return fmod2p;
}

