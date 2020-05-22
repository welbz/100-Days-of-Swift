import UIKit

// Structs
/*
 Structs are complex data types, meaning that they are made up of multiple values. You then create an instance of the struct and fill in its values, then you can pass it around as a single value in your code
 */


struct Person {
    var clothes: String
    var shoes: String
}


// memberwise initializer - you create the struct by passing in initial values for its two properties
let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")


// Once you have created an instance of a struct, you can read its properties just by writing the name of the struct, a period, then the property you want
print(taylor.clothes)
print(other.shoes)

// If you assign one struct to another, Swift copies it behind the scenes so that it is a duplicate of the original
var taylorCopy = taylor
taylorCopy.shoes = "Thongs"
print(taylor)
print(taylorCopy)

// prints
// Person(clothes: "T-shirts", shoes: "sneakers")
// Person(clothes: "T-shirts", shoes: "Sandles")

// Note:
    // Copied taylor and not replaced it
    // only the shoes property has updaed and not clothes.



// Functions inside structs
/*
 You can place functions inside structs, and in fact it’s a good idea to do so for all functions that read or change data inside the struct
 */
struct Person2 {
    var clothes: String
    var shoes: String
    
    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}
// when you write a function inside a struct, it's called a method instead
