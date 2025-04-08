Benchee.run(
  %{
    choose: fn -> Exgames.Combinatorics.choose(100_000, 10_000) end
  },
  save: [path: "benchmarks/choose_benchmarks/choose2.benchee"]
)

Benchee.report(load: "benchmarks/choose_benchmarks/*.benchee")
