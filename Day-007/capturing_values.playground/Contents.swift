import UIKit

// Capturing values


func travels() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}
// The travel() function that returns a closure, and the returned closure accepts a string as its only parameter and returns nothing

let results = travels()
results("Sydney")




// Closure capturing happens if we create values in travel() that get used inside the closure
func travelCounter() -> (String) -> Void {
    var counter = 1
    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}
// Even though that counter variable was created inside travel(), it gets captured by the closure so it will still remain alive for that closure

let resultCounter = travelCounter()
resultCounter("Brisbane")
resultCounter("Adelaide")
resultCounter("Perth")
resultCounter("Melbourne")
// if we call result("London") multiple times, the counter will go up
