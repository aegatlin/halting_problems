defmodule Exgames.Lists.SequencesTest do
  use ExUnit.Case

  doctest Exgames.Lists.Sequences

  test "triangle" do
    assert Exgames.Lists.Sequences.triangle(6) == [0, 1, 3, 6, 10, 15, 21]
  end

  test "square" do
    assert Exgames.Lists.Sequences.square(6) == [0, 1, 4, 9, 16, 25, 36]
  end

  test "pentagonal" do
    assert Exgames.Lists.Sequences.pentagonal(6) == [0, 1, 5, 12, 22, 35, 51]
  end

  test "pentagonal_numbers_generalized_list/1" do
    assert Exgames.Lists.Sequences.pentagonal_numbers_generalized_list(list_length: 5) == [
             0,
             1,
             2,
             5,
             7
           ]

    assert Exgames.Lists.Sequences.pentagonal_numbers_generalized_list(list_length: 6) == [
             0,
             1,
             2,
             5,
             7,
             12
           ]
  end

  test "continued_fraction_of_e" do
    assert Exgames.Lists.Sequences.continued_fraction_of_e(0) == []
    assert Exgames.Lists.Sequences.continued_fraction_of_e(1) == [2]
    assert Exgames.Lists.Sequences.continued_fraction_of_e(2) == [2, 1]

    assert Exgames.Lists.Sequences.continued_fraction_of_e(12) == [
             2,
             1,
             2,
             1,
             1,
             4,
             1,
             1,
             6,
             1,
             1,
             8
           ]
  end
end
