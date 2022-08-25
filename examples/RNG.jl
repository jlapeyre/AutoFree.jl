import GSL
using AutoFrees

# TODO: why does this not print as an alias type ?
const RNG = AutoFree{GSL.gsl_rng, typeof(GSL.rng_alloc), typeof(GSL.rng_free)}

mkrng(t=GSL.gsl_rng_taus2) = RNG(t)

function doflat(rng::RNG)
    return GSL.ran_flat(rng[], 0.0, 1.0)
end

function test_rng2()
    rng = mkrng()
    @show rng
end

if ! isdefined(Main, :rng2)
    const rng2 = mkrng()
end

function test_rng()
    rng1 = mkrng()
    rngp = rng1[]
    global rng2
    @btime doflat($rng1) # function barrier makes this fast
    @btime GSL.ran_flat(($rng1)[], 0.0, 1.0) # very slow
    @btime GSL.ran_flat($rng1.x, 0.0, 1.0) # very slow
    @btime GSL.ran_flat(($rng2)[], 0.0, 1.0) # global const is fast
    # Following often causes segfault, depending on where it is placed
    @btime GSL.ran_flat($rngp, 0.0, 1.0) # fast
end

function test_rng2()
    rng1 = mkrng()
    rngp = rng1[]
    global rng2
    n = 10^7
    @dotimes n doflat(rng1) # function barrier makes this fast
    @dotimes n GSL.ran_flat(rngp, 0.0, 1.0) # fast
    @dotimes n GSL.ran_flat(rng1[], 0.0, 1.0) # very slow
    @dotimes n GSL.ran_flat(rng1.x, 0.0, 1.0) # very slow
    @dotimes n GSL.ran_flat(rng2[], 0.0, 1.0) # global const is fast
    # Following often causes segfault, depending on where it is placed
    @dotimes n GSL.ran_flat(rngp, 0.0, 1.0) # fast
end


function test_ptr()
    rng = mkrng()
    prng = rng[]
    n = 10^7
    @dotimes n doflat(rng)
    @dotimes n GSL.ran_flat(rng[], 0.0, 1.0)
    @dotimes n GSL.ran_flat(prng, 0.0, 1.0)
end


#####

function make_several(n=100)
    rngs = []
    for _ in 1:n
        push!(rngs, mkrng())
    end
end

const free_func(x) = (println("Free one"), GSL.rng_free(x))
const RNGv = AutoFree{GSL.gsl_rng, typeof(GSL.rng_alloc), typeof(free_func)}
mkrngv(t=GSL.gsl_rng_taus2) = RNGv(t)
function make_several_verb(n=10)
    rngs = []
    for _ in 1:n
        push!(rngs, mkrngv())
    end
    return rngs
end
