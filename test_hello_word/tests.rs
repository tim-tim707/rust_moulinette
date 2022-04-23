use hello_word::*; // directory to test

use std::fmt::Debug;
use std::ops::Not;

fn my_assert<T: PartialEq + Debug + Not<Output = bool>>(a: T) {
    println!("Expected true got {:?}", a);
    assert!(a);
}

fn my_assert_eq<T: PartialEq + Debug>(a: T, b: T) {
    println!("Expected {:?} got {:?}", a, b);
    assert_eq!(a, b);
}

#[test]
fn good() {
    my_assert_eq(hello_word(), "Hello World!".to_string());
}

#[test]
fn failure_case() {
    my_assert_eq(hello_word(), "This is a failure case".to_string());
}
