defmodule Exgames.ListsTests do
  use ExUnit.Case

  alias Exgames, as: E

  doctest E.Lists

  test "combinations/1" do
    assert E.Lists.combinations([]) == []
    assert E.Lists.combinations([1]) == [[1]]
    assert E.Lists.combinations([1, 2]) == [[1], [2], [1, 2]]
    assert E.Lists.combinations([1, 2, 3]) == [[1], [2], [3], [1, 2], [1, 3], [2, 3], [1, 2, 3]]

    assert E.Lists.combinations([2, 2, 3]) == [[2], [2], [3], [2, 2], [2, 3], [2, 3], [2, 2, 3]]
  end

  test "combinations/2" do
    assert E.Lists.combinations([], 0) == []
    assert E.Lists.combinations([], 1) == []
    assert E.Lists.combinations([1], 1) == [[1]]
    assert E.Lists.combinations([1, 2], 2) == [[1, 2]]

    assert E.Lists.combinations([1, 2], 0) == []
    assert E.Lists.combinations([1, 2], 1) == [[1], [2]]
    assert E.Lists.combinations([1, 2], 2) == [[1, 2]]

    assert E.Lists.combinations([2, 2], 1) == [[2], [2]]

    assert E.Lists.combinations([1, 2, 3], 0) == []
    assert E.Lists.combinations([1, 2, 3], 1) == [[1], [2], [3]]
    assert E.Lists.combinations([1, 2, 3], 2) == [[1, 2], [1, 3], [2, 3]]
    assert E.Lists.combinations([1, 2, 3], 3) == [[1, 2, 3]]
  end

  test "cycle/1" do
    assert E.Lists.cycle([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) == nil
    assert E.Lists.cycle([1, 2, 3, 2, 3, 2]) == [[1], [2, 3]]
  end
end
