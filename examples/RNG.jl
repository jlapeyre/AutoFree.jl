import GSL
using AutoFrees

mkrng(t=GSL.gsl_rng_taus2) = AutoFree{GSL.gsl_rng, typeof(GSL.rng_alloc), typeof(GSL.rng_free)}(t)
