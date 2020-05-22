import UIKit

// Optional chaining

/*
 Swift provides us with a shortcut when using optionals: if you want to access something like a.b.c and b is optional, you can write a question mark after it to enable optional chaining: a.b?.c.

 When that code is run, Swift will check whether b has a value, and if it’s nil the rest of the line will be ignored – Swift will return nil immediately. But if it has a value, it will be unwrapped and execution will continue
 */

let names = ["John", "Paul", "George", "Ringo"]

// We’re going to use the first property of that array, which will return the first name if there is one or nil if the array is empty. We can then call uppercased() on the result to make it an uppercase string

let beatle = names.first?.uppercased()
// That question mark is optional chaining – if first returns nil then Swift won’t try to uppercase it, and will set beatle to nil immediately
