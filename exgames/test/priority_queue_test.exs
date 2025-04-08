defmodule PriorityQueueTest do
  use ExUnit.Case

  test "pop/1" do
    q =
      PriorityQueue.new()
      |> PriorityQueue.push(:a, 5)
      |> PriorityQueue.push(:b, 3)

    assert {q, {:b, 3}} = PriorityQueue.pop(q)
    assert {q, {:a, 5}} = PriorityQueue.pop(q)
    assert {q, nil} = PriorityQueue.pop(q)
    assert {_q, nil} = PriorityQueue.pop(q)
  end

  test "size/1" do
    q =
      PriorityQueue.new()
      |> PriorityQueue.push(:a, 5)
      |> PriorityQueue.push(:b, 3)

    assert PriorityQueue.size(q) == 2
  end
end
