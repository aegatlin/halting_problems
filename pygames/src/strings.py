def is_palindrome(s):
    if len(s) <= 1:
        return True

    right_index = len(s) - 1
    left_index = 0
    while (right_index - left_index) > 0:
        if s[right_index] != s[left_index]:
            return False

        right_index -= 1
        left_index += 1

    return True