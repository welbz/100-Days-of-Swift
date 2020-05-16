import UIKit

// Extensions
/*
 Extensions allow you to add methods to existing types, to make them do things they weren’t originally designed to do.

 For example, we could add an extension to the Int type so that it has a squared() method that returns the current number multiplied by itself
 */

extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number  = 8
number.squared()


// Swift doesn’t let you add stored properties in extensions, so you must use computed properties instead.
//For example, we could add a new isEven computed property to integers that returns true if it holds an even number

extension Int {
    var isEven: Bool { // var of type bool
        return self % 2 == 0 // returns true if number can be divided by 2 as an even number
    }
}
