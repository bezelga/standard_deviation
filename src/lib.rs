#[no_mangle]
pub extern fn stdev(values: Vec<i32>) -> f64 {
    let mean = calculate_mean(&values);

    let mut distance: f64 = 0.0;

    for i in &values {
        distance += (*i as f64 - mean).powf(2.0);
    }

    let variance: f64 = distance / (values.len() -1) as f64;

    variance.sqrt()
}

fn calculate_mean(values: &Vec<i32>) -> f64 {
    let mut sum: i32 = 0;

    for i in values {
        sum += *i;
    }

    let mean: f64 = (sum as f64) / (values.len() as f64);
    mean
}


#[test]
fn it_works() {
    let values = vec![1, 2, 6, 3, -4, 23];
    assert_eq!(stdev(values), 9.32559202767667);
}

