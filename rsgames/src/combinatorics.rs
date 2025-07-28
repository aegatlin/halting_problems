use std::ops::Div;

#[derive(Debug, PartialEq)]
pub enum MathError {
    InvalidInput(String),
}

/// This is the binomial coeffecient
pub fn choose(n: u128, k: u128) -> Result<u128, MathError> {
    if k > n {
        return Err(MathError::InvalidInput(format!(
            "n choose k cannot have k > n, n: {}, k: {}",
            n, k
        )));
    }

    // This optimization eleminates the largest shared factorial from the top
    // and bottom before doing the calculation. E.g, for 20C2 it eleminates 18!
    // instead of 2!.
    let min = k.min(n - k);
    let max = k.max(n - k);
    let dividend: u128 = ((max + 1)..=n).product();
    let divisor = factorial(min);
    Ok(dividend.div(divisor))
}

pub fn factorial(n: u128) -> u128 {
    (1..=n).product()
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_choose() {
        assert_eq!(choose(4, 2).unwrap(), 6);
        assert_eq!(choose(5, 1).unwrap(), 5);
        assert_eq!(choose(34, 1).unwrap(), 34);
        // naive implementation causes overflow here even with u128
        assert_eq!(choose(40, 35).unwrap(), 658008);
    }

    #[test]
    fn test_choose_when_k_is_greater_than_n() {
        assert!(choose(5, 10).is_err());

        let err = choose(10, 20).unwrap_err();
        assert_eq!(
            err,
            MathError::InvalidInput("n choose k cannot have k > n, n: 10, k: 20".to_string())
        )
    }

    #[test]
    fn test_factorial() {
        assert_eq!(factorial(5), 120);
        assert_eq!(factorial(13), 6_227_020_800);
    }
}
