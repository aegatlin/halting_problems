from base64 import b16decode, b64encode


def hex_string_to_b64_string(s):
    hex = b16decode(s, casefold=True)
    b64 = b64encode(hex)
    return b64.decode()


def hex_xor(h1, h2):
    ba1 = bytearray.fromhex(h1)
    ba2 = bytearray.fromhex(h2)
    ba_result = bytearray_xor(ba1, ba2)
    return ba_result.hex()


# Given 2 equal length bytearrays
# compute the xor
def bytearray_xor(ba1, ba2):
    if len(ba1) != len(ba2):
        raise ValueError

    ba_result = bytearray()
    for x, y in zip(ba1, ba2):
        ba_result.append(x ^ y)
    return ba_result

def repeat_key_until_length(key, n):
    if n % len(key) != 0:
        raise ValueError

    new_key = key
    while len(new_key) < n:
        new_key += key
    
    return new_key