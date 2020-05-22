import UIKit

// Failable initializers

let str = "5"
let num = Int(str)

/*
 That converts a string to an integer, but because you might try to pass any string there what you actually get back is an optional integer.

 This is a failable initializer: an initializer that might work or might not. You can write these in your own structs and classes by using init?() rather than init(), and return nil if something goes wrong. The return value will then be an optional of your type, for you to unwrap however you want.

 As an example, we could code a Person struct that must be created using a nine-letter ID string. If anything other than a nine-letter string is used we’ll return nil, otherwise we’ll continue as normal
 */

struct Person {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
        return nil
        }
    }
}

var nameBad = Person(id: "Welby")
var nameGood = Person(id: "Welby1234")
