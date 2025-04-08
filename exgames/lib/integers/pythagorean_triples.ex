defmodule Exgames.Integers.PythagoreanTriples do
  alias Exgames, as: E

  @doc """
  These are all pythagorean triples where s = a + b + c exactly
  """
  def pythagorean_triples(s) do
    all_pythagorean_triples(s)
    |> Enum.filter(fn [a, b, c] ->
      a + b + c == s
    end)
  end

  @doc """
  Returns all pythagorean triples less than or equal to s_max.

  s = a + b + c; where (a,b,c) is the triple, e.g., a^2 + b^2 = c^2

  https://mathworld.wolfram.com/PythagoreanTriple.html
  """
  def all_pythagorean_triples(s_max) do
    all_primitive_pythagorean_triples(s_max)
    |> Enum.flat_map(fn [a, b, c] ->
      1..s_max
      |> Enum.to_list()
      |> Enum.reduce_while([], fn k, acc ->
        ka = k * a
        kb = k * b
        kc = k * c

        if ka + kb + kc <= s_max do
          {:cont, [[ka, kb, kc] | acc]}
        else
          {:halt, acc}
        end
      end)
      |> Enum.reverse()
    end)
  end

  @doc """
  Returns all primitive pythagorean triples less than or equal to s_max.

  s = a + b + c; where (a,b,c) is the triple, e.g., a^2 + b^2 = c^2
  """
  def all_primitive_pythagorean_triples(s_max) when s_max < 1, do: []

  def all_primitive_pythagorean_triples(s_max) do
    # It can be proven that if m = sqrt(s) then n is negative, which is
    # impossible, therefore sqrt(s) is an overbound
    m_max = s_max |> :math.sqrt() |> Kernel.ceil()

    all_primitive_pythagorean_triples_m_n(m_max)
    |> Enum.reduce([], fn [m, n], acc ->
      [[a(m, n), b(m, n), c(m, n)] | acc]
    end)
    |> Enum.reverse()
    |> Enum.filter(fn [a, b, c] ->
      a + b + c <= s_max
    end)
  end

  # primitive triples satisfy the following constraints m > n, gcd(m,n) = 1
  # (i.e., are coprime), and have opposite parity (one odd one even)
  # a = m^2 - n^2; b = 2mn; c = m^2 + n^2
  defp all_primitive_pythagorean_triples_m_n(m_max) when m_max < 1, do: []

  defp all_primitive_pythagorean_triples_m_n(m_max) do
    1..m_max
    |> Enum.to_list()
    |> Enum.reduce([], fn m, acc ->
      # efficient parity guarantee
      n_range =
        if E.Integers.even?(m) do
          1..(m - 1)//2
        else
          2..(m - 1)//2
        end

      # efficient m>n guarantee
      subacc =
        n_range
        |> Enum.to_list()
        |> Enum.reduce([], fn n, subacc ->
          if E.Integers.coprimes?(m, n) do
            [[m, n] | subacc]
          else
            subacc
          end
        end)

      acc ++ subacc
    end)
  end

  defp a(m, n, k \\ 1), do: (m ** 2 - n ** 2) * k
  defp b(m, n, k \\ 1), do: 2 * m * n * k
  defp c(m, n, k \\ 1), do: (m ** 2 + n ** 2) * k
end
