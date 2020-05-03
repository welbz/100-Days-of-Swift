import UIKit

// Combining conditions

// && And
// || or

let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}
// wont even check age2 since age1 has already failed the condition

if age1 > 18 || age2 > 18 {
    print("One of them is over 18")
}
