import pytest
from crypto import bytearray_xor, hex_string_to_b64_string, hex_xor, repeat_key_until_length


def test_hex_string_to_b64_string():
    assert hex_string_to_b64_string("ABCD") == "q80="
    assert hex_string_to_b64_string("abcd") == "q80="
    hex = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
    b64 = "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
    assert hex_string_to_b64_string(hex) == b64


def test_hex_xor():
    assert hex_xor("1C", "68") == "74"

    h1 = "1c0111001f010100061a024b53535009181c"
    h2 = "686974207468652062756c6c277320657965"
    answer = "746865206b696420646f6e277420706c6179"
    assert hex_xor(h1, h2) == answer


def test_bytearray_xor():
    assert bytearray_xor(bytearray([0]), bytearray([0])) == bytearray([0])
    assert bytearray_xor(bytearray([0]), bytearray([1])) == bytearray([1])
    assert bytearray_xor(bytearray([1]), bytearray([1])) == bytearray([0])
    with pytest.raises(ValueError):
        bytearray_xor(bytearray([0]), bytearray([1, 2]))

def test_repeat_key_until_length():
    assert repeat_key_until_length('key', 12) == 'keykeykeykey'
    with pytest.raises(ValueError):
        repeat_key_until_length('key', 1)
    with pytest.raises(ValueError):
        repeat_key_until_length('key', 17)