import UIKit

// Creating your own structs
/*
Structs can be given their own variables and constants, and their own functions
*/
 
struct Sport {
    var name: String
}

var tennis = Sport(name: "Tennis")
print(tennis.name)

tennis.name = "Lawn Tennis"
