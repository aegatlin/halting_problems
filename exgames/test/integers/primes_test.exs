defmodule Exgames.Integers.PrimesTest do
  use ExUnit.Case

  alias Exgames, as: E

  doctest E.Integers.Primes

  test "sieve/1" do
    assert E.Integers.Primes.sieve(-1) == []
    assert E.Integers.Primes.sieve(0) == []
    assert E.Integers.Primes.sieve(1) == []
    assert E.Integers.Primes.sieve(2) == [2]
    assert E.Integers.Primes.sieve(10) == [2, 3, 5, 7]
    assert E.Integers.Primes.sieve(11) == [2, 3, 5, 7, 11]
    # 7919 is the 1000th prime number
    assert E.Integers.Primes.sieve(7920) |> length == 1000
  end

  test "prime_factors/1" do
    assert E.Integers.Primes.prime_factors(4) == [2, 2]
    assert E.Integers.Primes.prime_factors(2) == [2]
    assert E.Integers.Primes.prime_factors(9) == [3, 3]
    assert E.Integers.Primes.prime_factors(10) == [2, 5]
  end

  test "prime?/1" do
    refute E.Integers.Primes.prime?(-1)
    refute E.Integers.Primes.prime?(0)
    refute E.Integers.Primes.prime?(1)
    assert E.Integers.Primes.prime?(2)
    assert E.Integers.Primes.prime?(3)
    refute E.Integers.Primes.prime?(10)
    assert E.Integers.Primes.prime?(23)
  end

  test "primes_list/1" do
    assert E.Integers.Primes.primes_list(10) == [2, 3, 5, 7]
    assert E.Integers.Primes.primes_list(20) == [2, 3, 5, 7, 11, 13, 17, 19]
  end

  test "primes_map/1" do
    assert E.Integers.Primes.primes_map(10) == %{
             1 => false,
             2 => true,
             3 => true,
             4 => false,
             5 => true,
             6 => false,
             7 => true,
             8 => false,
             9 => false,
             10 => false
           }
  end
end
