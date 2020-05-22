import UIKit

// Force unwrapping

/*
 Optionals represent data that may or may not be there, but sometimes you know for sure that a value isn’t nil. In these cases, Swift lets you force unwrap the optional: convert it from an optional type to a non-optional type
 */

let str = "5"
let num = Int(str)!

// Swift will immediately unwrap the optional and make num a regular Int rather than an Int?. But if you’re wrong – if str was something that couldn’t be converted to an integer – your code will crash!
