defmodule Exgames.PathFindingTest do
  use ExUnit.Case
  alias Exgames, as: E

  test "matrix_2d_to_graph/1" do
    m =
      [
        [131, 673, 234, 103, 18],
        [201, 96, 342, 965, 150],
        [630, 803, 746, 422, 111],
        [537, 699, 497, 121, 956],
        [805, 732, 524, 37, 331]
      ]

    g = E.PathFinding.matrix_2d_to_graph(m, right: true, down: true)

    assert Graph.neighbors(g, [0, 0]) |> Enum.sort() == [[0, 1], [1, 0]]
    assert Graph.has_vertex?(g, [4, 4])
    assert Graph.edge(g, [2, 2], [3, 2]) == %{weight: 497}
    assert Graph.edge(g, [2, 2], [2, 3]) == %{weight: 422}

    g = E.PathFinding.matrix_2d_to_graph(m)

    assert Graph.edge(g, [2, 2], [3, 2]) == %{weight: 497}
    assert Graph.edge(g, [2, 2], [2, 3]) == %{weight: 422}
    assert Graph.edge(g, [2, 2], [1, 2]) == %{weight: 342}
    assert Graph.edge(g, [2, 2], [2, 1]) == %{weight: 803}
  end

  test "dijkstras/1 with 2x2 matrix" do
    g =
      [
        [5, 10],
        [8, 1]
      ]
      |> E.PathFinding.matrix_2d_to_graph(right: true, down: true)

    assert E.PathFinding.dijkstras(g, [0, 0], [1, 1]) == 9
  end

  test "dijkstras/1 with 5x5 matrix" do
    m =
      [
        [131, 673, 234, 103, 18],
        [201, 96, 342, 965, 150],
        [630, 803, 746, 422, 111],
        [537, 699, 497, 121, 956],
        [805, 732, 524, 37, 331]
      ]

    g = E.PathFinding.matrix_2d_to_graph(m, right: true, down: true)

    actual = E.PathFinding.dijkstras(g, [0, 0], [4, 4])
    assert actual == 2296

    g = E.PathFinding.matrix_2d_to_graph(m)

    actual = E.PathFinding.dijkstras(g, [0, 0], [4, 4])
    assert actual == 2166
  end
end
