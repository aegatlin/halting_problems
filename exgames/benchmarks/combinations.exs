Benchee.run(
  %{
    combinations: fn -> Exgames.Lists.combinations(1..25 |> Enum.to_list(), 10) end
  },
  save: [path: "benchmarks/combinations_benchmarks/combinations1.benchee"]
)

Benchee.report(load: "benchmarks/combinations_benchmarks/*.benchee")
