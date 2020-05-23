import UIKit

// Closures
/*
 A closure can be thought of as a variable that holds code
 Closures also capture the environment where they are created, which means they take a copy of the values that are used inside them
 */
let vw = UIView()

UIView.animate(withDuration: 0.5, animations: {
    vw.alpha = 0
})


// Trailing closures
/*
 The rule is this: if the last parameter to a method takes a closure, you can eliminate that parameter and instead provide it as a block of code inside braces
 */
let tc = UIView()

UIView.animate(withDuration: 0.5) {
    tc.alpha = 0
}
// Can remove the last parameter since it takes a closure
