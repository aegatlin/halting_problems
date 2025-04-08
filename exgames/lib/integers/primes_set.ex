defmodule Exgames.Integers.PSet do
  defstruct [:pset, :plist]

  alias Exgames.Integers.Primes

  def new(max \\ 1_000) do
    IO.puts("sieve with max #{max} started...")
    primes_list = Primes.sieve(max)
    IO.puts("sieve with max #{max} complete")

    %__MODULE__{pset: MapSet.new(primes_list), plist: primes_list}
  end

  def prime?(pset, n) do
    MapSet.member?(pset.pset, n)
  end

  def list(pset) do
    pset.plist
  end
end
