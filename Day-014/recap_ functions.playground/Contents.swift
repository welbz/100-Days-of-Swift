import UIKit

// Functions

func favouriteAlbumn() {
    print("My favourite is Blood Sugar Sex Magik")
}

favouriteAlbumn()


// with params
func favAlbumn(name: String) {
    print("My favourite is \(name)")
}

favAlbumn(name: "Californication")


// multiple params
func printAlbumRelease(name: String, year: Int) {
    print("\(name) was released in \(year)")
}

printAlbumRelease(name: "By the Way", year: 2002)
printAlbumRelease(name: "Stadium Arcadium", year: 2006)



// External and internal parameter names
/*
 Sometimes you want parameters to be named one way when a function is called, but another way inside the function itself. This means that when you call a function it uses almost natural English, but inside the function the parameters have sensible names
 */

func countLettersInString(string: String) {
    print("The string \(string) has \(string.count) letters.")
}

countLettersInString(string: "Hello")



// Swift lets you specify one name for the parameter when it’s being called, and another inside the method. To use this, just write the parameter name twice – once for external, one for internal

func countLettersInString2(myString str: String) {
    print("The string \(str) has \(str.count) letters.")
}

countLettersInString2(myString: "Hello 2")



//  specify an underscore, _, as the external parameter name, which tells Swift that it shouldn’t have any external name at all
func countLettersInString3(_ str: String) {
    print("The string \(str) has \(str.count) letters.")
}

countLettersInString3("Hello 3")



// external parameter names like “in”, “for”, and “with”
func countLetters(in string: String) {
    print("The string \(string) has \(string.count) letters.")
}

countLetters(in: "Hello")
// clear and concise



// Returning values
func albumIsTaylors(name: String) -> Bool {
    if name == "Taylor Swift" { return true }
    if name == "Fearless" { return true }
    return false
}

// Using am if statement on a func that returns bool
if albumIsTaylors(name: "Taylor Swift") {
    print("Thats one of hers")
} else {
    print("Who made that?")
}


if albumIsTaylors(name: "The White Album") {
    print("Thats one of hers")
} else {
    print("Who made that?")
}
