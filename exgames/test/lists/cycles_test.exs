defmodule Exgames.Lists.CyclesTest do
  use ExUnit.Case

  alias Exgames, as: E

  doctest Exgames.Lists.Cycles

  describe "cycle/1" do
    test "works with lists of atoms" do
      assert [:a, :b, :c, :d, :c, :d, :c, :d] |> E.Lists.Cycles.cycle() == [[:a, :b], [:c, :d]]
    end

    test "works with lists of numbers" do
      assert [9, 8, 7, 1, 2, 1, 2, 1, 2] |> E.Lists.Cycles.cycle() == [[9, 8, 7], [1, 2]]
      assert [9, 1, 1] |> E.Lists.Cycles.cycle() == [[9], [1]]
      assert [9, 9, 1, 1] |> E.Lists.Cycles.cycle() == nil
      assert [9, 9, 1, 1, 1] |> E.Lists.Cycles.cycle() == [[9, 9], [1]]
    end
  end

  test "pure_cycle/1" do
    assert [] |> E.Lists.Cycles.pure_cycle() == nil

    assert [1] |> E.Lists.Cycles.pure_cycle() == nil
    assert [1, 1] |> E.Lists.Cycles.pure_cycle() == [1]
    assert [1, 1] |> E.Lists.Cycles.pure_cycle(min_cycles: 3) == nil
    assert [1, 1, 1] |> E.Lists.Cycles.pure_cycle(min_cycles: 3) == [1]

    assert [1, 2] |> E.Lists.Cycles.pure_cycle() == nil
    assert [1, 2, 1] |> E.Lists.Cycles.pure_cycle() == nil
    assert [1, 2, 1, 2] |> E.Lists.Cycles.pure_cycle() == [1, 2]
    assert [1, 2, 1, 2, 1] |> E.Lists.Cycles.pure_cycle() == [1, 2]

    assert [1, 2, 1, 2, 1, 2, 1, 2] |> E.Lists.Cycles.pure_cycle() == [1, 2]
    assert [3, 2, 1, 3, 2, 1] |> E.Lists.Cycles.pure_cycle() == [3, 2, 1]
    assert [3, 2, 1, 3, 2, 2] |> E.Lists.Cycles.pure_cycle() == nil
    assert [3, 2, 1, 3, 2, 1, 3, 2, 1] |> E.Lists.Cycles.pure_cycle(min_cycles: 3) == [3, 2, 1]
    assert [3, 2, 1, 3, 2, 1, 3, 2] |> E.Lists.Cycles.pure_cycle(min_cycles: 3) == nil
  end
end
