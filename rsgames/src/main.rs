mod math;
mod trig;

fn main() {
    let mut best_count_diff: u128 = 1_000_000;
    let target_count: u128 = 2_000_000;

    for x in 1..100 {
        for y in 1..x {
            let count = sub_rectangles_count(x, y);
            let count_diff = target_count.abs_diff(count);
            if count_diff < best_count_diff {
                best_count_diff = count_diff;

                println!(
                    "x: {}, y: {}, count: {}, best_count_diff: {}, area: {}",
                    x,
                    y,
                    count,
                    best_count_diff,
                    x * y
                );
            }
        }
    }
}

fn sub_rectangles_count(x: u128, y: u128) -> u128 {
    math::choose(x + 1, 2).unwrap() * math::choose(y + 1, 2).unwrap()
}
