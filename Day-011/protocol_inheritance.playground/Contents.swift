import UIKit

// Protocol inheritance
/*
 One protocol can inherit from another in a process known as protocol inheritance. Unlike with classes, you can inherit from multiple protocols at the same time before you add your own customizations on top.

 We define three protocols: Payable requires conforming types to implement a calculateWages() method, NeedsTraining requires conforming types to implement a study() method, and HasVacation requires conforming types to implement a takeVacation() method
 */

protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVaction(days: Int)
}

// We can now create a single Employee protocol that brings them together in one protocol. We don’t need to add anything on top, so we’ll just write open and close braces
protocol Employee: Payable, NeedsTraining, HasVacation {
    }
// Now we can make new types conform to that single protocol rather than each of the three individual ones.
