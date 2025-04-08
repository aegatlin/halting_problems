defmodule Exgames.Sets do
  def subsets(set), do: proper_subsets(set) |> MapSet.union(MapSet.new([set]))

  @doc ~S"""
  A proper subset does not include the set itself
  """
  def proper_subsets(set) do
    set
    |> Enum.reduce(MapSet.new([]), fn elem, acc ->
      set |> MapSet.delete(elem) |> subsets() |> MapSet.union(acc)
    end)
  end

  def to_subset_list(set) do
    set
    |> Enum.map(&MapSet.to_list(&1))
    |> Enum.reject(&Enum.empty?(&1))
  end
end
