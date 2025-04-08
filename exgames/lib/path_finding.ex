defmodule Exgames.PathFinding do
  alias Graph
  alias PriorityQueue

  def matrix_2d_to_graph(matrix, opts \\ [right: true, left: true, up: true, down: true]) do
    right? = Keyword.get(opts, :right, false)
    left? = Keyword.get(opts, :left, false)
    up? = Keyword.get(opts, :up, false)
    down? = Keyword.get(opts, :down, false)

    graph =
      matrix
      |> Enum.with_index()
      |> Enum.reduce(Graph.new(), fn {row, i}, acc ->
        row
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {_cell, j}, subacc ->
          Graph.add_vertex(subacc, [i, j])
        end)
      end)

    graph =
      graph.vertices
      |> Enum.reduce(graph, fn [i, j] = cur, acc ->
        right = [i, j + 1]

        acc =
          if right? and Graph.has_vertex?(acc, right) do
            right_value = matrix |> Enum.at(i) |> Enum.at(j + 1)
            Graph.add_edge(acc, cur, right, right_value)
          else
            acc
          end

        left = [i, j - 1]

        acc =
          if left? and Graph.has_vertex?(acc, left) do
            left_value = matrix |> Enum.at(i) |> Enum.at(j - 1)
            Graph.add_edge(acc, cur, left, left_value)
          else
            acc
          end

        down = [i + 1, j]

        acc =
          if down? and Graph.has_vertex?(acc, down) do
            down_value = matrix |> Enum.at(i + 1) |> Enum.at(j)
            Graph.add_edge(acc, cur, down, down_value)
          else
            acc
          end

        up = [i - 1, j]

        acc =
          if up? and Graph.has_vertex?(acc, up) do
            up_value = matrix |> Enum.at(i - 1) |> Enum.at(j)
            Graph.add_edge(acc, cur, up, up_value)
          else
            acc
          end

        acc
      end)

    graph
  end

  def dijkstras(graph, vertex_start, vertex_end) do
    {q, map} = d_build_q_and_map(graph, vertex_start)

    dd = %{graph: graph, map: map, q: q}

    dd =
      1..MapSet.size(graph.vertices)
      |> Enum.to_list()
      |> Enum.reduce(dd, fn _i, acc ->
        d_vertex(acc)
      end)

    dd.map[vertex_end]
  end

  defp d_build_q_and_map(graph, vertex_start) do
    graph.vertices
    |> Enum.reduce({PriorityQueue.new(), Map.new()}, fn vertex, {q, map} ->
      if vertex == vertex_start do
        q = PriorityQueue.push(q, vertex, 0)
        map = Map.put(map, vertex, 0)
        {q, map}
      else
        q = PriorityQueue.push(q, vertex, :infinity)
        {q, map}
      end
    end)
  end

  defp d_vertex(dd) do
    {q, v} = PriorityQueue.pop(dd.q)

    if !v do
      dd
    else
      {vertex, vertex_distance} = v

      dd = %{dd | q: q}

      neighbors = Graph.neighbors(dd.graph, vertex)

      neighbors
      |> Enum.reduce(dd, fn neighbor, acc ->
        edge = Graph.edge(acc.graph, vertex, neighbor)
        cur_distance = vertex_distance + edge.weight
        prev_distance = Map.get(acc.map, neighbor)

        cond do
          !prev_distance ->
            %{
              acc
              | map: Map.put(acc.map, neighbor, cur_distance),
                q: PriorityQueue.push(acc.q, neighbor, cur_distance)
            }

          prev_distance > cur_distance ->
            %{
              acc
              | map: Map.put(acc.map, neighbor, cur_distance),
                q: PriorityQueue.push(acc.q, neighbor, cur_distance)
            }

          prev_distance <= cur_distance ->
            acc
        end
      end)
    end
  end
end
