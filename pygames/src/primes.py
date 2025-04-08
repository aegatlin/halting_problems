from functools import reduce
from math import ceil, floor, gcd, sqrt


def is_prime(n):
    # Inefficient for frequent checks against smaller numbers.
    if n < 2:
        return False

    if n == 2:
        return True

    if n % 2 == 0:
        return False

    for x in range(3, floor(sqrt(n)), 2):
        if n % x == 0:
            return False

    return True


def is_coprime(n, m):
    return gcd(n, m) == 1


def get_prime_factors_of(n):
    if n <= 1:
        return []

    prime_factors = []
    while n % 2 == 0:
        prime_factors.append(2)
        n /= 2

    for i in range(3, ceil(sqrt(n)) + 1, 2):
        while n % i == 0:
            prime_factors.append(int(i))
            n /= i

    if n > 2:
        prime_factors.append(int(n))

    return prime_factors


def get_primes_bool_dict(n):
    nums = _sieve_of_eratosthenes(n)
    d = {}
    for index, boolean in enumerate(nums):
        d[index] = boolean


def _sieve_of_eratosthenes(n):
    nums = [True for _ in range(n)]
    nums[0] = False
    nums[1] = False

    for i in range(4, n, 2):
        nums[i] = False

    for i in range(3, ceil(sqrt(n)), 2):
        if nums[i] == False:
            continue

        m = i ** 2  # e.g., 17 * 17
        inc = i * 2  # e.g., 17 * 17 + 2 * 17 = 19 * 17
        while m < n:
            nums[m] = False
            m += inc

    return nums


def get_odd_composites(excluded_max):
    m = excluded_max
    if m < 9:
        return []
    nums = _sieve_of_eratosthenes(m)
    odd_composites = []
    for i in range(9, len(nums), 2):  # index 9's value is 9
        if not nums[i]:
            odd_composites.append(i)
    return odd_composites


def get_primes_data(excluded_max):
    m = excluded_max
    if m < 3:
        return ([], [])
    primes = []
    odd_composites = []
    nums = _sieve_of_eratosthenes(m)
    for i in range(0, m):
        if nums[i]:
            primes.append(i)
        else:
            if i >= 9 and i % 2 != 0:
                odd_composites.append(i)
    return (primes, odd_composites)


def get_primes_list(excluded_max):
    m = excluded_max
    if m < 2:
        return []

    nums = _sieve_of_eratosthenes(m)
    primes = []
    for i in range(2, m):
        if nums[i]:
            primes.append(i)

    return primes
