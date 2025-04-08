defmodule Exgames.Lists.Permutations do
  @moduledoc """
  There are two permutations currently supported, permutations proper, and
  multiset permutations.

  A multiset is essentially a list with repeat elements. E.g., a list of a
  20-digit number will repeat digits because there are only 10 digits in the set
  of all (base 10) digits (0..9).

  Regular permutations are the exhaustive rearrangement of elements. You can
  provide a multiset to `permuations/1` if you want because the algorithm is
  essentially list-index based.

  Multiset permutations take advantage of the fact that repeat elements are in
  the set creating a more efficient algorithm.
  """

  @doc ~S"""
  Returns all permutations of the list. Permutations get out of hand quickly.
  They are n! in size. Permutations beyond 10 get unreasonable quickly, e.g.,
  15! is 1.3 billion and 20! is 2.4 pentillion (2.4e18).

  ## Examples

      iex> Exgames.Lists.Permutations.permutations([1, 2, 3])
      [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
  """
  def permutations([]), do: [[]]

  def permutations(list) do
    list
    |> Enum.flat_map(fn elem ->
      (list -- [elem])
      |> permutations()
      |> Enum.map(&[elem | &1])
    end)
  end

  @doc ~S"""
  Returns all unique permutations of the list. If `list` has repeat elements
  this will likely be more performant.

  ## Examples

      iex> Exgames.Lists.Permutations.multiset_permutations([1, 2, 2])
      [[1, 2, 2], [2, 1, 2], [2, 2, 1]]
  """
  def multiset_permutations(list) do
    # build the store
    store =
      list
      |> Enum.reduce(%{}, fn elem, acc ->
        Map.update(acc, elem, 1, &(&1 + 1))
      end)

    store_algorithm(store)
  end

  def store_algorithm(store) when map_size(store) == 0, do: [[]]

  def store_algorithm(store) do
    store
    |> Map.keys()
    |> Enum.flat_map(fn k ->
      store
      |> Map.get_and_update(k, fn v ->
        if v == 1 do
          :pop
        else
          {v, v - 1}
        end
      end)
      # Map.get_and_update returns {old_v, new_map}
      # This elem calls gets us back to the map pipeline
      |> Kernel.elem(1)
      |> store_algorithm()
      |> Enum.map(&[k | &1])
    end)
  end
end
