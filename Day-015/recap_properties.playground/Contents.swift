import UIKit

// Properties
/*
 Structs and classes (collectively: "types") can have their own variables and constants, and these are called properties. These let you attach values to your types to represent them uniquely, but because types can also have methods you can have them behave according to their own data
 */

struct Person {
    var clothes: String
    var shoes: String

    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}

// Instances of struct
let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let other = Person(clothes: "short skirts", shoes: "high heels")

// when you use a property inside a method it will automatically use the value that belongs to the same object
taylor.describe()
other.describe()




// Property observers
/*
 There are two kinds of property observer: willSet and didSet, and they are called before or after a property is changed.
 In willSet Swift provides your code with a special value called newValue that contains what the new property value is going to be
 in didSet you are given oldValue to represent the previous value
 */

struct PersonObservered {
    var clothes: String {
        willSet {
            updateUI(msg: "Im changing from \(clothes) to \(newValue)")
        }
        
        didSet {
            updateUI(msg: "I just changed from \(oldValue) to  \(clothes)")
        }
    }
    
    

    func updateUI(msg: String) {
        print(msg)
    }
}

var person1 = PersonObservered(clothes: "T-Shirts")
person1.clothes = "Shorts Skirts"
// Since we change the property willset and didset run
/*
 This will print
 Im changing from T-Shirts to Shorts Skirts
 I just changed from T-Shirts to  Shorts Skirts
*/

 
// Computed properties
/*
To make a computed property, place an open brace after your property then use either get or set to make an action happen at the appropriate time
 */

struct Person2 {
    var age: Int
    
    var ageInDogsYears: Int {
        get {
            return age * 7
        }
    }
}


var fan = Person2(age: 25)
print(fan.ageInDogsYears)
// Computed properties are common in Apple's code, but less common in user code
