import UIKit

// Protocol extensions
/*
 Protocols let you describe what methods something should have, but don’t provide the code inside.
 
 Extensions let you provide the code inside your methods, but only affect one data type – you can’t add the method to lots of types at the same time.

 Protocol extensions solve both those problems: they are like regular extensions, except rather than extending a specific type like Int you extend a whole protocol so that all conforming types get your changes
 */

// An array and a set containing some names
let pythons = ["Eric", "Graham", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

// Swift’s arrays and sets both conform to a protocol called Collection, so we can write an extension to that protocol to add a summarize() method to print the collection neatly

extension Collection {
    func summarize() {
        print("There are \(count) of us:")

        for name in self {
            print(name)
        } // end loop
    } // end method
} // end extension


// Both Array and Set will now have that method available
pythons.summarize()
beatles.summarize()
