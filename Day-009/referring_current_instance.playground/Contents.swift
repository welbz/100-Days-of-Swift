import UIKit

// Referring to the current instance

/*
 Inside methods you get a special constant called self, which points to whatever instance of the struct is currently being used. This self value is particularly useful when you create initializers that have the same parameter names as your property
 */

struct Person {
    var name: String
    
    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}
/*
 if you create a Person struct with a name property, then tried to write an initializer that accepted a name parameter, self helps you distinguish between the property and the parameter –
 */

// self.name refers to the struct property
// name refers to the init parameter
