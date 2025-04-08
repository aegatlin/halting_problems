defmodule Exgames.Combinatorics do
  alias Exgames, as: E

  @doc """
  The binomial coefficient, aka "n choose k", aka nCr. It is the number of
  unique unordered subsets of k elements choosen from a fixed set of n elements.
  See my note in Obsidian on binomial coefficients to learn more on theory.

  ## Unimplemented notes

  Allegedly pascal's triangle is a more efficient calculation but I have not
  observed this myself.
  """
  # This is incoherent and stipulated 0
  def choose(n, k) when k > n, do: 0
  def choose(n, k) when k == n, do: 1

  def choose(n, k) do
    dividend = Enum.reduce((k + 1)..n, &(&1 * &2))
    divisor = E.Integers.factorial(n - k)
    Kernel.div(dividend, divisor)
  end

  def pascals_triangle(n) when n < 0, do: []
  def pascals_triangle(0), do: [[1]]

  def pascals_triangle(n) do
    pascals_triangle([[1]], n)
  end

  # end recursion
  defp pascals_triangle(triangle, max) when length(triangle) - 1 == max do
    Enum.reverse(triangle)
  end

  # continue recursion
  defp pascals_triangle([h | _] = triangle, max) do
    next_row = h |> Enum.chunk_every(2, 1) |> Enum.map(&Enum.sum(&1))
    next_row = [1 | next_row]
    pascals_triangle([next_row | triangle], max)
  end
end
