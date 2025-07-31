pub trait IntegerProperties {
    fn is_perfect_square(self) -> bool;
}

impl IntegerProperties for u64 {
    fn is_perfect_square(self) -> bool {
        let sqrt_float = (self as f64).sqrt();
        let sqrt_int = sqrt_float.round() as u64;
        sqrt_int * sqrt_int == self
    }
}

impl IntegerProperties for u128 {
    fn is_perfect_square(self) -> bool {
        let isqrt = self.isqrt();
        isqrt * isqrt == self
        // let sqrt_float = (self as f64).sqrt();
        // let sqrt_int = sqrt_float.round() as u64;
        // sqrt_int * sqrt_int == self
    }
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_is_perfect_square_for_u64() {
        let a: u64 = 16;
        assert!(a.is_perfect_square());

        let b: u64 = 17;
        assert!(!b.is_perfect_square());

        // square of: 123456789
        let c: u64 = 15241578750190521;
        assert!(c.is_perfect_square());

        let d: u64 = c + 1;
        assert!(!d.is_perfect_square());
    }

    #[test]
    fn test_is_perfect_square_for_u128() {
        let a: u128 = 16;
        assert!(a.is_perfect_square());

        let b: u128 = 17;
        assert!(!b.is_perfect_square());

        // square of: 1234567890123456789
        let c: u128 = 1524157875323883675019051998750190521;
        assert!(c.is_perfect_square());

        let d: u128 = c + 1;
        assert!(!d.is_perfect_square());
    }
}
