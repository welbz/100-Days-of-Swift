import UIKit

// Creating your own classes
/*
 The first difference between classes and structs is that classes never come with a memberwise initializer. This means if you have properties in your class, you must always create your own initializer
 */

class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let dog1 = Dog(name: "Fido", breed: "Poodle")
// Creating instances of that class looks just the same as if it were a struct
