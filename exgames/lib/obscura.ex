defmodule Exgames.Obscura do
  @moduledoc """
  This is where obscure functions that are probably bespoke to a specific task
  will live. On the off-chance they are useful in the future, I will leave them
  here. These function will most likely be listed chronologically.
  """

  alias Exgames, as: E

  @doc """
  Sorts a list of lists of integers cyclically by their smallest first number.

  It won't break the 'cycle' to do a 'true' sort of the elements.

  iex> Exgames.cycle_sort([[6,0,0],[0,1,1],[7,0,0]])
  [[0,1,1],[7,0,0],[6,0,0]]

  iex> Exgames.cycle_sort([[7, 5, 2], [8, 2, 4], [9, 4, 1], [10, 1, 3], [6, 3, 5]])
  [[6, 3, 5], [7, 5, 2], [8, 2, 4], [9, 4, 1], [10, 1, 3]]

  iex> Exgames.cycle_sort([[9,8],[8,7],[7,6],[6,5],[5,4]])
  [[5,4],[9,8],[8,7],[7,6],[6,5]]

  iex> Exgames.cycle_sort([[9,8],[1,0],[8,7],[7,6],[6,5],[5,4]])
  [[1,0],[8,7],[7,6],[6,5],[5,4],[9,8]]
  """
  def cycle_sort(lists) do
    count = length(List.first(lists))

    # The exact amount of sort times required is an optimization, I just blindly
    # made it 'big'
    0..(count * 2)
    |> Enum.reduce(%{lowest: lists, last: lists}, fn _elem, acc ->
      cur = cycle(acc.last)
      last_lowest = acc.lowest |> List.first() |> List.first()
      cur_lowest = cur |> List.first() |> List.first()

      if cur_lowest < last_lowest do
        %{lowest: cur, last: cur}
      else
        %{lowest: acc.lowest, last: cur}
      end
    end)
    |> Map.get(:lowest)
  end

  defp cycle(list) do
    [List.last(list) | Enum.drop(list, -1)]
  end

  @doc ~S"""
  Return a list of numbers where each digit at an index in the index_list is
  replaced with a single digit 0..9, including the original digit. The digit
  length has to remain identical.

  ## Examples

      iex> Exgames.Number.Obscura.digit_family(137, [0, 2])
      [131, 232, 333, 434, 535, 636, 737, 838, 939]

  """
  def digit_family(n, index_list) do
    for j <- 0..9 do
      index_list
      |> Enum.reduce(Integer.digits(n), fn i, d ->
        d |> List.replace_at(i, j)
      end)
      |> Integer.undigits()
    end
    |> Enum.reject(&(length(Integer.digits(n)) != length(Integer.digits(&1))))
  end

  def get_prime_family(n) do
    digits = Integer.digits(n)
    IO.write("#{n}, ")

    MapSet.new(0..(length(digits) - 1))
    |> E.Sets.proper_subsets()
    |> E.Sets.to_subset_list()
    |> Enum.map(&digit_family(n, &1))
    |> Enum.each(fn digit_family ->
      prime_digit_family = digit_family |> Enum.filter(&E.Integers.Primes.prime?(&1))

      if length(prime_digit_family) >= 7 do
        IO.puts("FOUND #{n}")
        IO.inspect(prime_digit_family)
      end
    end)
  end

  @doc ~S"""
  ## Examples

    iex> Exgames.get_lists_of_digit_replacements(12)
    [[02, 12, 22, 32, 42, 52, 62, 72, 82, 92], [10, 11, 12, 13, 14, 15, 16, 17, 18, 19], [00, 11, 22, 33, 44, 55, 66, 77, 88, 99]]
  """
  def get_lists_of_digit_replacements(n) do
    digits = Integer.digits(n)
    index_combinations = E.Lists.combinations(0..(length(digits) - 1))

    index_combinations
    |> Enum.map(&replacer(digits, &1))
    |> Enum.map(fn lists_of_digits ->
      lists_of_digits |> Enum.map(&Integer.undigits(&1))
    end)
  end

  @doc """
  Replace the digits at indicies with 1..9, leave other untouched

  ## Examples

    iex> Exgames.replacer([1, 2, 3], [1])
    [[1, 0, 3], [1, 1, 3], [1, 2, 3], [1, 3, 3], [1, 4, 3], [1, 5, 3], [1, 6, 3], [1, 7, 3], [1, 8, 3], [1, 9, 3]]

    iex> Exgames.replacer([5, 9], [0])
    [[0, 9], [1, 9], [2, 9], [3, 9], [4, 9], [5, 9], [6, 9], [7, 9], [8, 9], [9, 9]]

    iex> Exgames.replacer([2, 3, 7], [0, 2])
    [[0, 3, 0], [1, 3, 1], [2, 3, 2], [3, 3, 3], [4, 3, 4], [5, 3, 5], [6, 3, 6], [7, 3, 7], [8, 3, 8], [9, 3, 9]]
  """
  def replacer(digits, indicies) do
    Enum.map(0..9, fn n ->
      digits
      |> Enum.with_index()
      |> Enum.map(fn {digit, i} ->
        if Enum.member?(indicies, i) do
          n
        else
          digit
        end
      end)
    end)
  end
end
