mod trig;

fn main() {
    let points = generate_all_points();
    let point_pairs = generate_all_pairs(&points);
    let triangles = generate_all_triangles(&point_pairs);

    let mut count = 0;
    for tri in triangles {
        if tri.is_right_triangle() {
            println!("{:?}", tri);
            count += 1;
        }
    }

    println!("Number of right triangles: {}", count / 2);
}

fn generate_all_triangles(point_pairs: &[(trig::Point, trig::Point)]) -> Vec<trig::Triangle> {
    point_pairs
        .iter()
        .map(|&(p, q)| trig::Triangle::new(p, q))
        .collect()
}

fn generate_all_points() -> Vec<trig::Point> {
    let mut points = Vec::new();

    for y in 0..=50 {
        for x in 0..=50 {
            // ignore origin since that will be an implicit 3rd point
            if x != 0 || y != 0 {
                points.push(trig::Point::new_from_i32(x, y));
            }
        }
    }

    points
}

fn generate_all_pairs(points: &[trig::Point]) -> Vec<(trig::Point, trig::Point)> {
    points
        .iter()
        .copied()
        .flat_map(|p| points.iter().copied().map(move |q| (p, q)))
        .collect()
}
