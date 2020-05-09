import UIKit

import UIKit

// Accepting parameters in a closure
/*
List parameters inside parentheses just after the opening brace, then write in so that Swift knows the main body of the closure is starting
One of the differences between functions and closures is that you don’t use parameter labels when running closures
 
 params
 list param inside ()
 need to have in
 don’t write labels when running closures
*/


let driving = { (place: String) in
    print("Im driving in my car to \(place)")
}

driving("Melbourne")
