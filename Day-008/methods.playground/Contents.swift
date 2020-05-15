import UIKit

// Methods
/*
Structs can have functions inside them, and those functions can use the properties of the struct as they need to. Functions inside structs are called methods
 */

struct City {
    var population: Int
    
    func collectTaxs() -> Int {
        return population * 1000
    }
}


let Melbourne = City(population: 4_936_000)
Melbourne.collectTaxs()
// That method belongs to the struct, so we call it on instances of the struct
