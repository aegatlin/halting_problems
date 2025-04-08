defmodule GraphTest do
  use ExUnit.Case

  test "Graph.neighbors/2" do
    g =
      Graph.new()
      |> Graph.add_vertex(:a)
      |> Graph.add_vertex(:b)
      |> Graph.add_vertex(:c)
      |> Graph.add_edge(:a, :b, 10)
      |> Graph.add_edge(:a, :c, 15)

    assert Graph.neighbors(g, :a) |> Enum.sort() == [:b, :c]
    assert Graph.neighbors(g, :b) == []
    assert Graph.neighbors(g, :c) == []
  end

  test "Graph.edge/3" do
    g =
      Graph.new()
      |> Graph.add_vertex(:a)
      |> Graph.add_vertex(:b)
      |> Graph.add_edge(:a, :b, 10)

    assert Graph.edge(g, :a, :b) == %{weight: 10}
  end

  test "Graph.has_vertex?/2" do
    g =
      Graph.new()
      |> Graph.add_vertex(:a)
      |> Graph.add_vertex(:b)
      |> Graph.add_edge(:a, :b, 10)

    assert Graph.has_vertex?(g, :a)
    assert Graph.has_vertex?(g, :b)
    refute Graph.has_vertex?(g, :c)
  end
end
