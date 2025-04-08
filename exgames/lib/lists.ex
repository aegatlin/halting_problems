defmodule Exgames.Lists do
  alias Exgames, as: E

  @doc """
  Returns the product of all elements in the list.

  ## Examples

    iex> Exgames.Lists.product([2, 3, 4])
    24
  """
  def product(list), do: Enum.reduce(list, 1, &(&1 * &2))

  @doc ~S"""
  Converts a continued fraction list into a fraction.

  Related concepts include: Farey Sequence.

  ## Examples

    iex> Exgames.Lists.fraction_from_continued_fraction([1, 2, 2, 2, 2])
    [41, 29]

    iex> Exgames.Lists.fraction_from_continued_fraction([1, 2, 2])
    [7, 5]

    iex> Exgames.Lists.fraction_from_continued_fraction([2, 1, 2, 1, 1, 4])
    [87, 32]
  """
  def fraction_from_continued_fraction(continued_fraction_list) do
    {list, [start]} = Enum.split(continued_fraction_list, -1)

    list
    |> Enum.reverse()
    |> Enum.reduce([1, start], fn n, acc ->
      [nominator, denominator] = acc
      new_denominator = denominator * n + nominator
      new_nominator = denominator
      [new_nominator, new_denominator]
    end)
    |> Enum.reverse()
  end

  def cycle(list), do: E.Lists.Cycles.cycle(list)

  @doc ~S"""
  Returns all permutations of the list. Permutations get out of hand quickly.
  They are n! in size. Permutations beyond 10 get unreasonable quickly, e.g.,
  15! is 1.3 billion and 20! is 2.4 pentillion (2.4e18).

  ## Examples

      iex> Exgames.Lists.permutations([1, 2, 3])
      [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
  """
  def permutations(list), do: E.Lists.Permutations.permutations(list)

  @doc ~S"""
  While similar to `permutations/1`, a multiset permutation takes advantage of
  the fact that the set has multiple members to run more efficiently when
  compared to `permutations/1` (which assumes unique elements no matter what).

  A multiset is a set where members of the set can repeat.

  ## Examples

      iex> Exgames.Lists.multiset_permutations([1, 1, 3])
      [[1, 1, 3], [1, 3, 1], [3, 1, 1]]
  """
  def multiset_permutations(list), do: E.Lists.Permutations.multiset_permutations(list)

  @doc ~S"""
  Returns all combinations of the list.

  ## Examples

    iex> Exgames.Lists.combinations([1, 2, 3])
    [[1], [2], [3], [1, 2], [1, 3], [2, 3], [1, 2, 3]]
  """
  def combinations(list) do
    0..length(list)
    |> Enum.flat_map(&combinations(list, &1))
  end

  @doc """
  Returns all combinations of the list of size k.
  """
  def combinations(_, 0), do: []
  def combinations(list, k) when length(list) < k, do: []
  def combinations(list, k) when length(list) == k, do: [list]

  def combinations([h | t], k) do
    subcombos_for_h = combinations(t, k - 1)

    combos_for_h =
      if subcombos_for_h |> length > 0 do
        subcombos_for_h |> Enum.map(&[h | &1])
      else
        [[h]]
      end

    combos_for_rest = combinations(t, k)

    combos_for_h ++ combos_for_rest
  end

  def triangle_sequence(n), do: E.Lists.Sequences.triangle(n)
  def square_sequence(n), do: E.Lists.Sequences.square(n)
  def pentagonal_sequence(n), do: E.Lists.Sequences.pentagonal(n)
  def hexagonal_sequence(n), do: E.Lists.Sequences.hexagonal(n)
  def heptagonal_sequence(n), do: E.Lists.Sequences.heptagonal(n)
  def octagonal_sequence(n), do: E.Lists.Sequences.octagonal(n)

  # n < d
  def reduce_fraction([n, d]) do
    pfd = E.Integers.Primes.prime_factors(d)
    pfn = E.Integers.Primes.prime_factors(n)

    common_prime_factor = Enum.find(pfd, fn p -> Enum.any?(pfn, &(&1 == p)) end)

    if common_prime_factor do
      reduce_fraction([
        Integer.floor_div(n, common_prime_factor),
        Integer.floor_div(d, common_prime_factor)
      ])
    else
      [n, d]
    end
  end
end
