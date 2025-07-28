pub fn generate_primes(max: u64) -> Vec<u64> {
    let mut primes: Vec<u64> = vec![2];
    let mut sieve: Vec<u64> = (3..max).step_by(2).collect();

    while let Some(&first) = sieve.first() {
        primes.push(first);
        sieve.retain(|&x| x % first != 0);

        // if first * first > max {
        //     primes.extend(sieve.into_iter().skip(1));
        //     break;
        // }
    }

    primes
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_generate_primes() {
        assert_eq!(generate_primes(10), vec!(2, 3, 5, 7));
        assert_eq!(generate_primes(7), vec!(2, 3, 5));
    }
}
