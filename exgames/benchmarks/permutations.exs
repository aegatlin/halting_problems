Benchee.run(
  %{
    permutations: fn -> Exgames.Lists.permutations(1..10 |> Enum.to_list()) end
  },
  save: [path: "benchmarks/permutations_benchmarks/permutations2.benchee"]
)

Benchee.report(load: "benchmarks/permutations_benchmarks/*.benchee")
