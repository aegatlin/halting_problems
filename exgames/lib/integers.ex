defmodule Exgames.Integers do
  require Integer
  alias Exgames, as: E

  def integer?(n), do: Kernel.round(n) == n

  def digit_reverse(n), do: n |> Integer.digits() |> Enum.reverse() |> Integer.undigits()

  def palindrome?(n) when n < 0, do: false
  def palindrome?(n) when n < 10, do: true

  def palindrome?(n) do
    digits = Integer.digits(n)

    1..Integer.floor_div(length(digits), 2)
    |> Enum.all?(fn i ->
      Enum.at(digits, i - 1) == Enum.at(digits, -i)
    end)
  end

  @doc """
  An aliquot sequence is a list of numbers where each member `m` is the
  aliquot_sum of member `m-1`. The sequence stops any of: `0`, the first
  recurrence, a number that exceeds the `:max_element_value`.

  It is an open question in math if there are infinite aliquote sequences, i.e.,
  be careful when using this function because it might recurse infinitly.

  ## Examples

    iex> Exgames.Integers.aliquot_sequence(220)
    [220, 284]
  """
  def aliquot_sequence(n, opts \\ []) do
    max_element_value = Keyword.get(opts, :max_element_value, 1_000_000)

    aliquot_sequence(n, [n], max_element_value: max_element_value) |> Enum.reverse()
  end

  defp aliquot_sequence(n, list, opts) do
    max_element_value = Keyword.fetch!(opts, :max_element_value)

    asum = aliquot_sum(n)

    if asum > max_element_value do
      [asum | list]
    else
      if Enum.any?(list, &(&1 == asum)) do
        list
      else
        aliquot_sequence(asum, [asum | list], max_element_value: max_element_value)
      end
    end
  end

  @doc """
  An aliquot sum is the sum of all the proper divisors of n.

  ## Examples

    # 1 + 2 + 3 + 4 + 6
    iex> Exgames.Integers.aliquot_sum(12)
    16
  """
  def aliquot_sum(n) when n < 1, do: 0

  def aliquot_sum(n) do
    proper_factors(n)
    |> Enum.sum()
  end

  @doc """
  Returns all proper factors of `n`, which is all factors not including `n` itself

  ## Examples

    iex> Exgames.Integers.proper_factors(12)
    [1, 2, 3, 4, 6]
  """
  def proper_factors(n) do
    divisors =
      __MODULE__.Primes.prime_factors(n)
      |> E.Lists.combinations()
      |> Enum.map(&E.Lists.product(&1))
      |> MapSet.new()
      |> MapSet.to_list()

    [1 | divisors]
    |> Enum.reject(&(&1 == n))
  end

  @doc ~S"""
  Checks if two numbers have the same digits in any order.

  ## Examples

      iex> Exgames.Integers.digit_permutation?(123, 321)
      true

      iex> Exgames.Integers.digit_permutation?(123, 456)
      false
  """
  def digit_permutation?(n, m) do
    Integer.digits(n)
    |> Enum.sort() ==
      Integer.digits(m) |> Enum.sort()
  end

  def even?(n) when Integer.is_even(n), do: true
  def even?(n) when Integer.is_odd(n), do: false
  def odd?(n) when Integer.is_odd(n), do: true
  def odd?(n) when Integer.is_even(n), do: false

  def parity?(n, m) do
    cond do
      even?(n) and even?(m) -> true
      odd?(n) and odd?(m) -> true
      true -> false
    end
  end

  @doc ~S"""
  Returns a boolean indicating whether n and m are coprime. Two numbers are
  coprime if their greatest common divisor is 1.
  """
  def coprimes?(n, m) do
    Integer.gcd(n, m) == 1
  end

  @doc ~S"""
  A perfect square is an integer that is the square of another integer.

  ## Examples

      iex> Exgames.Integers.perfect_square?(16)
      true

      iex> Exgames.Integers.perfect_square?(18)
      false
  """
  def perfect_square?(n) do
    square_root = :math.sqrt(n)
    Kernel.round(square_root) ** 2 == n
  end

  @doc ~S"""
  A perfect cube is an integer that is the cube of another integer.

  ## Examples

    This example, 384^3, is known to return 383.99 repeating

      iex> Exgames.Integers.perfect_cube?(56623104)
      true

      iex> Exgames.Integers.perfect_cube?(28)
      false
  """
  def perfect_cube?(n) do
    cube_root = :math.pow(n, 1 / 3)
    Kernel.round(cube_root) ** 3 == n
  end

  @doc ~S"""
  A perfect tesseract is an integer that is the 4th power of another integer.

  ## Examples

      iex> Exgames.Integers.perfect_tesseract?(16)
      true

      iex> Exgames.Integers.perfect_tesseract?(17)
      false
  """
  def perfect_tesseract?(n) do
    fourth_root = :math.pow(n, 1 / 4)
    Kernel.round(fourth_root) ** 4 == n
  end

  def sum_of_integers(n), do: triangle_number(n)

  @doc """
  The Euler totient function returns the number of positive integers not
  exceeding n which are relatively prime to n.

  There are more efficient methods that avoid division if this becomes a
  bottleneck. See Wolfram MathWorld and Wikipedia.
  """
  def totient(n) do
    E.Integers.Primes.prime_factors(n)
    |> Enum.uniq()
    |> Enum.reduce(n, fn p, acc ->
      acc * (1 - 1 / p)
    end)
    |> Kernel.trunc()
  end

  @doc """
  This function returns the list of coprimes that the totient function returns
  the "length" of.
  """
  def totient_list(n) do
    coprimes =
      1..n
      |> Enum.filter(&E.Integers.coprimes?(n, &1))

    coprimes
  end

  @doc """
  Triangle number n is equivalent to the sum of integers 1..n. It can also be
  thought of as the number of dots in an equilateral traingle with base width n.

  OEIC: https://oeis.org/A000217
  """
  def triangle_number(n), do: Kernel.div(n * (n + 1), 2)
  def square_number(n), do: n * n
  def pentagonal_number(n), do: Kernel.div(n * (3 * n - 1), 2)
  def hexagonal_number(n), do: n * (2 * n - 1)
  def heptagonal_number(n), do: Kernel.div(n * (5 * n - 3), 2)
  def octagonal_number(n), do: n * (3 * n - 2)

  def factorial(0), do: 1
  def factorial(n) when n > 0, do: n * factorial(n - 1)

  @doc """
  This is the list of ways you can represent n as a sum of integers, excluding
  [n]. That is, it is off by one with respect to P(n) itself.

  https://mathworld.wolfram.com/PartitionFunctionP.html

  https://en.wikipedia.org/wiki/Partition_function_(number_theory)
  """
  def partition_function_list(n) do
    all_ones? = fn list -> Enum.all?(list, &(&1 == 1)) end

    start = [n]
    # other starts exclude certain partitions, e.g., this one exclude the [n]
    # partition
    # start = [1, n - 1]

    # This should be a Stream if it's unbounded
    1..1_000_000_000_000
    |> Enum.reduce_while({start, [start]}, fn _elem, acc ->
      {cur, all} = acc
      next = p_list_step(cur)
      all = [next | all]

      if all_ones?.(next) do
        {:halt, {next, all}}
      else
        {:cont, {next, all}}
      end
    end)
    |> elem(1)
  end

  defp p_list_step([h | t] = list) do
    sum = Enum.sum(list)

    if h != 1 do
      p_list_fill(t, sum, h - 1)
    else
      sub_list = Enum.drop_while(list, &(&1 == 1))
      [h | t] = sub_list
      p_list_fill(t, sum, h - 1)
    end
  end

  defp p_list_fill(sub_list, _sum, 0), do: sub_list

  defp p_list_fill(sub_list, sum, try) do
    sub_sum = Enum.sum(sub_list)
    sub_sum_try = sub_sum + try

    cond do
      sub_sum_try > sum ->
        p_list_fill(sub_list, sum, try - 1)

      sub_sum_try == sum ->
        [try | sub_list]

      sub_sum_try < sum ->
        p_list_fill([try | sub_list], sum, try)
    end
  end

  @doc """
  P(n) is the permutation function for integer n. This is the Ramanujan
  approximation function of P(n).
  """
  def partition_function_approx(n) do
    c = 1 / (4 * n * :math.sqrt(3))
    d = :math.exp(:math.pi() * :math.sqrt(2 * n / 3))
    c * d
  end

  @doc """
  This is p(n) the partition function for integer n.
  """
  def partition_function(n) when n < 0, do: 0
  def partition_function(0), do: 1
  def partition_function(1), do: 1

  def partition_function(n) do
    1..n
    |> Enum.map_reduce(%{}, fn k, pmap ->
      aval = partition_function_a(k)
      bval = partition_function_b(k, n)
      cval = partition_function_c(k, n)

      pmap =
        Map.put_new_lazy(pmap, bval, fn ->
          partition_function(bval)
        end)

      pmap =
        Map.put_new_lazy(pmap, cval, fn ->
          partition_function(cval)
        end)

      pb = Map.get(pmap, bval)
      pc = Map.get(pmap, cval)
      pkn = aval * (pb + pc)

      {pkn, pmap}
    end)
    |> Kernel.elem(0)
    |> Enum.sum()
  end

  defp partition_function_a(k) do
    -1 ** (k + 1)
  end

  defp partition_function_b(k, n) do
    y = 3 * k - 1
    y = y * (k / 2)
    y = n - y

    yint = Kernel.trunc(y)

    if y != yint do
      exit(:bad_math)
    end

    yint
  end

  defp partition_function_c(k, n) do
    y = 3 * k + 1
    y = y * (k / 2)
    y = n - y

    yint = Kernel.trunc(y)

    if y != yint do
      exit(:bad_math)
    end

    yint
  end
end
