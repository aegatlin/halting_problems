defmodule PriorityQueue do
  @moduledoc """
  A lowest-priority-wins queue.

  If two items have equivalent lowest priority there is no guarantees around
  ordering.

  Items must be unique. This implies `push` is also `update`.
  """

  defstruct queue: %{}

  def new do
    %__MODULE__{}
  end

  def size(q), do: Kernel.map_size(q) - 2

  def push(q, item, priority) do
    Map.put(q, item, priority)
  end

  @doc """
  return {queue, {item, priority}}
  """
  def pop(q) do
    if size(q) == 0 do
      {q, nil}
    else
      {item, priority} =
        q
        |> Map.to_list()
        |> Enum.sort(fn {_k1, v1}, {_k2, v2} -> v1 <= v2 end)
        |> List.first()

      q = Map.delete(q, item)

      {q, {item, priority}}
    end
  end
end
