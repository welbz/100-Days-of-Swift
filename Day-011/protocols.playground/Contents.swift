import UIKit

// Protocols
/*
 Protocols are a way of describing what properties and methods something must have. You then tell Swift which types use that protocol – a process known as adopting or conforming to a protocol
 */

protocol Identifiable {
    var id: String {get set}
}
/*
 we can write a function that accepts something with an id property, but we don’t care precisely what type of data is used. We’ll start by creating an Identifiable protocol, which will require all conforming types to have an id string that can be
read (“get”)
or
written (“set”)
*/

// We can’t create instances of that protocol - it’s a description of what we want, rather than something we can create and use directly.

// But we can create a struct that conforms to it
struct User: Identifiable { // struct conforms to Identifiable
    var id: String
}

func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}
