# OEIS
[![Build Status](https://travis-ci.org/MurrayT/OEIS.jl.svg?branch=master)](https://travis-ci.org/MurrayT/OEIS.jl)
A wrapper that lets you query [OEIS](http://oeis.org) from within Julia.

```julia
julia> oeis([1,1,2,3,5,8,13,21,35])
S A229194 1,1,1,2,3,5,8,13,21,35,58,97,163,275,466,793,1353,2315,3969,6817,
N A229194 Integers nearest to (2^((n-3)/2) + 3^((n-3)/2)).

S A005170 1,0,1,1,2,3,5,8,13,21,35,55,93,149,248,403,670,1082
N A005170 Erroneous version of A226999.

S A226999 1,0,1,1,2,3,5,8,13,21,35,55,93,149,248,403,671,1098,1827,3013,5013,
N A226999 Inverse Euler transform of A005169 (fountains of coins).

S A218032 1,1,1,1,2,3,5,8,13,21,35,57,94,154,254,417,687,1129,1859,3057,5032,
N A218032 G.f. A(x) satisfies A(x) = 1 + x / (1- x * A(x^2)).

julia> oeis("A000246")
S A000246 1,1,1,3,9,45,225,1575,11025,99225,893025,9823275,108056025,
N A000246 Number of permutations in the symmetric group S_n that have odd order.
```

The output is highlighted with the sequence number in green.
