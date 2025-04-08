defmodule Exgames.MixProject do
  use Mix.Project

  def project do
    [
      app: :exgames,
      version: "0.0.1",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Exgames.Application, %{}}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:benchee, "~> 1.0", only: :dev},
      {:decimal, "~> 2.0"}
    ]
  end

  defp aliases do
    [
      r: "run lib/run.exs"
    ]
  end
end
