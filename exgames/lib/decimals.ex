defmodule Exgames.Decimals do
  @moduledoc """
  This module depends on https://hexdocs.pm/decimal/readme.html for most of it's
  calculations. Inputs to functions likely expect a `Decimal.t()` number.

  Care should be taken on controling the precision of these numbers.
  """

  def set_decimal_precision(desired_precision) do
    Decimal.Context.get()
    |> Map.update!(:precision, fn _ -> desired_precision end)
    |> Decimal.Context.set()
  end

  @doc """
  Generates a list (of length `stop`) of continued fractions for the square root
  of `n`.

  ## Examples

    iex> Exgames.continued_fractions_of_square_root_of(2, stop: 5)
    [1, 2, 2, 2, 2]

    iex> Exgames.continued_fractions_of_square_root_of(7, stop: 5)
    [2, 1, 1, 1, 4]
  """
  def continued_fractions_of_square_root_of(n, opts \\ []) do
    stop = Keyword.get(opts, :stop, 100)

    x = Decimal.sqrt(n)

    1..stop
    |> Enum.reduce({x, []}, fn _step, acc ->
      {x, list} = acc
      int = x |> Decimal.round(0, :down) |> Decimal.to_integer()
      new_x = Decimal.sub(x, int)

      {Decimal.div(1, new_x), [int | list]}
    end)
    |> Kernel.elem(1)
    |> Enum.reverse()
  end
end
