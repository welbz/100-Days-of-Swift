import UIKit

// For loops
/*
 The most common loop is for, which assigns each item inside the loop to a temporary constant.
 If you don’t need the temporary constant that for loops give you, use an underscore instead so Swift can skip that work.
 */

let count = 1...10

for number in count {
    print ("Number is \(number)")
}

let albums = ["Red", "1989", "Rep"]
for album in albums {
    print("\(album) is on Apple music")
}

print("Players Gonna ")
for _ in 1...5 {
    print("Play")
}
