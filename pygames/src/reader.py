def file_reader(path):
    file = open(path, "r")
    return list(map(lambda x: x.strip(), file.readlines()))


def number_grid_reader(s):
    return list(map(lambda x: list(map(lambda y: int(y), x.split())), s.split("\n")))


def number_reader(s):
    return int("".join(s.split("\n")))


def number_list_reader(s):
    return list(map(lambda x: int(x), s.split("\n")))


def space_delimited_numbers_reader(s):
    return list(map(lambda x: int(x), s.split(" ")))
