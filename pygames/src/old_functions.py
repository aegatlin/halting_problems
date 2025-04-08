import math
from functools import reduce

from euler_number import elist, proper_divisors_of


def is_perfect(n):
    return sum(proper_divisors_of(n)) == n


def is_abundant(n):
    return sum(proper_divisors_of(n)) > n


def abundants_under(n):
    abundants = []
    for num in range(n):
        if is_abundant(num):
            abundants.append(num)
    return abundants


def abundant_sums_under(n):
    abundants = abundants_under(n)
    abundant_sums = elist([])
    for x in abundants:
        for y in abundants:
            sum = x + y
            if sum < n:
                abundant_sums.append(sum)
    return sorted(abundant_sums.prune())


def non_abundant_sums_under(n):
    abundant_sums = abundant_sums_under(n)
    abundant_sum_bools = [False for _ in range(n)]
    for n in abundant_sums:
        abundant_sum_bools[n] = True
    non_abundant_sums = []
    for index, boo in enumerate(abundant_sum_bools):
        if not (boo):
            non_abundant_sums.append(index)
    return non_abundant_sums


def get_amicable_numbers_under(n):
    def spdo(x):
        return sum(proper_divisors_of(x))

    amicables = []
    for i in range(n, 0, -1):
        j = spdo(i)
        if spdo(j) == i and i != j:
            amicables.append(i)
            amicables.append(j)


def collapse_number_pyramid(pyramid):
    i = len(pyramid) - 2

    while i >= 0:
        ary = pyramid[i]
        next_ary = pyramid[i + 1]

        for index, _ in enumerate(ary):
            ary[index] += max(next_ary[index], next_ary[index + 1])

        i -= 1

    return pyramid[0][0]


ENGLISH_NUMBER_WORD_LENGTH = {}
ENGLISH_NUMBER_WORD_LENGTH["1"] = ENGLISH_NUMBER_WORD_LENGTH[
    "2"
] = ENGLISH_NUMBER_WORD_LENGTH["6"] = ENGLISH_NUMBER_WORD_LENGTH["10"] = 3
ENGLISH_NUMBER_WORD_LENGTH["4"] = ENGLISH_NUMBER_WORD_LENGTH[
    "5"
] = ENGLISH_NUMBER_WORD_LENGTH["9"] = 4
ENGLISH_NUMBER_WORD_LENGTH["3"] = ENGLISH_NUMBER_WORD_LENGTH[
    "7"
] = ENGLISH_NUMBER_WORD_LENGTH["8"] = ENGLISH_NUMBER_WORD_LENGTH[
    "40"
] = ENGLISH_NUMBER_WORD_LENGTH[
    "50"
] = ENGLISH_NUMBER_WORD_LENGTH[
    "60"
] = 5
ENGLISH_NUMBER_WORD_LENGTH["11"] = ENGLISH_NUMBER_WORD_LENGTH[
    "12"
] = ENGLISH_NUMBER_WORD_LENGTH["20"] = ENGLISH_NUMBER_WORD_LENGTH[
    "30"
] = ENGLISH_NUMBER_WORD_LENGTH[
    "80"
] = ENGLISH_NUMBER_WORD_LENGTH[
    "90"
] = 6
ENGLISH_NUMBER_WORD_LENGTH["15"] = ENGLISH_NUMBER_WORD_LENGTH[
    "16"
] = ENGLISH_NUMBER_WORD_LENGTH["70"] = 7
ENGLISH_NUMBER_WORD_LENGTH["13"] = ENGLISH_NUMBER_WORD_LENGTH[
    "14"
] = ENGLISH_NUMBER_WORD_LENGTH["18"] = ENGLISH_NUMBER_WORD_LENGTH["19"] = 8
ENGLISH_NUMBER_WORD_LENGTH["17"] = 9


def _single(s):
    return ENGLISH_NUMBER_WORD_LENGTH[s]


def _double(s):
    if s[1] == "0":
        return ENGLISH_NUMBER_WORD_LENGTH[s]
    elif s[0] == "0":
        return ENGLISH_NUMBER_WORD_LENGTH[s[1]]
    elif int(s) <= 20:
        return ENGLISH_NUMBER_WORD_LENGTH[s]
    else:
        return ENGLISH_NUMBER_WORD_LENGTH[s[0] + "0"] + ENGLISH_NUMBER_WORD_LENGTH[s[1]]


def _triple(s):
    if s[1:] == "00":
        return _single(s[0]) + 7
    else:
        return _single(s[0]) + 10 + _double(s[1:])


def english_number_word_length(s):
    if len(s) == 1:
        return _single(s)
    if len(s) == 2:
        return _double(s)
    if len(s) == 3:
        return _triple(s)
    if len(s) == 4:
        return 11
    return 0


def largest_n_digit_product(num, n):
    string = str(num)
    product = 0
    for i in range(0, len(string) - (n - 1)):
        slice = string[i : i + n]
        new_product = reduce(lambda x, y: int(x) * int(y), slice)
        if new_product > product:
            product = new_product

    return product


def pythagorean_triple_with_product_equal_to(x):
    a, b, c = 0, 0, 0
    m = 2
    while m < x:
        for n in range(1, m):
            a = m ** 2 - n ** 2
            b = 2 * m * n
            c = m ** 2 + n ** 2

            if a + b + c == x:
                return a, b, c
        m += 1
