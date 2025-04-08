defmodule ExgamesTest do
  @moduledoc """
  Do not delete this test even if Exgames.run is empty because we will want it
  for running doctests on helper functions for when new problems are
  attempted.
  """
  use ExUnit.Case

  doctest Exgames
  doctest Exgames.Obscura.Poker
  doctest Exgames.Obscura.Roman
end
