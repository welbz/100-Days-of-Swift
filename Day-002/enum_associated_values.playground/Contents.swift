import UIKit

// Enum associated values

/*
 Enums can also store associated values attached to each case.
 This lets you attach additional information to your enums so they can represent more nuanced data
 */


enum ActivitySimple {
    case bored
    case runnning
    case talking
    case singing
}

enum ActivityAssociatedValues {
    case bored
    case runnning(desitination: String)
    case talking(topic: String)
    case singing(volune: Int)
}

let talking = ActivityAssociatedValues.talking(topic: "AFL")
// dot syntax
