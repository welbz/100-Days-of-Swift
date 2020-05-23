import UIKit

// Classes
/*
 1 - You don't get an automatic memberwise initializer for your classes -  need to write your own.
 2- You can define a class as being based off another class, adding any new things you want.
 3 - When you create an instance of a class it’s called an object. If you copy that object, both copies point at the same data by default – change one, and the copy changes too.
 */

class Person {
    var clothes: String
    var shoes: String
    
    init(clothes: String, shoes: String) {
        self.clothes = clothes
        self.shoes = shoes
    }
}
/*
1 - don't write func before your init() method, because it's special
 
2 - since the parameter names being passed in are the same as the names of the properties we want to assign, you use self.
    to make your meaning clear – "the clothes property of this object should be set to the clothes parameter that was passed in."
 
3 - Swift requires that all non-optional properties have a value by the end of the initializer, or by the time the initializer calls any other method – whichever comes first
*/



// Class inheritance
class Singer {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func sing() {
        print("la la la la")
    }
}


var taylor = Singer(name: "Taylor", age: 25)
taylor.name
taylor.age
taylor.sing()


// subclass
// We can define CountrySinger as being based off Singer and it will get all its properties and methods for us to build on
class CountrySinger: Singer {
    override func sing() {
        print("Trucks, guitars, and liquor")
    }
}

var taylorCountry = CountrySinger(name: "Taylor", age: 25)
taylorCountry.sing()

/*
 That colon is what does the magic: it means "CountrySinger extends Singer."
 Now, that new CountrySinger class (subclass) doesn't add anything to Singer (called the parent class, or superclass) yet.
 
 We want it to have its own sing() method = override.
 This means "I know this method was implemented by my parent class, but I want to change it for this subclass."
 
 It also allows Swift to check your code: if you don't use override Swift won't let you change a method you got from your superclass, or if you use override and there wasn't anything to override, Swift will point out your error
 */


class HeavyMetalSinger: Singer {
    var noiseLevel: Int
    
    init(name: String, age: Int, noiseLevel: Int) {
        self.noiseLevel = noiseLevel // set our own property first
        super.init(name: name, age: age) // calls a method from the parent class
    }
    
    override func sing() {
        print("Raaaaaaargh!")
    }
}
// initializer takes three parameters, then calls super.init() to pass name and age on to the Singer superclass - but only after its own property has been set

/*
If Apple’s operating system calls your Swift class’s method, you need to mark it with a special attribute:

@objc for individual methods
@objc func sing()
 
or

you can use @objcMembers before your class to automatically make all its methods available to Objective-C
@objcMembers class Person
 */
