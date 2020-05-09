import UIKit

// Returning closures from functions
/*
 In the same way that you can pass a closure to a function, you can get closures returned from a function
 
 use -> twice:
 once to specify your function’s return value
 a second time to specify your closure’s return value
 */



func travel() -> (String) -> Void {
    return { // this starts closure - the return is the closure
        print("Im going to \($0)")
    }
}
// function that accepts no parameters, but returns a closure.
// The closure that gets returned must be called with a string, and will return nothing
// travel() function that returns a closure, and the returned closure accepts a string as its only parameter and returns nothing


// Can now call travel() to get back that closure, then call it as a function
let result = travel()
result("Melbourne")

// Some inception-ness going on here!
