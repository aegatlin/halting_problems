from reader import *


def test_number_grid_reader():
    s = """01 10 23 22
22 23 43 43
43 44 98 65
45 56 67 78"""
    expected = [[1, 10, 23, 22], [22, 23, 43, 43], [43, 44, 98, 65], [45, 56, 67, 78]]
    assert number_grid_reader(s) == expected


def test_number_reader():
    s = """1234
5678
9101"""
    assert number_reader(s) == 123456789101


def test_number_array_reader():
    s = """1234
5678
9101"""
    assert number_list_reader(s) == [1234, 5678, 9101]


def test_space_delimited_number_array():
    s = "01 02 3 4567"
    assert space_delimited_numbers_reader(s) == [1, 2, 3, 4567]
