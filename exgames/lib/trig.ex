defmodule Exgames.Trig do
  @doc ~S"""
  ## Examples

    Equivalent to `{pi/4, -pi/2, pi/4}`

    iex> Exgames.Trig.angles_of_triangle({[0,0], [1, 0], [1, 1]})

    {0.7853981633974483, -1.5707963267948966, 0.7853981633974483}
  """
  def angles_of_triangle({a, b, c}) do
    {
      angle({a, b, c}),
      angle({b, c, a}),
      angle({c, a, b})
    }
  end

  @doc """
  Computes the angle in radians of the angle of `a`. This is the angle CAB. Or,
  the angle formed by AB, and AC, combined.
  """
  defp angle({a, b, c}) do
    [ax, ay] = a
    [bx, by] = b
    [cx, cy] = c

    ab =
      if ay - by == 0 do
        :math.pi() / 2
      else
        :math.atan((ax - bx) / (ay - by))
      end

    ac =
      if ay - cy == 0 do
        :math.pi() / 2
      else
        :math.atan((ax - cx) / (ay - cy))
      end

    ab - ac
  end
end
