/// All factors include `1` and `n`.
pub fn get_all_factors(n: u64) -> Vec<u64> {
    let mut factors: Vec<u64> = Vec::new();

    for x in 1..=n {
        if n % x == 0 {
            factors.push(x);
        }
    }

    factors
}

pub fn get_proper_factors(n: u64) -> Vec<u64> {
    let all_factors = get_all_factors(n);

    all_factors
        .into_iter()
        .filter(|&x| x != 1 && x != n)
        .collect()
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_get_all_factors() {
        assert_eq!(get_all_factors(10), vec![1, 2, 5, 10]);
        assert_eq!(get_all_factors(11), vec![1, 11]);
    }

    #[test]
    fn test_get_proper_factors() {
        assert_eq!(get_proper_factors(10), vec![2, 5]);
        assert_eq!(get_proper_factors(11), vec![]);
    }
}
