import UIKit

// Optional try

/*
 That runs a throwing function, using do, try, and catch to handle errors gracefully.

 There are two alternatives to try, both of which will make more sense now that you understand optionals and force unwrapping.

 The first is try?, and changes throwing functions into functions that return an optional. If the function throws an error you’ll be sent nil as the result, otherwise you’ll get the return value wrapped as an optional
 */


enum PasswordError: Error {
    case obvious
}

// Throwing Functions
func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

do {
    try checkPassword("pessword")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}


// Options - try? changes throwing functions into functions that return an optional. If the function throws an error you’ll be sent nil as the result, otherwise you’ll get the return value wrapped as an optional

if let result = try? checkPassword("pussword") {
    print("Result was \(result)")
} else {
    print("Doh!")
}



// try! - use when you know for sure that the function will not fail. If the function does throw an error, your code will crash

try! checkPassword("Secret")
print("ok!")
// Crash

