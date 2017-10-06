#ifndef MPU_RANDOM_PRIME_H
#define MPU_RANDOM_PRIME_H

#include "ptypes.h"

extern UV random_nbit_prime(void* ctx, UV b);
extern UV random_ndigit_prime(void* ctx, UV d);
extern UV random_prime(void* ctx, UV lo, UV hi);

extern int is_mr_random(void* ctx, UV n, UV k);

extern UV random_semiprime(void* ctx, UV b);
extern UV random_unrestricted_semiprime(void* ctx, UV b);

#endif
