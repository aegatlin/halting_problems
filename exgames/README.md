# Exgames

## Tests

```sh
mix test
```

## Benchmarks

You can just run the report if you comment out the `Benchee.run` call and just
run `Benchee.report`. You can change the save file of the benchmark to compare
over time. I created a README.md for the sieve that explains what the
optimization was at each step.

```
mix run benchmarks/sieve.exs
```
