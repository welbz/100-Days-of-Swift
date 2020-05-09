import UIKit

// Trailing closure syntax
/*
 If the last parameter to a function is a closure, Swift lets you use special syntax called trailing closure syntax. Rather than pass in your closure as a parameter, you pass it directly after the function inside braces
 
 Because its last param is closure we can call travel trailing closure syntax
 Because there are no other params we can remove ()
 Very common in Swift
 */

// func with closure as void
// runs action closure
func travel(action: () -> Void) {
    print("Im getting ready")
    action()
    print("Ive arrived")
}

// Because its last parameter is a closure, we can call travel() using trailing closure syntax
travel() {
    print("I'm driving in my car")
}

// Because there aren’t any other parameters, we can remove the parentheses ()
travel {
    print("I'm driving in my car")
}
