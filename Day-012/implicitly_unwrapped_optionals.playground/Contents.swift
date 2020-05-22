import UIKit

// Implicitly unwrapped optionals

// Implicitly unwrapped optionals are created by adding an exclamation mark after your type name, like this

let age: Int! = nil

/*
 Because they behave as if they were already unwrapped, you don’t need if let or guard let to use implicitly unwrapped optionals. However, if you try to use them and they have no value – if they are nil – your code crashes.

 Implicitly unwrapped optionals exist because sometimes a variable will start life as nil, but will always have a value before you need to use it. Because you know they will have a value by the time you need them, it’s helpful not having to write if let all the time
 
  if you’re able to use regular optionals instead it’s better to do so
 */
