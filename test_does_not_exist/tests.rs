use does_not_exist::*; // directory to test

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
fn easy() {
    // Should not be runned due to Architecture check script failure
    my_assert_eq(does_not_exist(), "Hello There");
}
