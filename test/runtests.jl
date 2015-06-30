using OEIS
using Base.Test

# prime numbers
s = oeis(:A000040)
@test s.values == primes(s.values[end])

# test Int128
s = oeis(:A000521)
@test typeof(s.values[16]) == Int128

# test handling of too many values
@test_throws ErrorException oeis("primes")

# test handling of negatives
s = oeis(:A000594)
@test s.values[2] == -24
