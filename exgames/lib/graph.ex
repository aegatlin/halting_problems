defmodule Graph do
  defstruct vertices: MapSet.new(),
            edges: %{},
            weights: %{}

  def new do
    %__MODULE__{}
  end

  def add_vertex(graph, vertex) do
    %{graph | vertices: MapSet.put(graph.vertices, vertex)}
  end

  def has_vertex?(graph, vertex) do
    MapSet.member?(graph.vertices, vertex)
  end

  def add_edge(graph, vertex_from, vertex_to, weight) do
    %{
      graph
      | vertices:
          graph.vertices
          |> MapSet.put(vertex_from)
          |> MapSet.put(vertex_to),
        edges:
          graph.edges
          |> Map.update(vertex_from, [vertex_to], &[vertex_to | &1]),
        weights:
          graph.weights
          |> Map.put({vertex_from, vertex_to}, weight)
    }
  end

  def edge(graph, vertex_from, vertex_to) do
    weight = graph.weights |> Map.fetch!({vertex_from, vertex_to})

    %{weight: weight}
  end

  def neighbors(graph, vertex) do
    graph.edges |> Map.get(vertex, [])
  end
end
