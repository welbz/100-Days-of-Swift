import UIKit

// Deinitializers

/*
 The fourth difference between classes and structs is that classes can have deinitializers – code that gets run when an instance of a class is destroyed
 */



// here’s a Person class with a name property, a simple initializer, and a printGreeting() method that prints a message

class Person {
    var name = "Welby"
    
    init() {
        print("\(name) is alive!")
    }
    
    func printGreeting() {
        print("Hello, Im \(name)")
    }
}

// We create a few instances of the Person class inside a loop, each time the loop goes around a new person will be created then destroyed

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}

// Deinitializer - This will be called when the Person instance is being destroyed

class Person2 {
    var name = "Welby 2"
    
    init() {
        print("\(name) is alive!")
    }
    
    func printGreeting() {
        print("Hello, Im \(name)")
    }
    
    deinit {
        print("\(name) is destroyed!")
    }
}

for _ in 1...3 {
    let person = Person2()
    person.printGreeting()
}
