defmodule Exgames.Obscura.Poker do
  @moduledoc """
  Let a card be defined as %{rank, suit}. A hand is 5 cards.
  """

  def outcome(hand1, hand2) do
    cond do
      value(hand1) > value(hand2) ->
        -1

      value(hand1) < value(hand2) ->
        1

      true ->
        IO.puts("unknown")
        IO.inspect(hand1)
        IO.inspect(value(hand1))
        IO.inspect(hand2)
        IO.inspect(value(hand2))
        IO.puts("\n\n")
        0
    end
  end

  def value(hand) do
    cond do
      royal_flush?(hand) ->
        9_000_000

      straight_flush?(hand) ->
        8_000_000 + highest_rank(hand) * 1_000

      four_of_a_kind?(hand) ->
        7_000_000 + four_of_a_kind_kicker(hand) * 1_000

      full_house?(hand) ->
        6_000_000

      flush?(hand) ->
        5_000_000 + highest_rank(hand) * 1_000

      straight?(hand) ->
        4_000_000 + highest_rank(hand) * 1_000

      three_of_a_kind?(hand) ->
        3_000_000 + three_of_a_kind_kicker(hand) * 1_000

      two_pairs?(hand) ->
        2_000_000

      one_pair?(hand) ->
        1_000_000 + one_pair_pair_value(hand) * 1_000 + one_pair_high_and_kicker(hand)

      true ->
        high_card_value(hand)
    end
  end

  @doc """
  Returns the value of the pair in a one pair hand.

  iex> Exgames.Obscura.Poker.one_pair_pair_value([%{rank: 2, suit: :hearts}, %{rank: 2, suit: :diamonds}, %{rank: 4, suit: :clubs}, %{rank: 5, suit: :spades}, %{rank: 10, suit: :clubs}])
  2
  """
  def one_pair_pair_value(hand) do
    hand
    |> Enum.map(& &1.rank)
    |> Enum.sort()
    |> Enum.chunk_by(& &1)
    |> Enum.filter(&(length(&1) >= 2))
    |> List.flatten()
    |> List.last()
  end

  @doc ~S"""
  Returns the highest rank of a hand.

  iex> Exgames.Obscura.Poker.highest_rank([%{rank: 2, suit: :hearts}, %{rank: 10, suit: :diamonds}, %{rank: 4, suit: :clubs}, %{rank: 5, suit: :spades}, %{rank: 10, suit: :clubs}])
  10
  """
  def highest_rank(hand) do
    hand |> Enum.map(& &1.rank) |> Enum.sort() |> List.last()
  end

  @doc ~S"""
  Returns the kicker in known four of a kind hands.

  iex> Exgames.Obscura.Poker.four_of_a_kind_kicker([%{rank: 2, suit: :hearts}, %{rank: 2, suit: :diamonds}, %{rank: 2, suit: :clubs}, %{rank: 2, suit: :spades}, %{rank: 10, suit: :clubs}])
  10
  """
  def four_of_a_kind_kicker(hand) do
    hand
    |> Enum.map(& &1.rank)
    |> Enum.reduce(MapSet.new(), fn elem, acc ->
      if MapSet.member?(acc, elem) do
        MapSet.delete(acc, elem)
      else
        MapSet.put(acc, elem)
      end
    end)
    |> MapSet.to_list()
    |> List.first()
  end

  @doc ~S"""
    iex> Exgames.Obscura.Poker.three_of_a_kind_kicker([%{rank: 2, suit: :hearts}, %{rank: 2, suit: :diamonds}, %{rank: 2, suit: :clubs}, %{rank: 5, suit: :spades}, %{rank: 10, suit: :clubs}])
    10
  """
  def three_of_a_kind_kicker(hand) do
    hand
    |> Enum.map(& &1.rank)
    |> Enum.sort()
    |> Enum.chunk_by(& &1)
    |> Enum.reject(&(length(&1) == 3))
    |> List.flatten()
    |> Enum.sort()
    |> List.last()
  end

  @doc """
  iex> Exgames.Obscura.Poker.one_pair_high_and_kicker([%{rank: 2, suit: :hearts}, %{rank: 10, suit: :diamonds}, %{rank: 4, suit: :clubs}, %{rank: 5, suit: :spades}, %{rank: 10, suit: :clubs}])
  54
  """
  def one_pair_high_and_kicker(hand) do
    [high, kick] =
      hand
      |> Enum.map(& &1.rank)
      |> Enum.reduce(MapSet.new(), fn elem, acc ->
        if MapSet.member?(acc, elem) do
          MapSet.delete(acc, elem)
        else
          MapSet.put(acc, elem)
        end
      end)
      |> MapSet.to_list()
      |> Enum.sort()
      |> Enum.reverse()
      |> Enum.take(2)

    high * 10 + kick
  end

  @doc """
  This is a naive implementation that implicitly assumes it's only being called
  when there are no ranks, i.e., no flush, two pair, etc. This means it can
  "just" pick the highest card.

  iex> Exgames.Obscura.Poker.high_card_value([%{rank: 2, suit: :hearts}, %{rank: 10, suit: :diamonds}, %{rank: 4, suit: :clubs}, %{rank: 5, suit: :spades}, %{rank: 6, suit: :hearts}])
  10
  """
  def high_card_value(hand) do
    hand |> Enum.map(& &1.rank) |> Enum.sort() |> List.last()
  end

  @doc ~S"""
  iex> Exgames.Obscura.Poker.straight_flush?([%{rank: 10, suit: :hearts}, %{rank: 11, suit: :hearts}, %{rank: 12, suit: :hearts}, %{rank: 13, suit: :hearts}, %{rank: 14, suit: :hearts}])
  true
  """
  def royal_flush?(hand) do
    straight?(hand) && flush?(hand) &&
      hand |> Enum.map(& &1.rank) |> Enum.sort() |> List.last() == 14
  end

  @doc ~S"""
  iex> Exgames.Obscura.Poker.straight_flush?([%{rank: 9, suit: :hearts}, %{rank: 10, suit: :hearts}, %{rank: 11, suit: :hearts}, %{rank: 12, suit: :hearts}, %{rank: 13, suit: :hearts}])
  true
  """
  def straight_flush?(hand) do
    straight?(hand) && flush?(hand)
  end

  @doc ~S"""
  Four of a kind can also be five of a kind when you remove suit.

  iex> Exgames.Obscura.Poker.four_of_a_kind?([%{rank: 2, suit: :hearts}, %{rank: 2, suit: :diamonds}, %{rank: 2, suit: :clubs}, %{rank: 2, suit: :spades}, %{rank: 3, suit: :hearts}])
  true
  """
  def four_of_a_kind?(hand) do
    hand |> Enum.map(& &1.rank) |> Enum.uniq() |> length() <= 2
  end

  @doc ~S"""
  I can't do `three_of_a_kind?(hand) && two_pairs?(hand)` because their implementations could check the same set.

  iex> Exgames.Obscura.Poker.full_house?([%{rank: 2, suit: :hearts}, %{rank: 2, suit: :diamonds}, %{rank: 2, suit: :clubs}, %{rank: 3, suit: :hearts}, %{rank: 3, suit: :hearts}])
  true
  """
  def full_house?(hand) do
    hand |> Enum.map(& &1.rank) |> Enum.sort() |> Enum.chunk_by(& &1) |> length == 2
  end

  @doc ~S"""
  iex> Exgames.Obscura.Poker.flush?([%{rank: 2, suit: :hearts}, %{rank: 3, suit: :hearts}, %{rank: 4, suit: :hearts}, %{rank: 5, suit: :hearts}, %{rank: 6, suit: :hearts}])
  true
  """
  def flush?(hand) do
    hand |> Enum.all?(&(&1.suit == hand |> List.first() |> Map.get(:suit)))
  end

  @doc ~S"""
  iex> Exgames.Obscura.Poker.straight?([%{rank: 2, suit: :hearts}, %{rank: 5, suit: :diamonds}, %{rank: 4, suit: :clubs}, %{rank: 6, suit: :spades}, %{rank: 3, suit: :hearts}])
  true
  """
  def straight?(hand) do
    sorted_nums = hand |> Enum.map(& &1.rank) |> Enum.sort()

    sorted_nums
    |> Enum.with_index()
    |> Enum.all?(fn {n, i} ->
      if i == length(sorted_nums) - 1 do
        # do nothing
        true
      else
        # check the next one is one less
        Enum.at(sorted_nums, i + 1) == n + 1
      end
    end)
  end

  @doc ~S"""
  Three of a kind can also be four or five of a kind when you remove suit.

  iex> Exgames.Obscura.Poker.three_of_a_kind?([%{rank: 2, suit: :hearts}, %{rank: 2, suit: :diamonds}, %{rank: 2, suit: :clubs}, %{rank: 3, suit: :hearts}, %{rank: 4, suit: :hearts}])
  true

  iex> Exgames.Obscura.Poker.three_of_a_kind?([%{rank: 13, suit: :diamonds}, %{rank: 14, suit: :diamonds}, %{rank: 13, suit: :hearts}, %{rank: 7, suit: :hearts}, %{rank: 7, suit: :spades}])
  false
  """
  def three_of_a_kind?(hand) do
    hand
    |> Enum.map(& &1.rank)
    |> Enum.sort()
    |> Enum.chunk_by(& &1)
    |> Enum.any?(&(length(&1) == 3))
  end

  @doc ~S"""
  iex> Exgames.Obscura.Poker.two_pairs?([%{rank: 2, suit: :hearts}, %{rank: 2, suit: :diamonds}, %{rank: 3, suit: :clubs}, %{rank: 3, suit: :spades}, %{rank: 4, suit: :hearts}])
  true
  """
  def two_pairs?(hand) do
    hand |> Enum.map(& &1.rank) |> Enum.uniq() |> length() == 3
  end

  @doc ~S"""
  iex> Exgames.Obscura.Poker.one_pair?([ %{rank: 11, suit: :hearts}, %{rank: 2, suit: :diamonds}, %{rank: 11, suit: :spades}, %{rank: 12, suit: :diamonds}, %{rank: 14, suit: :clubs} ])
  true
  """
  def one_pair?(hand) do
    hand |> Enum.map(& &1.rank) |> Enum.uniq() |> length() == 4
  end
end
