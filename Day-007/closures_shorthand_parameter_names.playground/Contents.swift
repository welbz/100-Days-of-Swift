import UIKit

// Shorthand parameter names
/*
 Swift has a shorthand syntax. Rather than writing place in we can let Swift provide automatic names for the closure’s parameters.
 These are named with a dollar sign, then a number counting from 0
 */


// travel() function accepts one parameter, which is a closure that itself accepts one parameter and returns a string. That closure is then run between two calls to print()
func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

// Longhand way to call
travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

// Swift knows the parameter to that closure must be a string, so we can remove it
travel { place -> String in
    return "I'm going to \(place) in my car"
}


// Swift also knows the closure must return a string, so we can remove that also
travel { place in
    return "I'm going to \(place) in my car"
}

// As the closure only has one line of code that must be the one that returns the value, so Swift lets us remove the return keyword
travel { place in
    "I'm going to \(place) in my car"
}

// Shorthand way to call
travel {
    "I'm going to \($0) in my car"
}
// These are named with a dollar sign, then a number counting from 0
