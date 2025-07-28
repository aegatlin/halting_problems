/// A product-sum number is one that can be constructed from a set of numbers
/// using both product and sum.
///
/// E.g., 1, 1, 2, 4 has a product of 8, and a sum of 8. Thus, 8 is a
/// product-sum number.
///
/// Product-sum numbers can have multiple sets that construct them, e.g.,
/// 1,1,2,4 and 1,1,2,2,2 for the number 8.
pub fn product_sum(number_set: Vec<u64>) -> Option<u64> {
    let sum: u64 = number_set.iter().sum();
    let product: u64 = number_set.iter().product();
    if sum == product {
        return Some(sum);
    }
    None
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_product_sum() {
        assert_eq!(product_sum(vec![1, 1, 2, 4]), Some(8));
        assert_eq!(product_sum(vec![1, 1, 2, 5]), None);
    }
}
