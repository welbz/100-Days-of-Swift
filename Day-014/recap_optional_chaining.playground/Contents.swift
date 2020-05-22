import UIKit

// Optional chaining
// lets you run code only if your optional has a value. Put the below code into your playground to get us started
func albumReleased(year: Int) -> String? {
    switch year {
    case 2006: return "Taylor Swift"
    case 2008: return "Fearless"
    case 2010: return "Speak Now"
    case 2012: return "Red"
    case 2014: return "1989"
    default: return nil
    }
}

let album = albumReleased(year: 2006)
print("The album is \(album)")


let str = "Hello world"
print(str.uppercased())

// Optional chaining with ?
let album2 = albumReleased(year: 2006)?.uppercased()
print("The album is \(album2)")
// everything after the question mark will only be run if everything before the question mark has a value




// nil coalescing operator
/*
 use value A if you can, but if value A is nil, then use value B
 
 It's particularly helpful with optionals, because it effectively stops them from being optional because you provide a non-optional value B.
 
 So, if A is optional and has a value, it gets used (we have a value.)
 
 If A is present and has no value, B gets used (so we still have a value).
 
 Either way, we definitely have a value
 */
let album3 = albumReleased(year: 2006) ?? "unknown"
print("The album is \(album3)")
// no unwrapping needed
