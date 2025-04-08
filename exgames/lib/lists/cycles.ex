defmodule Exgames.Lists.Cycles do
  @doc """
  Detects if a cycle is present in a list and otherwise returns `nil`. The
  initial integers do not need to be part of the cycle but the cycle once
  present does need to continue through the end of the list.

  ## Examples

  Avoids cycle detection that occurs too late in the list. The cycle must begin
  in the first half of the list to be detected.

    iex> Exgames.Lists.Cycles.cycle([9, 9, 9, 9, 1, 1])
    nil

    iex> Exgames.Lists.Cycles.cycle([9, 9, 9, 1, 1, 1])
    nil

    iex> Exgames.Lists.Cycles.cycle([9, 9, 1, 1, 1, 1])
    [[9, 9], [1]]
  """
  def cycle(list) do
    max_i = Kernel.round(length(list) / 2) - 1

    0..max_i
    |> Enum.reduce_while(nil, fn index, _acc ->
      non_cycle = Enum.take(list, index)

      cycle =
        list
        |> Enum.drop(index)
        |> pure_cycle()

      if cycle do
        {:halt, [non_cycle, cycle]}
      else
        {:cont, nil}
      end
    end)
  end

  @doc """
  Pure cycles have no non-cyclic elements at the start, i.e., every element in
  the list is a part of the cycle.
  """
  def pure_cycle(list, opts \\ [])
  def pure_cycle([], _opts), do: nil

  def pure_cycle(list, opts) do
    min_cycles = Keyword.get(opts, :min_cycles, 2)

    max_chunk_size = Integer.floor_div(length(list), min_cycles)

    if max_chunk_size < 1 do
      nil
    else
      1..max_chunk_size
      |> Enum.reduce_while(nil, fn chunk_size, _acc ->
        cycle = Enum.take(list, chunk_size)

        list
        |> Enum.chunk_every(chunk_size)
        |> case do
          chunks when length(chunks) < min_cycles ->
            {:cont, nil}

          chunks ->
            chunks
            |> Enum.all?(fn chunk ->
              # the last chunk might not be full length
              chunk == Enum.take(cycle, length(chunk))
            end)
            |> if do
              {:halt, cycle}
            else
              {:cont, nil}
            end
        end
      end)
    end
  end
end
