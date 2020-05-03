import UIKit

// Range operators
    // ..< up to but exludes final value
    // ... up to and includes final value

let score = 85

switch score {
case 0..<50:
    print("You failed badly")
case 50..<85:
    print("You did ok")
default:
    print("You did great!")
}
