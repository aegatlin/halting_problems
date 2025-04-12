defmodule Exgames.IntegersTest do
  use ExUnit.Case

  alias Exgames, as: E

  doctest E.Integers

  test "palindrome?/1" do
    assert E.Integers.palindrome?(0)
    assert E.Integers.palindrome?(1)
    assert E.Integers.palindrome?(202)
    assert E.Integers.palindrome?(123_454_321)
    assert E.Integers.palindrome?(1_234_554_321)
    assert E.Integers.palindrome?(11)

    refute E.Integers.palindrome?(-1)
    refute E.Integers.palindrome?(12)
    refute E.Integers.palindrome?(1212)
  end

  test "aliquot_sequence/1" do
    assert E.Integers.aliquot_sequence(6) == [6]
    assert E.Integers.aliquot_sequence(220) == [220, 284]
    assert E.Integers.aliquot_sequence(12496) == [12496, 14288, 15472, 14536, 14264]
  end

  test "aliquot_sum/1" do
    assert E.Integers.aliquot_sum(0) == 0
    assert E.Integers.aliquot_sum(1) == 0
    assert E.Integers.aliquot_sum(2) == 1
    assert E.Integers.aliquot_sum(12) == 16
    assert E.Integers.aliquot_sum(220) == 284
    assert E.Integers.aliquot_sum(284) == 220
  end

  test "proper_factors/1" do
    assert E.Integers.proper_factors(1) == []
    assert E.Integers.proper_factors(36) == [1, 2, 3, 4, 6, 9, 12, 18]
  end

  test "coprimes/2" do
    assert E.Integers.coprimes?(4, 9)
    refute E.Integers.coprimes?(6, 9)
    refute E.Integers.coprimes?(11, 11)
    assert E.Integers.coprimes?(1, 17)
  end

  test "totient/1" do
    assert E.Integers.totient(2) == 1
    assert E.Integers.totient(9) == 6
  end

  test "partition_function_list/1" do
    assert E.Integers.partition_function_list(3) == [[1, 1, 1], [1, 2], [3]]
    assert E.Integers.partition_function_list(4) == [[1, 1, 1, 1], [1, 1, 2], [2, 2], [1, 3], [4]]
  end

  test "generalized_partition_function/2" do
    assert E.Integers.generalized_partition_function(5) == 7
    assert E.Integers.generalized_partition_function(15) == 176
    assert E.Integers.generalized_partition_function(15, mod: 100) == 76
  end

  test "generalized_parition_function_sequence/2" do
    assert E.Integers.generalized_partition_function_sequence(10) ==
             [1, 1, 2, 3, 5, 7, 11, 15, 22, 30, 42]

    assert E.Integers.generalized_partition_function_sequence(10, mod: 5) ==
             [1, 1, 2, 3, 0, 2, 1, 0, 2, 0, 2]
  end

  test "generalized_partition_function_sequence_stream/2" do
    assert E.Integers.generalized_partition_function_sequence_stream() |> Enum.take(11) ==
             [
               {0, 1},
               {1, 1},
               {2, 2},
               {3, 3},
               {4, 5},
               {5, 7},
               {6, 11},
               {7, 15},
               {8, 22},
               {9, 30},
               {10, 42}
             ]
  end
end
