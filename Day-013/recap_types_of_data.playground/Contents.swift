import UIKit

// Types of Data

var name: String
name = "Tim McGraw"

var age: Int
age = 25

// Float and Double
/*
The official Apple recommendation is always to use Double because it has the highest accuracy
*/

var latitude: Double
latitude = 36.166667

var longitude: Float
longitude = -86.783333
longitude = -186.783333
longitude = -1286.783333
longitude = -12386.783333
longitude = -123486.783333
longitude = -1234586.783333
// Double has twice the accuracy of Float so it doesn't need to cut your number to fit
// Hence the name Double



// Bools
var stayOutTooLate: Bool
stayOutTooLate = true

var nothingInBrain: Bool
nothingInBrain = true

var missABeat: Bool
missABeat = false


// Type annotations

/* This technique is called type inference, because Swift can infer what data type should be used for a variable by looking at the type of data you want to put in there. When it comes to numbers like -86.783333, Swift will always infer a Double rather than a Float
 */
var name2 = "Tim McGraw"

var name3: String
name3 = "Tim McGraw"

var age1 = 25
var longitude1 = -86.783333
var nothingInBrain1 = true
