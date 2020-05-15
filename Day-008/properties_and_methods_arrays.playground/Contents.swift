import UIKit

// Properties and methods of arrays

/*
 Arrays are also structs, which means they too have their own methods and properties we can use to query and manipulate the array
 */

var toys = ["Woody"]

print(toys.count)
// read the number of items in an array using its count property

toys.append("Buzz")
// add a new item, use the append() method

toys.firstIndex(of: "Buzz")
// You can locate any item inside an array using its firstIndex()
// That will return 1 because arrays count from 0

toys.sorted()
// sorts

toys.remove(at: 0)
// To remove an item, use the remove() method
