use add_one::*; // directory to test

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
fn test_easy() {
    // this should not get runned due to forbidden script error
    my_assert_eq(add_one(1), 2);
}
