fn is_bouncy(mut n: u64) -> bool {
    let mut increasing = true;
    let mut decreasing = true;
    let mut prev = (n % 10) as i32;
    n /= 10;
    while n > 0 {
        let d = (n % 10) as i32;
        if d > prev {
            decreasing = false;
        }
        if d < prev {
            increasing = false;
        }
        if !increasing && !decreasing {
            return true;
        }
        prev = d;
        n /= 10;
    }
    false
}

fn main() {
    let mut bouncy: u64 = 0;
    let mut n: u64 = 0;
    loop {
        n += 1;
        if is_bouncy(n) {
            bouncy += 1;
        }
        if bouncy * 100 == n * 99 {
            println!("{}", n);
            break;
        }
    }
}
