import UIKit

// Protocol-oriented programming
/*
Protocol extensions can provide default implementations for our own protocol methods. This makes it easy for types to conform to a protocol, and allows a technique called “protocol-oriented programming” – crafting your code around protocols and protocol extensions
 */


// a protocol called Identifiable that requires any conforming type to have an id property and an identify() method
protocol Identifiable {
    var id: String { get set }
    func identify()
}


// We could make every conforming type write their own identify() method, but protocol extensions allow us to provide a default
extension Identifiable {
    func identify() {
        print("My ID is \(id).")
    } // end method
} // end ext


// Now when we create a type that conforms to Identifiable it gets identify() automatically
struct User: Identifiable {
    var id: String
}

let welby = User(id: "Welbz")
welby.identify()
