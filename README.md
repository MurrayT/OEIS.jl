# OEIS
[![Build Status](https://travis-ci.org/MurrayT/OEIS.jl.svg?branch=master)](https://travis-ci.org/MurrayT/OEIS.jl)

A wrapper that lets you query [OEIS](http://oeis.org) from within Julia.

```julia
julia> using OEIS

julia> oeis([1,1,2,3,5,8,13,21,35]) # search matching sequences
4-element Array{IntegerSequence{T<:Integer},1}:
 IntegerSequence{Int64}: A229194
  Integers nearest to (2^((n-3)/2) + 3^((n-3)/2)).
  1,1,1,2,3,5,8,13,21,35,58,97,163,275,466,793,1353,2315,3969,6817,...     
 IntegerSequence{Int64}: A005170
  Erroneous version of A226999.
  1,0,1,1,2,3,5,8,13,21,35,55,93,149,248,403,670,1082                                         
 IntegerSequence{Int64}: A226999
  Inverse Euler transform of A005169 (fountains of coins).
  1,0,1,1,2,3,5,8,13,21,35,55,93,149,248,403,671,1098,1827,3013,...
 IntegerSequence{Int64}: A218032
  G.f. A(x) satisfies A(x) = 1 + x / (1- x * A(x^2)).
  1,1,1,1,2,3,5,8,13,21,35,57,94,154,254,417,687,1129,1859,3057,...     

julia> s = oeis(:A000246) # symbols search by id
IntegerSequence{Integer}: A000246
  Number of permutations in the symmetric group S_n that have odd order.
  1,1,1,3,9,45,225,1575,11025,99225,893025,9823275,108056025,1404728325,18261468225,273922023375,4108830350625,69850115960625,1187451971330625,22561587455281875,...

julia> s.id
:A000246

julia> s.name
"Number of permutations in the symmetric group S_n that have odd order."

julia> s.values
23-element Array{Integer,1}:
                     1
                     1
                     1
                     3
                     9
                    45
                   225
                  1575
                 11025
                 99225
                893025
               9823275
             108056025
            1404728325
           18261468225
          273922023375
         4108830350625
        69850115960625
      1187451971330625
     22561587455281875
    428670161650355625
   9002073394657468125
 189043541287806830625
```