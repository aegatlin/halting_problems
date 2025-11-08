use rsgames::words::WordProperties;

fn main() {
    let contents = rsgames::files::read_file("0098_words.txt");
    let words = rsgames::strings::csv_string_to_list(&contents);
    let words2: Vec<&str> = words
        .into_iter()
        .map(|word| word.trim_matches('"'))
        .collect();

    for word in &words2 {
        let mut anagrams: Vec<&str> = Vec::new();

        for other_word in &words2 {
            if word == other_word {
                continue;
            }

            if word.is_anagram(other_word) {
                anagrams.push(other_word);
            }
        }

        if anagrams.len() > 0 {
            println!("{}: {:?}", word, anagrams);
        }
    }
}
