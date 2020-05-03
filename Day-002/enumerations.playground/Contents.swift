import UIKit

// Enumerations
// Enums

/*
 Enumerations (enums) – are a way of defining groups of related values in a way that makes them easier to use.
 */

var result = "failure"
var result2 = "failed"
var result3 = "fail"

enum Result {
    case success
    case failure
}
// captial R

let result4 = Result.failure
// dot syntax
// must choose 1 of the enum cases
