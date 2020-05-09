import UIKit

// Using closures as parameters when they return values
/*
using () -> Void to “accepts no parameters and returns nothing”, but you can replace that Void with any type of data to force the closure to return a value
 
 we can write a travel() function that accepts a closure as its only parameter, and that closure in turn accepts a string and returns a string
 */

// func with closure returns void
func travel(action: (String) -> String) {
    print("Im getting ready to go")
    let description = action("Melbourne")
    print(description)
    print("Im getting ready to go")
}


// Call travel() using trailing closure syntax, our closure code is required to accept a string and return a string
travel { (place: String) -> String in
    return "Im going to \(place) in my car" // this String is now returned
}
/*
 Closure
- accepts param String using (place: String)
 -- returns a String -> String
 --- written using trailing closure syntax
 */
