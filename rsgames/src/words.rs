pub trait WordProperties {
    fn is_anagram(&self, other_word: &str) -> bool;
}

fn sorted_chars(s: &str) -> Vec<char> {
    let mut chars: Vec<char> = s.chars().collect();
    chars.sort();
    chars
}

impl WordProperties for str {
    fn is_anagram(&self, other_word: &str) -> bool {
        sorted_chars(self) == sorted_chars(other_word)
    }
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_is_anagram() {
        assert!(!"race".is_anagram("idk"));
        assert!(!"aab".is_anagram("ab"));

        assert!("race".is_anagram("care"));
        assert!("wow".is_anagram("oww"));
    }
}
