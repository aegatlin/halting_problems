defmodule Exgames.Integers.PythagoreanTriplesTest do
  use ExUnit.Case

  alias Exgames, as: E

  doctest E.Integers.PythagoreanTriples

  test "pythagorean_triples/1" do
    assert E.Integers.PythagoreanTriples.pythagorean_triples(120) == [
             [30, 40, 50],
             [20, 48, 52],
             [45, 24, 51]
           ]

    assert E.Integers.PythagoreanTriples.pythagorean_triples(1000) == [[375, 200, 425]]
  end

  test "all_pythagorean_triples/1" do
    assert E.Integers.PythagoreanTriples.all_pythagorean_triples(-1) == []
    assert E.Integers.PythagoreanTriples.all_pythagorean_triples(0) == []
    assert E.Integers.PythagoreanTriples.all_pythagorean_triples(6) == []
    assert E.Integers.PythagoreanTriples.all_pythagorean_triples(12) == [[3, 4, 5]]

    assert E.Integers.PythagoreanTriples.all_pythagorean_triples(30) == [
             [3, 4, 5],
             [6, 8, 10],
             [5, 12, 13]
           ]
  end

  test "all_primitive_pythagorean_triples/1" do
    assert E.Integers.PythagoreanTriples.all_primitive_pythagorean_triples(-1) == []
    assert E.Integers.PythagoreanTriples.all_primitive_pythagorean_triples(0) == []
    assert E.Integers.PythagoreanTriples.all_primitive_pythagorean_triples(6) == []
    assert E.Integers.PythagoreanTriples.all_primitive_pythagorean_triples(12) == [[3, 4, 5]]

    assert E.Integers.PythagoreanTriples.all_primitive_pythagorean_triples(30) == [
             [3, 4, 5],
             [5, 12, 13]
           ]
  end
end
