import UIKit

// Switch case
/*
Advanced form of if
 
Swift will find the first case that matches your variable, then run its block of code. When that block finishes, Swift exits the whole switch/case block
 */

let liveAlbums = 2

switch liveAlbums {
case 0:
    print("You're just starting out")

case 1:
    print("You just released iTunes Live From SoHo")

case 2:
    print("You just released Speak Now World Tour")

default:
    print("Have you done something new?")
}
/* One advantage to switch/case is that Swift will ensure your cases are exhaustive. That is, if there's the possibility of your variable having a value you don't check for, Xcode will refuse to build your app

 In situations where the values are effectively open ended, like our liveAlbums integer, you need to include a default case to catch these potential values
 */


// closed range operator
let Albums = 5

switch Albums {
case 0...1:
    print("You're just starting out")

case 2...3:
    print("You're a rising star")

case 4...5:
    print("You're world famous!")

default:
    print("Have you done something new?")
}
