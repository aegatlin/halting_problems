use std::{f64::consts::PI, ops::Div};

#[derive(Debug, Clone, Copy)]
pub struct Triangle {
    p: Point,
    q: Point,
}

impl Triangle {
    /// The third point is the origin (0, 0).
    pub fn new(p: Point, q: Point) -> Self {
        Self { p, q }
    }

    pub fn is_right_triangle(self) -> bool {
        let o_theta = (self.p.theta() - self.q.theta()).abs();
        if Self::is_right_angle(o_theta) {
            return true;
        }

        let op = self.p.vector_length();
        let pq = self.pq_length();
        let oq = self.q.vector_length();

        let p_theta = Self::law_of_cosines_get_gamma(op, pq, oq);
        if Self::is_right_angle(p_theta) {
            return true;
        }

        if Self::is_right_angle(PI - o_theta - p_theta) {
            return true;
        }

        false
    }

    fn is_right_angle(angle: f64) -> bool {
        let diff = angle - (PI / 2.0);
        diff.abs() < 1e-6
    }

    fn origin_theta(self) -> f64 {
        (self.p.theta() - self.q.theta()).abs()
    }

    // calculates the length of pq using the Law of Cosines.
    fn pq_length(self) -> f64 {
        let a = self.p.vector_length();
        let b = self.q.vector_length();
        let gamma = self.origin_theta();
        Self::law_of_cosines_get_c(a, b, gamma)
    }

    fn law_of_cosines_get_c(a: f64, b: f64, gamma: f64) -> f64 {
        let c_sq = a.powi(2) + b.powi(2) - 2.0 * a * b * gamma.cos();
        c_sq.sqrt()
    }

    fn law_of_cosines_get_gamma(a: f64, b: f64, c: f64) -> f64 {
        let cos_gamma = (c.powi(2) - a.powi(2) - b.powi(2)).div(-2.0 * a * b);
        cos_gamma.acos()
    }
}

#[derive(Debug, Clone, Copy)]
pub struct Point {
    x: f64,
    y: f64,
}

impl Point {
    pub fn new_from_f64(x: f64, y: f64) -> Self {
        Self { x, y }
    }

    pub fn new_from_i32(x: i32, y: i32) -> Self {
        Self {
            x: x.into(),
            y: y.into(),
        }
    }

    /// A point (x,y) creates a vector from the origin (0, 0) and creates an
    /// angle from the x-axis. This is essentially a right triangle with
    /// `tan(theta) = y/x`. This implies, `theta = arctan(y/x)`. We use
    /// `y.atan2(x)` because it is quadrant sensitive.
    pub fn theta(self) -> f64 {
        self.y.atan2(self.x)
    }

    /// Calculates the length of the vector from origin (0, 0) to the point.
    /// This is also the length of the hypotenuse of the right triangle formed
    /// by the points, (0,0),(x,0),(x,y).
    pub fn vector_length(self) -> f64 {
        (self.x.powi(2) + self.y.powi(2)).sqrt()
    }
}

#[cfg(test)]
mod tests {
    use std::{f64::consts::PI, ops::Div};

    use super::*;

    #[test]
    fn test_theta() {
        let p = Point { x: 1.0, y: 0.0 };
        assert_eq!(p.theta(), 0.0);

        let q = Point { x: 0.0, y: 1.0 };
        assert_eq!(q.theta(), PI.div(2.0));

        let r = Point { x: 4.0, y: 4.0 };
        let actual = r.theta();
        let expected = PI.div(4.0);
        assert!((actual - expected).abs() < 1e-6);

        let s = Point { x: 4.0, y: 3.0 };
        let actual = s.theta();
        let expected = (3.0 as f64 / 5.0 as f64).asin();
        assert!((actual - expected).abs() < 1e-6);
    }

    #[test]
    fn test_new_from_i32() {
        let p = Point::new_from_i32(1, 0);
        assert_eq!(p.x, 1.0);
        assert_eq!(p.y, 0.0);
        assert_eq!(p.theta(), 0.0);
    }

    #[test]
    fn test_triangle() {
        let tri = Triangle::new(Point::new_from_i32(5, 0), Point::new_from_i32(5, 5));
        assert!(tri.is_right_triangle());

        let tri2 = Triangle::new(Point::new_from_i32(5, 0), Point::new_from_i32(6, 5));
        assert!(!tri2.is_right_triangle());
    }

    #[test]
    fn test_triangle_is_right_angle() {
        assert!(Triangle::is_right_angle(PI / 2.0));
        assert!(Triangle::is_right_angle(1.57079633));
        assert!(Triangle::is_right_angle(1.57079634));
        assert!(Triangle::is_right_angle(1.570796));
        assert!(!Triangle::is_right_angle(2.0));
        assert!(!Triangle::is_right_angle(1.57797));
    }
}
