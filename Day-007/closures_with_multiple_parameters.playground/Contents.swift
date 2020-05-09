import UIKit

// Closures with multiple parameters


func travel(action: (String, Int) -> String) {
    print("Im getting ready to go")
    let desc = action("Melbourne", 60)
    print(desc)
    print("I arrive")
}

travel {
    "Im going to \($0) at \($1) kms per hour"
}
// Using a trailing closure and shorthand closure parameter names to call
// Because this accepts two parameters, we get both $0 and $1
