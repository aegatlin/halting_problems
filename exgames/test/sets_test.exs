defmodule Exgames.SetsTest do
  use ExUnit.Case

  alias Exgames, as: E

  doctest E.Sets

  describe "subsets/1" do
    test "for the empty set, returns a set containing the empty set" do
      empty_set = MapSet.new()
      subsets = E.Sets.subsets(empty_set)
      assert MapSet.size(subsets) == 1
      assert subsets |> MapSet.member?(MapSet.new())
    end

    test "for a set of 1 element, returns a set containing the empty set and itself" do
      set = MapSet.new([1])
      subsets = E.Sets.subsets(set)
      assert MapSet.size(subsets) == 2
      assert subsets |> MapSet.member?(MapSet.new())
      assert subsets |> MapSet.member?(MapSet.new([1]))
    end

    test "for multiple elements, return set containing subsets" do
      set = MapSet.new([1, 2])
      subsets = E.Sets.subsets(set)
      assert MapSet.size(subsets) == 4
      assert subsets |> MapSet.member?(MapSet.new())
      assert subsets |> MapSet.member?(MapSet.new([1]))
      assert subsets |> MapSet.member?(MapSet.new([2]))
      assert subsets |> MapSet.member?(MapSet.new([1, 2]))
    end
  end

  describe "proper_subsets/1" do
    test "for the empty set, returns the empty set" do
      empty_set = MapSet.new()
      subsets = E.Sets.proper_subsets(empty_set)
      assert MapSet.size(subsets) == 0
    end

    test "for a set of 1 element, returns a set containing the empty set" do
      set = MapSet.new([1])
      subsets = E.Sets.proper_subsets(set)
      assert MapSet.size(subsets) == 1
      assert subsets |> MapSet.member?(MapSet.new())
    end

    test "for multiple elements, return set containing subsets" do
      set = MapSet.new([1, 2])
      subsets = E.Sets.proper_subsets(set)
      assert MapSet.size(subsets) == 3
      assert subsets |> MapSet.member?(MapSet.new())
      assert subsets |> MapSet.member?(MapSet.new([1]))
      assert subsets |> MapSet.member?(MapSet.new([2]))
    end
  end

  describe "to_subset_list/1" do
    test "ignores the empty set" do
      assert MapSet.new() |> E.Sets.subsets() |> E.Sets.to_subset_list() == []
      assert MapSet.new([MapSet.new([])]) |> E.Sets.to_subset_list() == []
      assert MapSet.new() |> E.Sets.to_subset_list() == []
    end

    test "converts the set of subsets into a list of lists" do
      assert MapSet.new([1]) |> E.Sets.subsets() |> E.Sets.to_subset_list() == [[1]]

      assert MapSet.new([1, 2])
             |> E.Sets.subsets()
             |> E.Sets.to_subset_list() == [[1], [2], [1, 2]]
    end
  end
end
