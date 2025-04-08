defmodule Exgames.Lists.Sequences do
  @moduledoc """
  Sequences are lists of integers

  Simple sequences can be generated using ranges and Enum.to_list, e.g., 2-digit
  even numbers are `Enum.to_list(100..998//2)
  """
  alias Exgames, as: E

  @doc ~S"""
  Returns the fibonacci sequence as a list of length `n`.

  ## Examples

    iex> Exgames.Lists.Sequences.fibonacci(10)
    [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
  """
  def fibonacci(n) when n < 0, do: []
  def fibonacci(0), do: [0]
  def fibonacci(1), do: [0, 1]

  def fibonacci(n) do
    2..n
    |> Enum.reduce([1, 0], fn _i, acc ->
      next = acc |> Enum.take(2) |> Enum.sum()

      [next | acc]
    end)
    |> Enum.reverse()
  end

  @doc ~S"""
  The continued fraction of Euler's number is a way of representing an
  approximation of `e`.

  iex> Exgames.Lists.Sequences.continued_fraction_of_e(10)
  [2, 1, 2, 1, 1, 4, 1, 1, 6, 1]
  """
  def continued_fraction_of_e(0), do: []

  def continued_fraction_of_e(length) do
    0..(length - 1)
    |> Enum.map(fn i ->
      case i do
        i when i == 0 ->
          2

        i when i == 1 ->
          1

        i ->
          x = i + 1

          if Integer.mod(x, 3) == 0 do
            Integer.floor_div(x, 3) * 2
          else
            1
          end
      end
    end)
  end

  @doc """
  `n` is the nth triangle number. `0` is the 0th, `1` is the first, `3` is the
  second, etc. So you can read this as "up to the nth triangle number".

  iex> Exgames.Lists.Sequences.triangle(4)
  [0, 1, 3, 6, 10]
  """
  def triangle(n), do: triangle([0], n)
  defp triangle(list, max) when length(list) == max + 1, do: Enum.reverse(list)
  defp triangle(list = [h | _], max), do: triangle([h + length(list) | list], max)

  @doc """
  `n` is the nth triangle number. `0` is the 0th, `1` is the first, `3` is the
  second, etc. So you can read this as "up to the nth square number".

  iex> Exgames.Lists.Sequences.square(4)
  [0, 1, 4, 9, 16]
  """
  def square(n), do: square([0], n)
  defp square(list, max) when length(list) == max + 1, do: Enum.reverse(list)
  defp square(list, max), do: square([length(list) ** 2 | list], max)

  @doc """
  https://oeis.org/A000326
  """
  def pentagonal(n), do: pentagonal([0], n)
  defp pentagonal(list, max) when length(list) == max + 1, do: Enum.reverse(list)

  defp pentagonal(list, max) do
    a = length(list)
    b = 2 * a - 1

    next =
      a..b
      |> Enum.to_list()
      |> Enum.sum()

    pentagonal([next | list], max)
  end

  @doc """
  https://oeis.org/A000384
  """
  def hexagonal(n) do
    [h | t] = triangle(n * 2)
    [h | t |> Enum.take_every(2)]
  end

  @doc """
  https://oeis.org/A000566
  """
  def heptagonal(n), do: heptagonal([], n)

  def heptagonal(list, max) do
    cur = length(list)

    if cur < max + 1 do
      heptagonal([E.Integers.heptagonal_number(cur) | list], max)
    else
      Enum.reverse(list)
    end
  end

  @doc """
  https://oeis.org/A000567
  """
  def octagonal(n), do: octagonal([], n)

  def octagonal(list, max) do
    cur = length(list)

    if cur < max + 1 do
      octagonal([E.Integers.octagonal_number(cur) | list], max)
    else
      Enum.reverse(list)
    end
  end
end
