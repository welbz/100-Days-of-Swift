import UIKit

// Conditional statements

var action: String
var person = "hater"

if person == "hater" {
    action = "hate"
}


// else statements
var action2: String
var person2 = "hater"

if person2 == "hater" {
    action2 = "hate"
} else if person2 == "player" {
    action2 = "play"
} else {
    action2 = "cruise"
}


// && - multiple conditions
var action3: String
var stayOutTooLate = true
var nothingInBrain = true

if stayOutTooLate && nothingInBrain {
    action3 = "cruise"
}

// ! Not - condition is not true
if !stayOutTooLate && !nothingInBrain {
    action = "cruise"
}
