defmodule Exgames.Lists.PermutationsTest do
  use ExUnit.Case

  alias Exgames, as: E

  doctest E.Lists.Permutations

  test "permutations/1" do
    assert E.Lists.Permutations.permutations([]) == [[]]
    assert E.Lists.Permutations.permutations([1]) == [[1]]
    assert E.Lists.Permutations.permutations([1, 2]) == [[1, 2], [2, 1]]

    assert E.Lists.Permutations.permutations([1, 2, 3]) == [
             [1, 2, 3],
             [1, 3, 2],
             [2, 1, 3],
             [2, 3, 1],
             [3, 1, 2],
             [3, 2, 1]
           ]
  end

  test "multiset_permutations/1" do
    assert E.Lists.Permutations.multiset_permutations([1, 1, 2]) == [
             [1, 1, 2],
             [1, 2, 1],
             [2, 1, 1]
           ]
  end

  test "store_algorithm/1" do
    assert E.Lists.Permutations.store_algorithm(%{}) == [[]]
    assert E.Lists.Permutations.store_algorithm(%{a: 1}) == [[:a]]
    assert E.Lists.Permutations.store_algorithm(%{a: 2}) == [[:a, :a]]
    assert E.Lists.Permutations.store_algorithm(%{a: 3}) == [[:a, :a, :a]]

    assert E.Lists.Permutations.store_algorithm(%{a: 1, b: 1}) |> Enum.sort() == [
             [:a, :b],
             [:b, :a]
           ]

    assert E.Lists.Permutations.store_algorithm(%{a: 2, b: 1}) |> Enum.sort() == [
             [:a, :a, :b],
             [:a, :b, :a],
             [:b, :a, :a]
           ]

    assert E.Lists.Permutations.store_algorithm(%{a: 2, b: 2}) |> Enum.sort() == [
             [:a, :a, :b, :b],
             [:a, :b, :a, :b],
             [:a, :b, :b, :a],
             [:b, :a, :a, :b],
             [:b, :a, :b, :a],
             [:b, :b, :a, :a]
           ]
  end
end
