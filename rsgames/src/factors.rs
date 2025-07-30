use std::collections::HashSet;

/// Returns all factors (including `1` and `n`).
pub fn get_all_factors(n: u64) -> Vec<u64> {
    let mut factors: Vec<u64> = Vec::new();

    for x in 1..=n {
        if n % x == 0 {
            factors.push(x);
        }
    }

    factors
}

/// Returns all the proper factors of `n`. Proper factors exclude `1` and `n`.
pub fn get_proper_factors(n: u64) -> Vec<u64> {
    let all_factors = get_all_factors(n);

    all_factors
        .into_iter()
        .filter(|&x| x != 1 && x != n)
        .collect()
}

/// Returns all the sets of numbers whose products are `n`. The set includes
/// `vec![n]`. The set excludes `1`s, since those could be infinitely added.
///
/// # Example
///
/// ```
/// use rsgames::factors::get_multiplicative_partitions;
/// use std::collections::HashSet;
///
/// let actual = get_multiplicative_partitions(20);
/// let expected = HashSet::from([vec![2, 2, 5], vec![2, 10], vec![4, 5], vec![20]]);
/// assert_eq!(actual, expected);
/// ```
///
/// # Notes
///
/// - https://oeis.org/A001055
/// - https://en.wikipedia.org/wiki/Multiplicative_partition
pub fn get_multiplicative_partitions(n: u64) -> HashSet<Vec<u64>> {
    let proper_factors = get_proper_factors(n);

    // base case
    if proper_factors.is_empty() {
        return HashSet::from([vec![n]]);
    }

    // recursive case
    let mut partitions = proper_factors
        .iter()
        .flat_map(|&f| {
            get_multiplicative_partitions(n / f)
                .into_iter()
                .map(|mut sub_partition| {
                    sub_partition.push(f);
                    sub_partition.sort();
                    sub_partition
                })
                .collect::<Vec<Vec<u64>>>()
        })
        .collect::<HashSet<Vec<_>>>();

    partitions.insert(vec![n]);
    partitions
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

    #[test]
    fn test_multiplicative_partitions_of() {
        let expected = HashSet::from([vec![19]]);
        assert_eq!(get_multiplicative_partitions(19), expected);

        let expected2 = HashSet::from([vec![2, 2, 5], vec![2, 10], vec![4, 5], vec![20]]);
        assert_eq!(get_multiplicative_partitions(20), expected2);

        let expected3 = HashSet::from([
            vec![60],
            vec![2, 30],
            vec![3, 20],
            vec![4, 15],
            vec![5, 12],
            vec![6, 10],
            vec![2, 2, 15],
            vec![2, 3, 10],
            vec![2, 5, 6],
            vec![3, 4, 5],
            vec![2, 2, 3, 5],
        ]);
        assert_eq!(get_multiplicative_partitions(60), expected3);
    }
}
