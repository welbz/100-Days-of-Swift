import UIKit

// Property observers
/*
 Property observers let you run code before or after any property changes
 */

struct Progress {
    var task: String
    var amount: Int {
        didSet {
        print("\(task) is now \(amount)% Complete")
        }
    }
}
// You can also use willSet to take action before a property changes, but that is rarely used

var progress = Progress(task: "Loading...", amount: 0)

progress.amount = 30
progress.amount = 80
progress.amount = 100
