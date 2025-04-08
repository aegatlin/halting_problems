defmodule Exgames.Integers.Primes do
  alias Exgames, as: E

  @doc ~S"""
  Returns a list of all prime numbers up to and including max.
  """
  def primes_list(max) do
    E.Integers.Primes.sieve(max)
  end

  @doc """
  Returns a map of all numbers up to `max` with key of number and value of boolean where
  true indicates prime and false indicates composite.
  """
  def primes_map(max) do
    nums_false_map =
      1..max
      |> Enum.reduce(%{}, &Map.put(&2, &1, false))

    primes_map =
      primes_list(max)
      |> Enum.reduce(%{}, &Map.put(&2, &1, true))

    Map.merge(nums_false_map, primes_map)
  end

  def prime?(n) when n < 2, do: false
  def prime?(n) when n == 2 or n == 3, do: true

  def prime?(n) do
    # if it is not prime then there are two numbers that multiplied equal n
    # those two numbers are on either side of sqrt(n) which means if we reach
    # sqrt(n) in our search it must be prime.
    Kernel.floor(:math.sqrt(n))
    |> primes_list()
    |> Enum.all?(&(Integer.mod(n, &1) != 0))
  end

  @doc """
  Returns the prime factors on `n` including n itself

  iex> Exgames.Integers.Primes.prime_factors(7)
  [7]
  """
  def prime_factors(n) do
    primes = primes_list(Kernel.floor(:math.sqrt(n)))

    prime_factors(n, [], primes)
  end

  defp prime_factors(n, factors, []), do: Enum.reverse([n | factors])
  defp prime_factors(1, factors, _), do: Enum.reverse(factors)

  defp prime_factors(n, factors, [p | tail_primes] = primes) do
    if Integer.mod(n, p) == 0 do
      prime_factors(Kernel.div(n, p), [p | factors], primes)
    else
      prime_factors(n, factors, tail_primes)
    end
  end

  @doc ~S"""
    The sieve of Eratosthenes is an efficient algorithm for generating a list of
    primes. See my note in Obsidian for more on the theory behind it.

    If `max` is a prime number it will be included in the list.

    ## Unimplemented optimizations

    Would a boolean array implementation be faster?
  """
  def sieve(max) when max < 2, do: []
  def sieve(2), do: [2]
  def sieve(3), do: [2, 3]

  def sieve(max) do
    # Get the stopping point for sieving
    stop = Kernel.floor(:math.sqrt(max))

    # Hard code the removal of evens
    nums = Enum.to_list(3..max//2)
    primes = [2]

    sieve(nums, primes, max, stop)
  end

  defp sieve([], primes, _, _), do: Enum.reverse(primes)

  defp sieve(nums, primes, max, stop) do
    if hd(primes) > stop do
      # stop recursion
      sieve([], Enum.reverse(nums) ++ primes, max, stop)
    else
      # continue recursion
      [nextp | nums_tail] = nums
      nextpsqrd = nextp ** 2

      nums_new =
        Enum.reject(nums_tail, fn n ->
          if n < nextpsqrd do
            # do not reject
            # this is a fast skip
            false
          else
            Integer.mod(n, nextp) == 0
          end
        end)

      primes = [nextp | primes]
      sieve(nums_new, primes, max, stop)
    end
  end
end
