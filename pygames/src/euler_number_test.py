from euler_number import divisors_of, is_pandigital, proper_divisors_of


def test_proper_divisors_of():
    assert proper_divisors_of(100) == [1, 2, 4, 5, 10, 20, 25, 50]
    assert proper_divisors_of(23) == [1]
    assert proper_divisors_of(28) == [1, 2, 4, 7, 14]
    assert proper_divisors_of(18) == [1, 2, 3, 6, 9]
    assert proper_divisors_of(4) == [1, 2]
    assert proper_divisors_of(12) == [1, 2, 3, 4, 6]
    assert proper_divisors_of(2) == [1]
    assert proper_divisors_of(1) == []
    assert proper_divisors_of(0) == []
    assert proper_divisors_of(-1) == []


def test_divisors_of():
    assert divisors_of(100) == [1, 2, 4, 5, 10, 20, 25, 50, 100]
    assert divisors_of(4) == [1, 2, 4]
    assert divisors_of(12) == [1, 2, 3, 4, 6, 12]
    assert divisors_of(2) == [1, 2]
    assert divisors_of(1) == [1]
    assert divisors_of(0) == []
    assert divisors_of(-1) == []


def test_is_pandigital():
    assert is_pandigital(123) == True
    assert is_pandigital(1324) == True
    assert is_pandigital(124) == False
    assert is_pandigital(122) == False
    assert is_pandigital(123456789) == True
    assert is_pandigital(987654321) == True
    assert is_pandigital(123556789) == False
    assert is_pandigital(123456789101112) == False
