---
title: "Upper bound on number of diagrams in Chinese chess"
tags:
  - math
old-link: https://fulldecent.blogspot.com/2014/04/upper-bound-on-number-of-diagrams-in.html
---

After some work on the number of reachable positions for chess, I turned some attention to Chinese chess. Here is proof of an upper bound for the number of reachable diagrams, I am using the [François Labelle](https://www.eecs.berkeley.edu/~flab/) from [statistics on chess positions](https://www.eecs.berkeley.edu/~flab/chess/statistics-positions.html).

![Positions](/assets/images/2014-04-19-chinese-chess-diagrams-upper-bound.webp)

A very simple upper bound is:

71415518081535297586850424458320988966669113375477110

which is under 10^53 and 176 bits.

Here is the proof, compile with `gcc cc-simple.c -l gmp`.

```c
 // A very simple upper bound for Chinese chess diagrams
#include <stdlib.h>
#include <stdio.h>
#include <gmp.h>
int main()
{
  /* Precompute factorials */
  long f[6] = {1, 1, 2, 6, 24, 120};
  mpz_t fac[91];
  mpz_t total;
  mpz_t current;
  mpz_init(total);
  mpz_init(current);
  for (int i=0; i<91; i++) {
    mpz_init(fac[i]);
    mpz_fac_ui(fac[i], i);
  }
  for (int G=1; G<=1; G++)
  for (int A=0; A<=2; A++)
  for (int C=0; C<=2; C++)
  for (int R=0; R<=2; R++)
  for (int H=0; H<=2; H++)
  for (int E=0; E<=2; E++)
  for (int S=0; S<=5; S++)
  for (int g=1; g<=1; g++)
  for (int a=0; a<=2; a++)
  for (int c=0; c<=2; c++)
  for (int r=0; r<=2; r++)
  for (int h=0; h<=2; h++)
  for (int e=0; e<=2; e++)
  for (int s=0; s<=5; s++) {
    long army = f[G] * f[A] * f[C] * f[R] * f[H] * f[E] * f[S] *
                f[g] * f[a] * f[c] * f[r] * f[h] * f[e] * f[s];
    mpz_set(current, fac[90]);
    mpz_divexact_ui(current, current, army);
    mpz_divexact(current, current, fac[90-G-A-C-R-H-E-S-g-a-c-r-h-e-s]);
    mpz_add(total, total, current);
  }
  mpz_out_str(stdout, 10, total);
  puts("");
  return 0;
}
```

I'm working on a better version, but my matrix math approach is getting complicated. Follow the questions on [Mathematics Stack Exchange](https://math.stackexchange.com/users/97728/full-decent).
