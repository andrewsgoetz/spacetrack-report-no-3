#include "str3.h"

#include <math.h>

double actan(struct C2 * const C2, const double sinx, const double cosx) {
    double actan = 0.;
    if (cosx == 0. ) goto l5;
    if (cosx  > 0. ) goto l1;
    actan = C2->pi;
    goto l7;
l1: if (sinx == 0. ) goto l8;
    if (sinx  > 0. ) goto l7;
    actan = C2->twopi;
    goto l7;
l5: if (sinx == 0. ) goto l8;
    if (sinx  > 0. ) goto l6;
    actan = C2->x3pio2;
    goto l8;
l6: actan = C2->pio2;
    goto l8;
l7: ;
    const double temp = sinx / cosx;
    actan = actan + atan(temp);
l8: return actan;
}

