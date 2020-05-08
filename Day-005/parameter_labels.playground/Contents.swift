import UIKit

// Parameter labels

/*
 Swift lets us provide two names for each parameter: one to be used externally when calling the function, and one to be used internally inside the function
 */

func square(number: Int) -> Int {
    return number * number
}

let result = square(number: 8)

// 2 names
func sayHello(to name: String) {
    print("Hello, \(name)!")
}
/*
param = to name
externally = to
internally = name
This gives variables a sensible name inside the function, but means calling the function reads naturally
*/

sayHello(to: "Taylor")
