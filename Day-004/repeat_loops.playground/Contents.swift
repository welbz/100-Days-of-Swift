import UIKit

// Repeat loops
    // Not common

/* Although they are similar to while loops, repeat loops always run the body of their loop at least once.
 */

var number = 1

repeat {
    print(number)
    number += 1
} while number <= 20

print("Ready or not, here I come!")


while false {
    print("This is false")
}
// checks condition before it is run so it will never run

repeat {
    print("This is false")
} while false
// runs once
