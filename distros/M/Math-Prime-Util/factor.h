#ifndef MPU_FACTOR_H
#define MPU_FACTOR_H

#include "ptypes.h"

#define MPU_MAX_FACTORS 64

extern int factor(UV n, UV *factors);
extern int factor_exp(UV n, UV *factors, UV* exponents);
extern int factor_one(UV n, UV *factors, int primality, int trial);
extern UV  divisor_sum(UV n, UV k);

extern int trial_factor(UV n, UV *factors, UV first, UV last);
extern int fermat_factor(UV n, UV *factors, UV rounds);
extern int holf_factor(UV n, UV *factors, UV rounds);
extern int pbrent_factor(UV n, UV *factors, UV maxrounds, UV a);
extern int prho_factor(UV n, UV *factors, UV maxrounds);
extern int pminus1_factor(UV n, UV *factors, UV B1, UV B2);
extern int pplus1_factor(UV n, UV *factors, UV B);
extern int squfof_factor(UV n, UV *factors, UV rounds);
extern int lehman_factor(UV n, UV *factors, int dotrial);

extern UV* _divisor_list(UV n, UV *num_divisors);

/* Factoring all numbers in a range. */
typedef struct {
  UV   lo;
  UV   hi;
  UV   n;
  char is_square_free;
  UV  *factors;
  UV   _coffset;
  UV   _noffset;
  UV  *_farray;
  UV  *_nfactors;
} factor_range_context_t;
extern factor_range_context_t factor_range_init(UV lo, UV hi, int square_free);
extern int factor_range_next(factor_range_context_t *ctx);
extern void factor_range_destroy(factor_range_context_t *ctx);

/*
extern UV dlp_trial(UV a, UV g, UV p, UV maxrounds);
extern UV dlp_prho(UV a, UV g, UV p, UV n, UV maxrounds);
extern UV dlp_bsgs(UV a, UV g, UV p, UV n, UV maxent);
*/
extern UV znlog(UV a, UV g, UV p);

#endif
