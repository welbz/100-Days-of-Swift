import UIKit

// Arrays

var evenNumbers = [2, 4, 6, 8]

var songs = ["Shake it Off", "You Belong with Me", "Back to December"]
songs[0]
songs[1]
songs[2]


var songs2 = ["Shake it Off", "You Belong with Me", "Back to December"]
type(of: songs2)


// var songs: [String] = ["Shake it Off", "You Belong with Me", "Back to December", 3]
// Fails as array is of type Strings and we have Int

var songs3: [Any] = ["Shake it Off", "You Belong with Me", "Back to December", 3]
// if the array needs to hold any kind of data, use the special "Any" data type

// Empty Array
var songs4: [String]
songs4[0] = "Shake it Off"


// Best way to write it
var songs5: [String] = []

// common
var songs6 = [String]()
// the () tells Swift we want to create the array in question, which is then assigned to songs using type inference


// Array operators
var songs7 = ["Shake it Off", "You Belong with Me", "Love Story"]
var songs8 = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]
var both = songs7 + songs8


both += ["Everything has Changed"]
// You can also use += to add and assign
