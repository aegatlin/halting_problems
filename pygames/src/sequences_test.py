from sequences import fibonacci_number, triangle_numbers


def test_triangle_numbers():
    assert triangle_numbers(-1) == []
    assert triangle_numbers(0) == []
    assert triangle_numbers(1) == [0]
    assert triangle_numbers(10) == [0, 1, 3, 6]
    assert triangle_numbers(100) == [0, 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 66, 78, 91]


def test_fibonacci_number():
    assert fibonacci_number(1) == 1
    assert fibonacci_number(2) == 1
    assert fibonacci_number(3) == 2
    assert fibonacci_number(4) == 3
    assert fibonacci_number(5) == 5
    assert fibonacci_number(6) == 8
    assert fibonacci_number(12) == 144
