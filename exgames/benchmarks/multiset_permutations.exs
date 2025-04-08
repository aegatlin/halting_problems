Benchee.run(
  %{
    multiset_permutations: fn ->
      Exgames.Lists.Permutations.multiset_permutations([1, 1, 2, 2, 3, 3, 4, 4, 5, 5])
    end,
    # It is important to compare these two so we can know the performance gains
    # over the regular function. Naively the same output can be achieved by call
    # `Enum.uniq`
    permutations: fn ->
      Exgames.Lists.Permutations.permutations([1, 1, 2, 2, 3, 3, 4, 4, 5, 5]) |> Enum.uniq()
    end
  },
  save: [path: "benchmarks/multiset_permutations_benchmarks/multiset_permutations2.benchee"]
)

Benchee.report(load: "benchmarks/multiset_permutations_benchmarks/*.benchee")
