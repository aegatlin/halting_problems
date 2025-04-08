defmodule Exgames.CombinatoricsTest do
  use ExUnit.Case

  alias Exgames, as: E

  doctest E.Combinatorics

  test "choose/2" do
    assert E.Combinatorics.choose(1, 0) == 1
    assert E.Combinatorics.choose(0, 1) == 0
    assert E.Combinatorics.choose(1, 1) == 1
    assert E.Combinatorics.choose(20, 10) == 184_756
  end

  test "pascals_triangle/1" do
    assert E.Combinatorics.pascals_triangle(-1) == []
    assert E.Combinatorics.pascals_triangle(0) == [[1]]
    assert E.Combinatorics.pascals_triangle(1) == [[1], [1, 1]]
    assert E.Combinatorics.pascals_triangle(2) == [[1], [1, 1], [1, 2, 1]]
    assert E.Combinatorics.pascals_triangle(3) == [[1], [1, 1], [1, 2, 1], [1, 3, 3, 1]]

    assert E.Combinatorics.pascals_triangle(4) == [
             [1],
             [1, 1],
             [1, 2, 1],
             [1, 3, 3, 1],
             [1, 4, 6, 4, 1]
           ]
  end
end
