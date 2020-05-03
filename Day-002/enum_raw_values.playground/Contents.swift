import UIKit

// Enum raw values

/*
 Sometimes you need to be able to assign values to enums so they have meaning. This lets you create them dynamically, and also use them in different ways
 */

enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
    
}

/*
 Swift will automatically assign each of those a number starting from 0, and you can use that number to create an instance of the appropriate enum case. For example, earth will be given the number 2
*/

let earth = Planet(rawValue: 2)
// case assign values and swift will assign rest

enum Planet2: Int {
    case mercury = 1
    case venus
    case earth
    case mars
    
}
// Swift will assigning 1 to mercury and count up form there
// So earth will now be 3
