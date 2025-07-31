pub trait FloatProperties {
    fn is_integral(self) -> bool;
}

impl FloatProperties for f64 {
    fn is_integral(self) -> bool {
        let f_rounded = self.round();
        let diff = (self - f_rounded).abs();
        diff < 1e-12
    }
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_is_integral() {
        assert!(!5.1.is_integral());
        assert!(!5.001.is_integral());
        assert!(!5.000_001.is_integral());
        assert!(!5.000_001.is_integral());
        assert!(!5.000_000_001.is_integral());
        assert!(!5.000_000_000_001.is_integral());

        assert!(5.0.is_integral());
        assert!(5.000_000_000_000_9.is_integral());
        assert!(5.000_000_000_000_001.is_integral());
    }
}
