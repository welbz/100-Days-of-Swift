import UIKit

// Closures as parameters when they accept parameters
/*
A closure you pass into a function can also accept its own parameters
This is like a combination of returning a closure using trailing closure syntax
 */

// func with closure returns void
func travel(action: (String) -> Void) {
    print("Im getting ready to go")
    action("Melbourne")
    print("Im getting ready to go")
}


// Can call travel() using trailing closure syntax, our closure code is required to accept a string
travel { (place: String) in
    print("Im going to \(place) in my car") // this String is now required
}
/*
 Closure
- accepts param String using (place: String)
 -- is returning a String using in
 --- written using trailing closure syntax
 */
