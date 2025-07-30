///
/// Obscura is the home of functionality that I suspect I will never use again.
///
use crate::factors;

/// A product-sum number is one that can be constructed from a set of numbers
/// using both product and sum.
///
/// E.g., 1, 1, 2, 4 has a product of 8, and a sum of 8. Thus, 8 is a
/// product-sum number.
///
/// Product-sum numbers can have multiple sets that construct them, e.g.,
/// 1,1,2,4 and 1,1,2,2,2 for the number 8.
pub fn get_product_sums(n: u64) -> Vec<Vec<u64>> {
    let mut product_sums: Vec<Vec<u64>> = Vec::new();
    let mps = factors::get_multiplicative_partitions(n);

    for mp in mps {
        if mp.len() == 1 && mp.first() == Some(&n) {
            continue;
        }

        let sum: u64 = mp.iter().sum();
        let ones_count = n - sum;
        if ones_count >= 0 {
            let mut answer = vec![1; ones_count as usize];
            answer.extend(mp);
            product_sums.push(answer);
        }
    }

    product_sums.sort();
    product_sums
}

#[cfg(test)]
mod test {
    use super::*;

    #[test]
    fn test_get_product_sums() {
        assert_eq!(get_product_sums(2), vec![] as Vec<Vec<u64>>);
        assert_eq!(get_product_sums(4), vec![vec![2, 2]]);
        assert_eq!(
            get_product_sums(8),
            vec![vec![1, 1, 2, 2, 2], vec![1, 1, 2, 4]]
        );
    }
}
