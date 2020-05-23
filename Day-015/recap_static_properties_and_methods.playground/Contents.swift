import UIKit

// Static properties and methods
/*
 Swift lets you create properties and methods that belong to a type, rather than to instances of a type
 
 using the static keyword. Once that's done, you access the property by using the full name of the type
 */

struct TaylorFan {
    static var favoriteSong = "Look What You Made Me Do"

    var name: String
    var age: Int
}

let fan = TaylorFan(name: "James", age: 25)
print(TaylorFan.favoriteSong)
// Because static methods belong to the struct itself rather than to instances of that struct, you can't use it to access any non-static properties from the struct
