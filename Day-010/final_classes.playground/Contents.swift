import UIKit

// Final classes
/*
Sometimes you want to disallow other developers from building their own class based on yours. When you declare a class as being final, no other class can inherit from it.
 
 This means they can’t override your methods in order to change your behavior – they need to use your class the way it was written.
 */

final class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
