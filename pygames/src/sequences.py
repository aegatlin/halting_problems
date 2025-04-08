def pentagonal(n):
    p = n * (3 * n - 1) / 2
    return int(p)


def hexagonal(n):
    p = n * (2 * n - 1)
    return int(p)


def triangular(n):
    p = n * (n + 1) / 2
    return int(p)


def triangle_numbers(excluded_max):
    m = excluded_max
    if m < 1:
        return []
    n = 0
    tri_num = 0
    tri_nums = []
    while tri_num < m:
        tri_nums.append(tri_num)
        n += 1
        tri_num += n

    return tri_nums


def get_collatz_sequence(n):
    l = [n]
    while n != 1:
        if n % 2 == 0:
            n = int(n / 2)
        else:
            n = int((3 * n) + 1)

        l.append(n)

    return l


def fibonacci_array_beneath(n):
    result = []
    a, b = 1, 2
    while a <= n:
        result.append(a)
        a, b = b, a + b
    return result


def fibonacci_number(n):
    if n <= 2:
        return 1

    return fibonacci_number(n - 2) + fibonacci_number(n - 1)
