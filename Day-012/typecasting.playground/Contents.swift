import UIKit

// Typecasting
/*
 Swift must always know the type of each of your variables
 
Swift can see both Fish and Dog inherit from the Animal class, so it uses type inference to make pets an array of Animal
 */


class Animal { }
class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}



let pets = [Fish(), Dog(), Fish(), Dog()]
// Array of type Animal


for pet in pets {
    if let dog = pet as? Dog { // checks for type Dog
        dog.makeNoise()
    }
}
// looping through array of pets and for each pet item in array if it is a type Dog object it runs makeNoise function

// as? returns an optional: it will be nil if the typecast failed, or a converted type otherwise

