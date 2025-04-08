from primes import (
    get_odd_composites,
    get_primes_list,
    is_prime,
    get_prime_factors_of,
    get_primes_data,
)


def test_get_primes_data():
    assert get_primes_data(-1) == ([], [])
    assert get_primes_data(0) == ([], [])
    assert get_primes_data(1) == ([], [])
    assert get_primes_data(2) == ([], [])
    assert get_primes_data(3) == ([2], [])
    assert get_primes_data(10) == ([2, 3, 5, 7], [9])
    assert get_primes_data(20) == ([2, 3, 5, 7, 11, 13, 17, 19], [9, 15])


def test_get_odd_composites():
    assert get_odd_composites(-1) == []
    assert get_odd_composites(0) == []
    assert get_odd_composites(1) == []
    assert get_odd_composites(2) == []
    assert get_odd_composites(3) == []
    assert get_odd_composites(10) == [9]
    assert get_odd_composites(20) == [9, 15]
    assert get_odd_composites(30) == [9, 15, 21, 25, 27]


def test_get_primes_list():
    assert get_primes_list(10) == [2, 3, 5, 7]
    assert get_primes_list(-1) == []
    assert get_primes_list(0) == []
    assert get_primes_list(1) == []
    assert get_primes_list(2) == []
    assert get_primes_list(3) == [2]


def test_prime_factors_of():
    assert get_prime_factors_of(100) == [2, 2, 5, 5]
    assert get_prime_factors_of(28) == [2, 2, 7]
    assert get_prime_factors_of(18) == [2, 3, 3]
    assert get_prime_factors_of(10) == [2, 5]
    assert get_prime_factors_of(11) == [11]
    assert get_prime_factors_of(2) == [2]
    assert get_prime_factors_of(1) == []
    assert get_prime_factors_of(0) == []
    assert get_prime_factors_of(-1) == []


def test_is_prime():
    assert is_prime(-1) == False
    assert is_prime(0) == False
    assert is_prime(1) == False
    assert is_prime(2) == True
    assert is_prime(3) == True
    assert is_prime(5) == True
    assert is_prime(23) == True
    assert is_prime(100) == False
