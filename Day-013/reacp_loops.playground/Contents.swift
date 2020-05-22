import UIKit

// Loops

// Written out
print("1 x 10 is \(1 * 10)")
print("2 x 10 is \(2 * 10)")
print("3 x 10 is \(3 * 10)")
print("4 x 10 is \(4 * 10)")
print("5 x 10 is \(5 * 10)")
print("6 x 10 is \(6 * 10)")
print("7 x 10 is \(7 * 10)")
print("8 x 10 is \(8 * 10)")
print("9 x 10 is \(9 * 10)")
print("10 x 10 is \(10 * 10)")


// As a Loop using the closed range operator, we could re-write that whole thing in three lines
for i in 1...10 {
    print("\(i) x 10 is \(i * 10)")
}
// the loop does is count from 1 to 10 (including 1 and 10), assigns that number to the constant i, then runs the block of code inside the braces

/*
... includes 10
..< excludes 10
*/


// If you don't need to know what number you're on, you can use an underscore instead
var str = "Fakers gonna"

for _ in 1 ... 5 {
    str += " fake"
}

print(str)



// Looping over arrays
/*
 Swift provides a very simple way to loop over all the elements in an array. Because Swift already knows what kind of data your array holds, it will go through every element in the array, assign it to a constant you name, then run a block of your code
 */
var songs = ["Shake it Off", "You Belong with Me", "Look What You Made Me Do"]

for song in songs {
    print("My favorite song is \(song)")
}

// You can also use the for i in loop construct to loop through arrays, because you can use that constant to index into an array. We could even use it to index into two arrays
var people = ["players", "haters", "heart-breakers", "fakers"]
var actions = ["play", "hate", "break", "fake"]

for i in 0 ... 3 {
    print("\(people[i]) gonna \(actions[i])") // this is awesome!
}

// Count
var people2 = ["players", "haters", "heart-breakers", "fakers"]
var actions2 = ["play", "hate", "break", "fake"]

for i in 0 ..< people2.count {
    print("\(people2[i]) gonna \(actions2[i])")
}


// Inner loops
var people3 = ["players", "haters", "heart-breakers", "fakers"]
var actions3 = ["play", "hate", "break", "fake"]

for i in 0 ..< people3.count {
    var str = "\(people3[i]) gonna"

    for _ in 1 ... 5 {
        str += " \(actions3[i])"
    }

    print(str)
}

// While loops
/*
 This is used for things like game loops where you have no idea in advance how long the game will last – you just keep repeating "check for touches, animate robots, draw screen, check for touches…" and so on, until eventually the user taps a button to exit the game and go back to the main menu
 */


// break
var counter = 0

while true {
    print("Counter is now \(counter)")
    counter += 1

    if counter == 556 {
        break
    }
}
// It's used to exit a while or for loop at a point you decide
// Without that break statement the loop is an infinite loop



// continue
/*
 The counterpart to break is called continue

Whereas breaking out of a loop stops execution immediately and continues directly after the loop, continuing a loop only exits the current iteration of the loop – it will jump back to the top of the loop and pick up from there
*/
var songs2 = ["Shake it Off", "You Belong with Me", "Look What You Made Me Do"]

for song in songs2 {
    if song == "You Belong with Me" {
        continue
    }

    print("My favorite song is \(song)")
}
// That loops through three Taylor Swift songs, but it will only print the name of two. The reason for this is the continue keyword: when the loop tries to use the song "You Belong with Me", continue gets called, which means the loop immediately jumps back to the start – the print() call is never made, and instead the loop continues straight on to “Look What You Made Me Do”
