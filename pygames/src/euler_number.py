from decimal import Decimal
from functools import reduce
from itertools import combinations

from primes import get_prime_factors_of
from strings import is_palindrome


def to_ascii_list(num_list):
    chars = []
    for n in num_list:
        chars.append(chr(n))
    return chars


def reverse(n):
    a = to_char_list(n)
    ra = list(reversed(a))
    return int("".join(ra))


def is_lychrel(n):
    x = n
    for _ in range(1, 51):
        x += reverse(x)
        if is_palindromic(x):
            return False
    return True


def is_palindromic(n):
    return is_palindrome(str(n))


def is_pandigital(n):
    digits = to_digit_list(n)

    if len(digits) > 9:
        return False

    sorted_digits = sorted(digits)
    for i, d in enumerate(sorted_digits):
        if i + 1 != d:
            return False

    return True


class elist(list):
    def prune(self):
        return elist(dict.fromkeys(self))


def to_char_list(n):
    sn = str(n)
    return [c for c in sn]


def to_digit_list(n):
    char_list = to_char_list(n)
    return [int(c) for c in char_list]


def proper_divisors_of(n):
    return divisors_of(n)[:-1]


def divisors_of(n):
    prime_factors = get_prime_factors_of(n)

    if prime_factors == []:
        return [1] if n == 1 else []

    i = 1
    divisors = []
    while i < len(prime_factors):
        combos = list(
            map(lambda x: reduce(lambda y, z: y * z, x), combinations(prime_factors, i))
        )
        for x in combos:
            if any(d == x for d in divisors):
                continue

            divisors.append(x)
            divisors.append(int(n / x))

        i += 1

    divisors.extend([1, n])
    divisors.sort()

    return elist(divisors).prune()
