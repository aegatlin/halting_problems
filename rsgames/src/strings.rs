pub fn csv_string_to_list(s: &str) -> Vec<&str> {
    s.split(",").collect()
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_csv_to_list() {
        assert_eq!(csv_string_to_list("1,2,3"), vec!["1", "2", "3"]);
    }
}
