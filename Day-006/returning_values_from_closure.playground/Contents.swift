import UIKit

// Returning values from a closure
/*
 write inside your closure, directly before the in keyword
 
 write them before in
 ) -> String
 */

let driving = { (place: String) in
    print("I'm going to \(place) in my car")
}

// closure that returns a string rather than printing the message directly
let drivingReturn = { (place: String) -> String
    in
    return "I'm going to \(place) in my car"
}

// run that closure and print its return value
let message = drivingReturn("Sydney")
print(message)
