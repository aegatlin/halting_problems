# multiset_permutations

v1 was a naive implementation of running the current `permutations/1` algorithm
(which is the v2 recursive flat-map version in the benchmark data) and then
calling `Enum.uniq`. It does not have a comparison with `permutations/1` in the
benchmark data because they were essentially identical implementations.

v2 is what I'm calling the "recursive store algorithm".
