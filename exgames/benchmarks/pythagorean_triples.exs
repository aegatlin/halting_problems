Benchee.run(
  %{
    all_pythagorean_triples: fn ->
      Exgames.Integers.PythagoreanTriples.all_pythagorean_triples(1000)
    end
  },
  save: [path: "benchmarks/pythagorean_triples_benchmarks/pythagorean_triples2.benchee"]
)

Benchee.report(load: "benchmarks/pythagorean_triples_benchmarks/*.benchee")
