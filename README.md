# AutoFrees

[![Build Status](https://github.com/jlapeyre/AutoFrees.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/jlapeyre/AutoFrees.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/jlapeyre/AutoFrees.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/jlapeyre/AutoFrees.jl)


See [this Discourse post](https://discourse.julialang.org/t/best-way-to-have-gc-manage-freeing-c-allocated-storage/86233).

This struct should be used with caution. See the post above. Also [issues in the julia repo regarding dangers of finalizers](https://github.com/JuliaLang/julia/issues?q=is%3Aissue+is%3Aopen+finalizer).
