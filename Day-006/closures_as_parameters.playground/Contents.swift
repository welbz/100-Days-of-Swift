import UIKit

// Closures as parameters
/*
 Because closures can be used just like strings and integers, you can pass them into functions
 
 If we wanted to pass that closure into a function so it can be run inside that function, we would specify the parameter type as () -> Void. That means “accepts no parameters, and returns Void” – Swift’s way of saying “nothing”.
 */


// closeur
let driving = {
    print("Im driving in my car")
}

// closure inside func with empty to param
func travel(action: () -> Void) {
    print("Im getting ready to go ")
    action()
    print("I arrvied")
}

// Can now call that using our driving closure
travel(action: driving)
