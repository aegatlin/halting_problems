# Benchee.run(
#   %{
#     sieve: fn -> Exgames.Integers.Primes.sieve(1_000_000) end
#   },
#   save: [path: "benchmarks/sieve_benchmarks/sieve4.benchee"]
# )

Benchee.report(load: "benchmarks/sieve_benchmarks/*.benchee")
