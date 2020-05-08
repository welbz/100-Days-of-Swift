import UIKit

// Infinite loops
/*
 It’s common to use while loops to make infinite loops: loops that either have no end or only end when you’re ready
 
 Warning: have a check that exits your loop, otherwise it will never end
 */

var counter = 0

while true {
    print(" ")
    counter += 1
    
    if counter == 273 {
        break
    } // end condition
}// end loop
