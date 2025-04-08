defmodule Exgames.Obscura.Roman do
  @doc ~S"""
  given integer n turn it into a minimal roman numeral

  iex> Exgames.Obscura.Roman.to_roman(2)
  "II"

  iex> Exgames.Obscura.Roman.to_roman(4)
  "IV"

  iex> Exgames.Obscura.Roman.to_roman(5)
  "V"

  iex> Exgames.Obscura.Roman.to_roman(8)
  "VIII"

  iex> Exgames.Obscura.Roman.to_roman(9)
  "IX"

  iex> Exgames.Obscura.Roman.to_roman(10)
  "X"

  iex> Exgames.Obscura.Roman.to_roman(11)
  "XI"

  iex> Exgames.Obscura.Roman.to_roman(14)
  "XIV"

  iex> Exgames.Obscura.Roman.to_roman(15)
  "XV"

  iex> Exgames.Obscura.Roman.to_roman(16)
  "XVI"

  iex> Exgames.Obscura.Roman.to_roman(49)
  "XLIX"

  iex> Exgames.Obscura.Roman.to_roman(50)
  "L"

  iex> Exgames.Obscura.Roman.to_roman(51)
  "LI"

  iex> Exgames.Obscura.Roman.to_roman(444)
  "CDXLIV"

  iex> Exgames.Obscura.Roman.to_roman(977)
  "CMLXXVII"

  iex> Exgames.Obscura.Roman.to_roman(999)
  "CMXCIX"

  iex> Exgames.Obscura.Roman.to_roman(1404)
  "MCDIV"

  iex> Exgames.Obscura.Roman.to_roman(1606)
  "MDCVI"

  iex> Exgames.Obscura.Roman.to_roman(1620)
  "MDCXX"
  """
  def to_roman(n) do
    cond do
      n <= 0 ->
        ""

      n < 4 ->
        "i" <> to_roman(n - 1)

      n == 4 ->
        "iv"

      5 <= n and n <= 8 ->
        "v" <> to_roman(n - 5)

      n == 9 ->
        "ix"

      10 <= n and n <= 39 ->
        "x" <> to_roman(n - 10)

      40 <= n and n <= 49 ->
        "xl" <> to_roman(n - 40)

      50 <= n and n <= 89 ->
        "l" <> to_roman(n - 50)

      90 <= n and n <= 99 ->
        "xc" <> to_roman(n - 90)

      100 <= n and n <= 399 ->
        "c" <> to_roman(n - 100)

      400 <= n and n <= 499 ->
        "cd" <> to_roman(n - 400)

      500 <= n and n <= 899 ->
        "d" <> to_roman(n - 500)

      900 <= n and n <= 999 ->
        "cm" <> to_roman(n - 900)

      1000 <= n ->
        "m" <> to_roman(n - 1000)
    end
    |> String.upcase()
  end

  @doc ~S"""
  iex> Exgames.Obscura.Roman.roman_to_int("II")
  2

  iex> Exgames.Obscura.Roman.roman_to_int("IV")
  4

  iex> Exgames.Obscura.Roman.roman_to_int("V")
  5

  iex> Exgames.Obscura.Roman.roman_to_int("VI")
  6

  iex> Exgames.Obscura.Roman.roman_to_int("IX")
  9

  iex> Exgames.Obscura.Roman.roman_to_int("X")
  10

  iex> Exgames.Obscura.Roman.roman_to_int("XI")
  11

  iex> Exgames.Obscura.Roman.roman_to_int("XIV")
  14

  iex> Exgames.Obscura.Roman.roman_to_int("XVI")
  16

  iex> Exgames.Obscura.Roman.roman_to_int("XLIX")
  49

  iex> Exgames.Obscura.Roman.roman_to_int("L")
  50

  iex> Exgames.Obscura.Roman.roman_to_int("LI")
  51

  iex> Exgames.Obscura.Roman.roman_to_int("CDXLIV")
  444

  iex> Exgames.Obscura.Roman.roman_to_int("CMLXXVII")
  977

  iex> Exgames.Obscura.Roman.roman_to_int("CMXCIX")
  999

  iex> Exgames.Obscura.Roman.roman_to_int("MCDIV")
  1404

  iex> Exgames.Obscura.Roman.roman_to_int("MDCVI")
  1606

  iex> Exgames.Obscura.Roman.roman_to_int("MDCXX")
  1620

  iex> Exgames.Obscura.Roman.roman_to_int("IL")
  nil

  iex> Exgames.Obscura.Roman.roman_to_int("XM")
  nil
  """
  def roman_to_int(s) do
    x =
      s
      |> String.downcase()
      |> String.slice(0..1)

    cond do
      x == "" ->
        0

      x == "iv" ->
        4

      x == "ix" ->
        9

      x == "xl" ->
        40 + roman_to_int(String.slice(s, 2..-1//1))

      x == "xc" ->
        90 + roman_to_int(String.slice(s, 2..-1//1))

      x == "cd" ->
        400 + roman_to_int(String.slice(s, 2..-1//1))

      x == "cm" ->
        900 + roman_to_int(String.slice(s, 2..-1//1))

      String.match?(x, ~r/^i[ivx]?$/) ->
        1 + roman_to_int(String.slice(s, 1..-1//1))

      String.match?(x, ~r/^v.?$/) ->
        5 + roman_to_int(String.slice(s, 1..-1//1))

      String.match?(x, ~r/^x[ivxlc]?$/) ->
        10 + roman_to_int(String.slice(s, 1..-1//1))

      String.match?(x, ~r/^l.?/) ->
        50 + roman_to_int(String.slice(s, 1..-1//1))

      String.match?(x, ~r/^c.?/) ->
        100 + roman_to_int(String.slice(s, 1..-1//1))

      String.match?(x, ~r/^d.?/) ->
        500 + roman_to_int(String.slice(s, 1..-1//1))

      String.match?(x, ~r/^m.?/) ->
        1000 + roman_to_int(String.slice(s, 1..-1//1))

      true ->
        nil
    end
  end
end
