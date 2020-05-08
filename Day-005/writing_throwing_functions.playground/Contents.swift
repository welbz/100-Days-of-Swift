import UIKit

// Writing throwing functions

/*
 Sometimes functions fail because they have bad input, or because something went wrong internally. Swift lets us throw errors from functions by marking them as throws before their return type, then using the throw keyword when something goes wrong.
 */

enum PasswordError: Error {
    case obvious
}


func checkPassword (_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}
