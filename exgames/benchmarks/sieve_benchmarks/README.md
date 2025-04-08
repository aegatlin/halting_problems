# Sieve Benchmark logs

See my Obsidian note of the Sieve of Eratosthenes for information of why these
optimizations are justified.

`sieve1` is a naive implementation.

`sieve2` improves `sieve1` via the "square root max stop". This is where one
stops the sieve after sqrt(max) and assumes all numbers remaining above that are
prime.

`sieve3` improves `sieve2` via the "less that p^2 skip". This is where one skips
numbers that are less that p^2 when sieving out the multiples of p. The
implementation of the skip is the `<` check as opposed to the slower check that
`Integer.mod(n, p) == 0`.

`sieve4` improves `sieve3` via the "only odds start". This is where one hard
codes the removal of evens in the initial construction of the nums and primes.
